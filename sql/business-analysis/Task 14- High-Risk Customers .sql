-- ============================================================
-- TASK 14: HIGH-RISK CUSTOMERS
-- ============================================================

SELECT
    o.customer_id,

    COUNT(o.order_id) AS total_orders,

    COUNT(r.order_id) AS returned_orders,

    ROUND(
        (COUNT(r.order_id) * 100.0) / COUNT(o.order_id),
        2
    ) AS customer_return_rate,

    (
        SELECT ROUND(
            (COUNT(DISTINCT order_id) * 100.0) /
            (SELECT COUNT(*) FROM orders),
            2
        )
        FROM returns
        WHERE return_flag = 'Y'
    ) AS marketplace_return_rate

FROM orders o

LEFT JOIN
(
    SELECT DISTINCT order_id
    FROM returns
    WHERE return_flag = 'Y'
) r
ON o.order_id = r.order_id

GROUP BY o.customer_id

HAVING customer_return_rate >
(
    SELECT ROUND(
        (COUNT(DISTINCT order_id) * 100.0) /
        (SELECT COUNT(*) FROM orders),
        2
    )
    FROM returns
    WHERE return_flag = 'Y'
)

ORDER BY customer_return_rate DESC;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • Customers whose return rates exceeded the marketplace
--   average return rate of 5.86% were identified as
--   high-risk customers.
--
-- • Several customers recorded a 100.00% return rate,
--   meaning every order they placed was returned.
--
-- • While some customers achieved a high return rate from only
--   one or two orders, customers with consistently high return
--   rates across multiple orders warrant closer monitoring.
--
-- • Identifying these high-risk customers enables the
--   marketplace to strengthen return policy controls, detect
--   potential misuse, and reduce losses associated with
--   excessive product returns.