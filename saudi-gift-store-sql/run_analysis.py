"""Reproduce the SQLite analysis locally. Requires Python 3; no extra packages."""
from pathlib import Path
import sqlite3
import re

BASE = Path(__file__).resolve().parent


def run():
    db = sqlite3.connect(':memory:')
    db.executescript((BASE / 'schema.sql').read_text(encoding='utf-8'))
    assert not db.execute('PRAGMA foreign_key_check').fetchall()
    assert db.execute('PRAGMA integrity_check').fetchone()[0] == 'ok'
    statements = [s.strip() for s in re.split(r'(?=^-- Q\d{2}:)', (BASE / 'analysis.sql').read_text(encoding='utf-8'), flags=re.MULTILINE) if s.strip()]
    assert len(statements) == 12
    output = ['# SQL Results', '', 'Reproduced from synthetic data using SQLite.', '']
    results = []
    for query in statements:
        heading = query.splitlines()[0].removeprefix('-- ')
        cursor = db.execute(query)
        columns = [col[0] for col in cursor.description]
        rows = cursor.fetchall()
        results.append(rows)
        output += [f'## {heading}', '', '| ' + ' | '.join(columns) + ' |', '| ' + ' | '.join(['---'] * len(columns)) + ' |']
        for row in rows:
            output.append('| ' + ' | '.join('NULL' if value is None else str(value) for value in row) + ' |')
        output.append('')
    # Business-relevant checks: arithmetic, reconciliations, combined channels,
    # ranking changes, and missing-data behavior.
    assert results[0][0] == ('2026-08', 420000, 1240, 338.71)
    assert results[0][1] == ('2026-09', 505000, 1430, 353.15)
    assert results[1][0] == ('2026-09', 85000, 20.24, 190, 15.32)
    assert results[2][0][0] == 'Personalized gifts'
    assert sum(row[3] for row in results[2]) == 85000
    assert results[3][0][1] == 'Flowers' and results[3][5][1] == 'Flowers'
    assert results[3][4][1] == 'Corporate gifts' and results[3][9][1] == 'Perfumes'
    assert [row[3] for row in results[6]] == [85000, 97000]
    assert results[8][0] == (130, 16.67, -20, -4.65)
    assert sum(row[1] for row in results[9]) == 186
    assert results[9][0] == ('Late delivery', 62, 33.33)
    assert len(results[10]) == 6 and all(row[-1] == 0 for row in results[10])
    assert len(results[11]) == 2 and all(row[1:]==(None,None,'Not available') for row in results[11])
    (BASE / 'results.md').write_text('\n'.join(output), encoding='utf-8')
    print('PASS: 12 SQL queries executed; integrity and business checks passed.')
    print('Saved results.md')
    db.close()


if __name__ == '__main__':
    run()
