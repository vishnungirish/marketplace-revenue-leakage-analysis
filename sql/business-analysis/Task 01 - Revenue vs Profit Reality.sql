-- Task 1: Revenue vs Profit Reality

SELECT
    SUM(o.quantity * o.selling_price) AS total_sales_revenue,
    SUM(o.quantity * p.cost_price) AS total_cost,
    SUM((o.quantity * o.selling_price) -
        (o.quantity * p.cost_price)) AS total_profit
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;
    
    -- ============================================================
-- Result / Business Insight
-- ============================================================
-- • Total marketplace sales revenue is 62,826,732.
-- • Total product cost is 30,321,263.
-- • Gross profit generated is 32,505,469.
-- • The marketplace is generating positive gross profit before
--   considering discounts, returns, logistics costs and
--   payment gateway fees.