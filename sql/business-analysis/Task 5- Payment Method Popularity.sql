-- ============================================================
-- TASK 5: PAYMENT METHOD POPULARITY
-- ============================================================

SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity * selling_price) AS total_sales
FROM orders
GROUP BY payment_method
ORDER BY total_sales DESC;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • INVALID is the most frequently recorded payment method and
--   generated the highest sales value.
-- • Among the valid payment methods, UPI generated the highest
--   sales revenue.
-- • Sales are fairly evenly distributed across UPI, Wallet,
--   COD and Card.
-- • The presence of a large number of INVALID payment methods
--   indicates a data quality issue that should be investigated.