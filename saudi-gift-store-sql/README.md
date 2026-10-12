# Saudi Gift Store SQL Analysis

AI-assisted self-directed learning project | Ghaida Mohammed Althobaiti | 2026

## Purpose

Use SQL to check and extend a bilingual business-conversation simulation about a fictional Saudi online gift store. All numbers are synthetic training data, not actual company or customer information. The SQL and documentation were prepared with AI assistance and executed against SQLite. This is a learning portfolio sample, not employment or client work.

## Dataset and scope

The dataset contains two months (August and September 2026), five product categories, four cities, four sales channels, customer counts, and six complaint categories. The year is a scenario label chosen for this project. Revenue amounts are SAR.

Product, city, and channel tables are **separate monthly breakdowns of the same revenue**. Adding them together would triple-count sales. They do not contain individual orders or product-by-city-by-channel combinations. Instagram and WhatsApp are reported together; Instagram-only performance cannot be measured. Complaint counts cover both months combined.

## Files

- [schema.sql](schema.sql): constrained tables and synthetic seed data
- [analysis.sql](analysis.sql): 12 commented SQL queries
- [run_analysis.py](run_analysis.py): reproducible execution and validation
- [results.md](results.md): actual query outputs
- [findings.md](findings.md): business interpretation and limitations

## Run locally

Python 3 is sufficient. No third-party packages or credentials are needed.

```sh
cd saudi-gift-store-sql
python3 run_analysis.py
```

The script uses an in-memory database and regenerates `results.md`. It does not modify a production database. The SQL targets SQLite with support for window functions.

## SQL concepts demonstrated

SELECT, GROUP BY, SUM, ROUND, CASE, INNER JOIN, LEFT JOIN, common table expressions, UNION ALL, NULLIF, LAG, DENSE_RANK, and window aggregates. Checks cover revenue reconciliation, growth, rankings, complaint totals, and missing-data handling.

## Practice before describing this project in an interview

1. Run the script and compare the outputs with the original conversation.
2. Explain Q03's join and why both months are filtered.
3. Explain why Q06 joins each channel to its monthly total.
4. Explain why Q08 measures customer mix rather than true retention.
5. Explain why Q12 returns NULL for Taif instead of zero.
6. Change the product-growth query to sort by percentage growth and explain the different result.

## Related project

[Bilingual AI Conversation Evaluation](https://github.com/GHYD-ops/rws-ai-portfolio)
