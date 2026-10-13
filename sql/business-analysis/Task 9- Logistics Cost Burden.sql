-- ============================================================
-- TASK 9: LOGISTICS COST BURDEN
-- ============================================================

SELECT
    o.order_id,
    p.category,
    (o.quantity * o.selling_price) AS order_value,
    (l.shipping_cost + l.reverse_shipping_cost) AS total_logistics_cost
FROM orders o
JOIN logistics_cost l
    ON o.order_id = l.order_id
JOIN products p
    ON o.product_id = p.product_id
WHERE
    (l.shipping_cost + l.reverse_shipping_cost) >
    (0.20 * (o.quantity * o.selling_price))
ORDER BY total_logistics_cost DESC;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • Orders with logistics costs exceeding 20% of their order
--   value were identified as expensive-to-fulfill orders.
-- • Several low-value orders incurred disproportionately high
--   logistics costs, reducing overall profitability.
-- • One order had an order value of 0.00 but incurred a
--   logistics cost of 241.00, representing a complete logistics
--   expense without any corresponding sales revenue.
-- • The business should consider introducing minimum order
--   values, delivery charges, or optimizing shipping
--   strategies to reduce high fulfillment costs.