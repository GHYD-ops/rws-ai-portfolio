-- Q01: Monthly revenue, orders, and average order value.
SELECT month, revenue_sar, orders,
       ROUND(1.0 * revenue_sar / orders, 2) AS average_order_value_sar
FROM months ORDER BY month;

-- Q02: Revenue and order growth, using a CTE and LAG.
WITH previous AS (
 SELECT *, LAG(revenue_sar) OVER (ORDER BY month) AS prior_revenue,
           LAG(orders) OVER (ORDER BY month) AS prior_orders
 FROM months
)
SELECT month, revenue_sar - prior_revenue AS revenue_change_sar,
 ROUND(100.0 * (revenue_sar - prior_revenue) / NULLIF(prior_revenue,0),2) AS revenue_growth_pct,
 orders - prior_orders AS order_change,
 ROUND(100.0 * (orders - prior_orders) / NULLIF(prior_orders,0),2) AS order_growth_pct
FROM previous WHERE prior_revenue IS NOT NULL;

-- Q03: Product growth and contribution to the total revenue increase.
WITH growth AS (
 SELECT b.product, a.revenue_sar AS august_sar, b.revenue_sar AS september_sar,
        b.revenue_sar - a.revenue_sar AS increase_sar
 FROM product_sales a JOIN product_sales b ON a.product = b.product
 WHERE a.month = '2026-08' AND b.month = '2026-09'
)
SELECT *, ROUND(100.0 * increase_sar / NULLIF(august_sar,0),2) AS growth_pct,
 ROUND(100.0 * increase_sar / SUM(increase_sar) OVER (),2) AS share_of_total_increase_pct
FROM growth ORDER BY increase_sar DESC, product;

-- Q04: Product ranking by revenue, independently within each month.
SELECT month, product, revenue_sar,
 DENSE_RANK() OVER (PARTITION BY month ORDER BY revenue_sar DESC) AS revenue_rank
FROM product_sales ORDER BY month, revenue_rank, product;

-- Q05: City comparison, using conditional aggregation.
SELECT city,
 SUM(CASE WHEN month='2026-08' THEN revenue_sar ELSE 0 END) AS august_sar,
 SUM(CASE WHEN month='2026-09' THEN revenue_sar ELSE 0 END) AS september_sar,
 SUM(CASE WHEN month='2026-09' THEN revenue_sar ELSE -revenue_sar END) AS increase_sar
FROM city_sales GROUP BY city ORDER BY increase_sar DESC, city;

-- Q06: Channel share; each channel is joined to its own monthly total.
SELECT c.month, c.channel, c.revenue_sar,
 ROUND(100.0 * c.revenue_sar / m.revenue_sar,2) AS revenue_share_pct
FROM channel_sales c JOIN months m ON c.month=m.month
ORDER BY c.month, c.revenue_sar DESC;

-- Q07: Website versus the COMBINED Instagram/WhatsApp channel.
SELECT month,
 SUM(CASE WHEN channel='Website' THEN revenue_sar ELSE 0 END) AS website_sar,
 SUM(CASE WHEN channel='Instagram and WhatsApp' THEN revenue_sar ELSE 0 END) AS social_sar,
 SUM(CASE WHEN channel='Website' THEN revenue_sar
          WHEN channel='Instagram and WhatsApp' THEN -revenue_sar ELSE 0 END) AS website_gap_sar
FROM channel_sales GROUP BY month ORDER BY month;

-- Q08: Customer mix. This is NOT a cohort retention rate.
SELECT month, new_customers, repeat_customers,
 ROUND(100.0 * repeat_customers / (new_customers+repeat_customers),2) AS repeat_share_of_reported_customers_pct
FROM months ORDER BY month;

-- Q09: Changes in new and repeat customer counts.
SELECT b.new_customers-a.new_customers AS new_customer_change,
 ROUND(100.0*(b.new_customers-a.new_customers)/a.new_customers,2) AS new_customer_growth_pct,
 b.repeat_customers-a.repeat_customers AS repeat_customer_change,
 ROUND(100.0*(b.repeat_customers-a.repeat_customers)/a.repeat_customers,2) AS repeat_customer_growth_pct
FROM months a JOIN months b ON a.month='2026-08' AND b.month='2026-09';

-- Q10: Complaint distribution, for the combined two-month period.
SELECT category, cases,
 ROUND(100.0 * cases / SUM(cases) OVER (),2) AS share_of_complaints_pct
FROM complaints ORDER BY cases DESC, category;

-- Q11: Reconcile each independent revenue breakdown to its monthly total.
WITH breakdowns AS (
 SELECT 'product' AS dimension, month, SUM(revenue_sar) AS breakdown_total FROM product_sales GROUP BY month
 UNION ALL
 SELECT 'city', month, SUM(revenue_sar) FROM city_sales GROUP BY month
 UNION ALL
 SELECT 'channel', month, SUM(revenue_sar) FROM channel_sales GROUP BY month
)
SELECT b.dimension, b.month, b.breakdown_total, m.revenue_sar AS reported_total,
 b.breakdown_total-m.revenue_sar AS difference_sar
FROM breakdowns b JOIN months m ON b.month=m.month ORDER BY b.dimension,b.month;

-- Q12: Taif has no reported row. Do not silently treat missing data as zero.
SELECT m.month, c.city, c.revenue_sar,
 CASE WHEN c.city IS NULL THEN 'Not available' ELSE 'Reported' END AS data_status
FROM months m LEFT JOIN city_sales c ON m.month=c.month AND c.city='Taif'
ORDER BY m.month;
