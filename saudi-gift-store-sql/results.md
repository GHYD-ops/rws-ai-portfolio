# SQL Results

Reproduced from synthetic data using SQLite.

## Q01: Monthly revenue, orders, and average order value.

| month | revenue_sar | orders | average_order_value_sar |
| --- | --- | --- | --- |
| 2026-08 | 420000 | 1240 | 338.71 |
| 2026-09 | 505000 | 1430 | 353.15 |

## Q02: Revenue and order growth, using a CTE and LAG.

| month | revenue_change_sar | revenue_growth_pct | order_change | order_growth_pct |
| --- | --- | --- | --- | --- |
| 2026-09 | 85000 | 20.24 | 190 | 15.32 |

## Q03: Product growth and contribution to the total revenue increase.

| product | august_sar | september_sar | increase_sar | growth_pct | share_of_total_increase_pct |
| --- | --- | --- | --- | --- | --- |
| Personalized gifts | 92000 | 118000 | 26000 | 28.26 | 30.59 |
| Flowers | 105000 | 125000 | 20000 | 19.05 | 23.53 |
| Corporate gifts | 67000 | 85000 | 18000 | 26.87 | 21.18 |
| Chocolate | 80000 | 93000 | 13000 | 16.25 | 15.29 |
| Perfumes | 76000 | 84000 | 8000 | 10.53 | 9.41 |

## Q04: Product ranking by revenue, independently within each month.

| month | product | revenue_sar | revenue_rank |
| --- | --- | --- | --- |
| 2026-08 | Flowers | 105000 | 1 |
| 2026-08 | Personalized gifts | 92000 | 2 |
| 2026-08 | Chocolate | 80000 | 3 |
| 2026-08 | Perfumes | 76000 | 4 |
| 2026-08 | Corporate gifts | 67000 | 5 |
| 2026-09 | Flowers | 125000 | 1 |
| 2026-09 | Personalized gifts | 118000 | 2 |
| 2026-09 | Chocolate | 93000 | 3 |
| 2026-09 | Corporate gifts | 85000 | 4 |
| 2026-09 | Perfumes | 84000 | 5 |

## Q05: City comparison, using conditional aggregation.

| city | august_sar | september_sar | increase_sar |
| --- | --- | --- | --- |
| Riyadh | 190000 | 230000 | 40000 |
| Jeddah | 112000 | 130000 | 18000 |
| Abha | 43000 | 58000 | 15000 |
| Dammam | 75000 | 87000 | 12000 |

## Q06: Channel share; each channel is joined to its own monthly total.

| month | channel | revenue_sar | revenue_share_pct |
| --- | --- | --- | --- |
| 2026-08 | Website | 210000 | 50.0 |
| 2026-08 | Instagram and WhatsApp | 125000 | 29.76 |
| 2026-08 | External marketplaces | 55000 | 13.1 |
| 2026-08 | Direct corporate sales | 30000 | 7.14 |
| 2026-09 | Website | 247000 | 48.91 |
| 2026-09 | Instagram and WhatsApp | 150000 | 29.7 |
| 2026-09 | External marketplaces | 62000 | 12.28 |
| 2026-09 | Direct corporate sales | 46000 | 9.11 |

## Q07: Website versus the COMBINED Instagram/WhatsApp channel.

| month | website_sar | social_sar | website_gap_sar |
| --- | --- | --- | --- |
| 2026-08 | 210000 | 125000 | 85000 |
| 2026-09 | 247000 | 150000 | 97000 |

## Q08: Customer mix. This is NOT a cohort retention rate.

| month | new_customers | repeat_customers | repeat_share_of_reported_customers_pct |
| --- | --- | --- | --- |
| 2026-08 | 780 | 430 | 35.54 |
| 2026-09 | 910 | 410 | 31.06 |

## Q09: Changes in new and repeat customer counts.

| new_customer_change | new_customer_growth_pct | repeat_customer_change | repeat_customer_growth_pct |
| --- | --- | --- | --- |
| 130 | 16.67 | -20 | -4.65 |

## Q10: Complaint distribution, for the combined two-month period.

| category | cases | share_of_complaints_pct |
| --- | --- | --- |
| Late delivery | 62 | 33.33 |
| Product differed from photos | 38 | 20.43 |
| Personalization errors | 31 | 16.67 |
| Damaged packaging | 24 | 12.9 |
| Stock-outs or cancellations | 18 | 9.68 |
| Wrong item or address | 13 | 6.99 |

## Q11: Reconcile each independent revenue breakdown to its monthly total.

| dimension | month | breakdown_total | reported_total | difference_sar |
| --- | --- | --- | --- | --- |
| channel | 2026-08 | 420000 | 420000 | 0 |
| channel | 2026-09 | 505000 | 505000 | 0 |
| city | 2026-08 | 420000 | 420000 | 0 |
| city | 2026-09 | 505000 | 505000 | 0 |
| product | 2026-08 | 420000 | 420000 | 0 |
| product | 2026-09 | 505000 | 505000 | 0 |

## Q12: Taif has no reported row. Do not silently treat missing data as zero.

| month | city | revenue_sar | data_status |
| --- | --- | --- | --- |
| 2026-08 | NULL | NULL | Not available |
| 2026-09 | NULL | NULL | Not available |
