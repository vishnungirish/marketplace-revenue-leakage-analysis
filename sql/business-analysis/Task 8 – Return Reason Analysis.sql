-- ============================================================
-- TASK 8: RETURN REASON ANALYSIS
-- ============================================================

SELECT
    return_reason,
    COUNT(*) AS total_returns
FROM returns
GROUP BY return_reason
ORDER BY total_returns DESC;

SELECT
    r.return_reason,
    COUNT(*) AS total_returns,
    SUM(o.quantity * o.selling_price) AS revenue_lost
FROM returns r
JOIN orders o
    ON r.order_id = o.order_id
WHERE r.return_flag = 'Y'
GROUP BY r.return_reason
ORDER BY revenue_lost DESC;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • 'Unknown' was the most common return reason, accounting
--   for 242 returns and revenue loss of 714,716.00.
-- • 'Damaged' products resulted in the second-highest revenue
--   loss (636,370.00), indicating a need to improve packaging
--   and product handling.
-- • 'Quality Issue' and 'Customer Changed Mind' also
--   contributed significantly to revenue leakage and should be
--   investigated further.
-- • 'Wrong Item' and 'Late Delivery' suggest operational
--   inefficiencies in order fulfillment and logistics.
-- • The large number of 'Unknown' return reasons indicates a
--   data quality issue, as missing or unclear return reasons
--   make root-cause analysis more difficult.