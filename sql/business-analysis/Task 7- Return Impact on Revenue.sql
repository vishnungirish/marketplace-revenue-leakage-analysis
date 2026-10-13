-- ============================================================
-- TASK 7: RETURN IMPACT ON REVENUE
-- ============================================================

SELECT
    COUNT(*) AS return_records,
    COUNT(DISTINCT order_id) AS unique_returned_orders
FROM returns
WHERE return_flag = 'Y';


SELECT
    COUNT(o.order_id) AS returned_orders,
    SUM(o.quantity * o.selling_price) AS revenue_lost,
    SUM(o.quantity * (o.selling_price - p.cost_price)) AS profit_lost
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
JOIN (
    SELECT DISTINCT order_id
    FROM returns
    WHERE return_flag = 'Y'
) r
    ON o.order_id = r.order_id;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • A total of 1,290 unique orders were returned.
-- • Returned orders resulted in a revenue loss of 3,685,054.00.
-- • The corresponding gross profit loss was 1,933,515.00.
-- • Duplicate return records were removed before analysis to ensure 
--   each returned order was counted only once, providing accurate revenue and profit estimates.
