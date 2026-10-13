-- ============================================================
-- TASK 6: DISCOUNT VS PROFIT GAP
-- ============================================================

SELECT
    CASE
        WHEN d.order_id IS NOT NULL THEN 'Discounted'
        ELSE 'Non-Discounted'
    END AS order_type,

    COUNT(o.order_id) AS total_orders,

    ROUND(AVG(o.quantity * (o.selling_price - p.cost_price)),2) AS average_profit_per_order

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

LEFT JOIN
(
    SELECT DISTINCT order_id
    FROM discounts
) d
    ON o.order_id = d.order_id

GROUP BY order_type;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • 7,417 orders received at least one discount, while 14,583
--   orders were not discounted.
-- • Discounted orders generated an average gross profit of
--   1,492.71 per order.
-- • Non-discounted orders generated an average gross profit of
--   1,469.80 per order.
-- • In this dataset, discounted orders show a slightly higher
--   average gross profit than non-discounted orders.