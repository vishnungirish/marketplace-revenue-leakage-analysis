-- ============================================================
-- TASK 12: PRODUCT PROFIT RANKING
-- ============================================================

SELECT
    p.product_id,
    p.category,
    p.brand,

    SUM(o.quantity * o.selling_price) AS total_sales,

    SUM(o.quantity * (o.selling_price - p.cost_price))
        AS net_profit

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY
    p.product_id,
    p.category,
    p.brand

ORDER BY net_profit DESC;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • Products were ranked based on their total net profit
--   contribution from highest to lowest.
-- • Product ID 1640 (Electronics) was the highest-performing
--   product, contributing a net profit of 64,215.00.
-- • The top-ranking products were spread across Electronics,
--   Home, Beauty, and Grocery categories, indicating that
--   profitability is not limited to a single product category.
-- • Product ID 36 (Fashion) generated the lowest net profit
--   contribution (14,570.00) among all products.
-- • High-profit products should be prioritised for inventory,
--   marketing, and promotional campaigns, while low-performing
--   products should be reviewed for pricing, sourcing costs,
--   or product assortment decisions.