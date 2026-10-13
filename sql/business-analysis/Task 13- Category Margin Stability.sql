-- ============================================================
-- TASK 13: CATEGORY MARGIN STABILITY
-- ============================================================

SELECT
    p.category,

    ROUND(AVG(
        ((o.selling_price - p.cost_price) / o.selling_price) * 100
    ),2) AS average_profit_margin,

    ROUND(STDDEV(
        ((o.selling_price - p.cost_price) / o.selling_price) * 100
    ),2) AS margin_variation

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY
    p.category

ORDER BY
    margin_variation DESC;
    
    -- ============================================================
-- Result / Business Insight
-- ============================================================
-- • Fashion showed the highest variation in profit margins
--   (63.67), indicating the least consistent profitability
--   across orders.
-- • Electronics had the lowest margin variation (59.61),
--   suggesting more stable pricing and cost management than
--   the other categories.
-- • The average profit margins across all categories ranged
--   from approximately 32.85% to 36.71%, indicating that
--   average profitability is relatively similar despite
--   differences in margin stability.
-- • Categories with higher margin variation should be reviewed
--   for inconsistent pricing, discounting, or procurement
--   costs to improve margin consistency.