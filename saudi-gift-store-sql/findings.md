# Findings and Limitations

## Verified results

- Revenue rose from SAR 420,000 to SAR 505,000: +SAR 85,000, or **20.24%**.
- Orders rose from 1,240 to 1,430: +190, or **15.32%**.
- Average order value rose from SAR 338.71 to SAR 353.15, approximately **4.26%**.
- Personalized gifts contributed the largest absolute product increase: SAR 26,000, or **30.59% of total revenue growth**. Flowers had the highest revenue in both months.
- Riyadh contributed the largest city increase: SAR 40,000. Abha had the largest percentage city increase (34.88%); absolute increase and percentage growth describe different things.
- Website revenue exceeded the combined Instagram/WhatsApp revenue by SAR 85,000 in August and SAR 97,000 in September. This does not establish superior conversion, profitability, or Instagram-only performance.
- New customers increased by 130 (**16.67%**); repeat customers declined by 20 (**4.65%**). Repeat customers' share of reported customers fell from **35.54% to 31.06%**. This is customer mix, not a cohort retention rate.
- Late delivery accounted for 62 of 186 complaints (**33.33%**). Complaints have no monthly or order-level identifiers, so city-specific complaint rates or changes over time cannot be calculated.
- All six monthly product/city/channel totals reconcile exactly to reported revenue. Taif data is unavailable, not zero.

## Recommendations

1. Investigate delivery reliability, inventory availability, and personalization quality. The conversation suggests operational problems; the SQL complaint distribution supports prioritizing delivery, but does not prove that delays caused the decline in repeat customers.
2. Collect profit margins, discount costs, acquisition costs, and customer purchase histories before changing promotion spending. Revenue growth alone does not establish improved profit or retention.

## Data needed next

An order-level dataset with order IDs, dates, customer IDs, city, channel, item quantities, discounts, cost of goods, refunds, and promised/actual delivery timestamps. Cohort retention requires tracking the same customers over time. Do not infer these fields from monthly totals.

## Provenance

The figures originate from a fictional conversation supplied for a portfolio exercise. AI assistance was used to prepare the SQL and interpretation; the included runner executes the queries and validates key results. Learning and explaining the queries remains part of the project.
