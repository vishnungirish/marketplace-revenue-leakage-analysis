select * from orders limit 10;

-- ============================================================
-- TASK 3: LOSS-MAKING PRODUCTS
-- ============================================================

SELECT
    p.product_id,
    p.category,
    p.brand,
    p.mrp,
    SUM(o.quantity * o.selling_price) AS total_sales,
    SUM(o.quantity * p.cost_price) AS total_cost,
    SUM(o.quantity * (o.selling_price - p.cost_price)) AS total_profit
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    p.product_id,
    p.category,
    p.brand,
    p.mrp
HAVING total_profit < 0
ORDER BY total_profit;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • 71 products generated an overall negative gross profit.
-- • These products cost more to procure than the revenue earned
--   from selling them.
-- • These products should be reviewed for pricing, supplier costs,
--   or discontinuation.
-- • Further investigation is required to determine whether the
--   losses are caused by pricing strategy, procurement cost, or
--   frequent discounting.