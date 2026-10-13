-- ============================================================
-- TASK 2: CATEGORY-WISE SALES & PROFIT
-- ============================================================

SELECT
    p.category,
    SUM(o.quantity * o.selling_price) AS total_sales,
    SUM(o.quantity * p.cost_price) AS total_cost,
    SUM(o.quantity * (o.selling_price - p.cost_price)) AS total_profit
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_profit DESC;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • Electronics generated the highest sales revenue and profit.
-- • Fashion is the second most profitable category.
-- • The 'Unknown' category contributed the least revenue and profit,
--   indicating products with missing category information.
-- • All categories generated positive gross profit before considering
--   discounts, returns, logistics costs and payment gateway fees.