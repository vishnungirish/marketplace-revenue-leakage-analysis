-- ============================================================
-- TASK 4: DISCOUNT USAGE OVERVIEW
-- ============================================================

SELECT
    COUNT(DISTINCT order_id) AS discounted_orders,
    SUM(discount_amount) AS total_discount_amount
FROM discounts;


-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • 7,417 unique orders received at least one discount.
-- • The total discount amount applied was 5,732,831.
-- • Multiple discount records exist for some orders.
-- • Discounting is used across a significant number of orders
--   and may reduce overall profit margins.