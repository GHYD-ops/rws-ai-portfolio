-- Fictional monthly aggregates from a bilingual business-conversation simulation.
-- Amounts are SAR. These are three independent views of the same revenue.
PRAGMA foreign_keys = ON;
CREATE TABLE months (
  month TEXT PRIMARY KEY,
  revenue_sar INTEGER NOT NULL CHECK (revenue_sar >= 0),
  orders INTEGER NOT NULL CHECK (orders > 0),
  new_customers INTEGER NOT NULL CHECK (new_customers >= 0),
  repeat_customers INTEGER NOT NULL CHECK (repeat_customers >= 0)
);
CREATE TABLE product_sales (
  month TEXT NOT NULL REFERENCES months(month),
  product TEXT NOT NULL,
  revenue_sar INTEGER NOT NULL CHECK (revenue_sar >= 0),
  PRIMARY KEY (month, product)
);
CREATE TABLE city_sales (
  month TEXT NOT NULL REFERENCES months(month),
  city TEXT NOT NULL,
  revenue_sar INTEGER NOT NULL CHECK (revenue_sar >= 0),
  PRIMARY KEY (month, city)
);
CREATE TABLE channel_sales (
  month TEXT NOT NULL REFERENCES months(month),
  channel TEXT NOT NULL,
  revenue_sar INTEGER NOT NULL CHECK (revenue_sar >= 0),
  PRIMARY KEY (month, channel)
);
CREATE TABLE complaints (
  category TEXT PRIMARY KEY,
  cases INTEGER NOT NULL CHECK (cases >= 0)
);
INSERT INTO months VALUES
 ('2026-08',420000,1240,780,430),
 ('2026-09',505000,1430,910,410);
INSERT INTO product_sales VALUES
 ('2026-08','Flowers',105000),('2026-09','Flowers',125000),
 ('2026-08','Chocolate',80000),('2026-09','Chocolate',93000),
 ('2026-08','Personalized gifts',92000),('2026-09','Personalized gifts',118000),
 ('2026-08','Perfumes',76000),('2026-09','Perfumes',84000),
 ('2026-08','Corporate gifts',67000),('2026-09','Corporate gifts',85000);
INSERT INTO city_sales VALUES
 ('2026-08','Riyadh',190000),('2026-09','Riyadh',230000),
 ('2026-08','Jeddah',112000),('2026-09','Jeddah',130000),
 ('2026-08','Dammam',75000),('2026-09','Dammam',87000),
 ('2026-08','Abha',43000),('2026-09','Abha',58000);
INSERT INTO channel_sales VALUES
 ('2026-08','Website',210000),('2026-09','Website',247000),
 ('2026-08','Instagram and WhatsApp',125000),('2026-09','Instagram and WhatsApp',150000),
 ('2026-08','External marketplaces',55000),('2026-09','External marketplaces',62000),
 ('2026-08','Direct corporate sales',30000),('2026-09','Direct corporate sales',46000);
-- Counts cover both months together; no month/city/channel breakdown is known.
INSERT INTO complaints VALUES
 ('Late delivery',62),('Product differed from photos',38),
 ('Personalization errors',31),('Damaged packaging',24),
 ('Stock-outs or cancellations',18),('Wrong item or address',13);
