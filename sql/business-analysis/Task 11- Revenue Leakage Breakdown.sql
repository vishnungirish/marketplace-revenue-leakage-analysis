-- ============================================================
-- TASK 11: REVENUE LEAKAGE BREAKDOWN
-- ============================================================


SELECT
    order_id,
    COUNT(*) AS records
FROM logistics_cost
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
    o.order_id,

    COALESCE(d.total_discount, 0) AS discount_loss,

    CASE
        WHEN r.order_id IS NOT NULL
        THEN (o.quantity * o.selling_price)
        ELSE 0
    END AS return_loss,

    COALESCE(l.logistics_loss, 0) AS logistics_loss,

    ROUND(((o.quantity * o.selling_price) * (pf.fee_percentage / 100)),2)
        AS payment_fee_loss

FROM orders o

LEFT JOIN
(
    SELECT
        order_id,
        SUM(discount_amount) AS total_discount
    FROM discounts
    GROUP BY order_id
) d
ON o.order_id = d.order_id

LEFT JOIN
(
    SELECT DISTINCT order_id
    FROM returns
    WHERE return_flag = 'Y'
) r
ON o.order_id = r.order_id

LEFT JOIN
(
    SELECT
        order_id,
        SUM(shipping_cost + reverse_shipping_cost) AS logistics_loss
    FROM logistics_cost
    GROUP BY order_id
) l
ON o.order_id = l.order_id

JOIN payment_fees pf
ON o.payment_method = pf.payment_method

ORDER BY o.order_id;

-- ============================================================
-- OVERALL REVENUE LEAKAGE SUMMARY
-- ============================================================

SELECT
    SUM(COALESCE(d.total_discount, 0)) AS total_discount_loss,

    SUM(
        CASE
            WHEN r.order_id IS NOT NULL
            THEN (o.quantity * o.selling_price)
            ELSE 0
        END
    ) AS total_return_loss,

    SUM(COALESCE(l.logistics_loss, 0)) AS total_logistics_loss,

    ROUND(SUM(
        (o.quantity * o.selling_price) *
        (pf.fee_percentage / 100)
    ),2) AS total_payment_fee_loss

FROM orders o

LEFT JOIN
(
    SELECT
        order_id,
        SUM(discount_amount) AS total_discount
    FROM discounts
    GROUP BY order_id
) d
    ON o.order_id = d.order_id

LEFT JOIN
(
    SELECT DISTINCT order_id
    FROM returns
    WHERE return_flag = 'Y'
) r
    ON o.order_id = r.order_id

LEFT JOIN
(
    SELECT
        order_id,
        SUM(shipping_cost + reverse_shipping_cost) AS logistics_loss
    FROM logistics_cost
    GROUP BY order_id
) l
    ON o.order_id = l.order_id

JOIN payment_fees pf
    ON o.payment_method = pf.payment_method;
    
    -- ============================================================
-- Result / Business Insight
-- ============================================================
-- • Discounts were the largest source of revenue leakage,
--   amounting to 4,567,885.00.
-- • Returns caused the second-highest financial loss
--   (2,951,183.00), indicating a significant impact on revenue.
-- • Payment gateway fees contributed a total leakage of
--   1,098,310.53, while logistics costs accounted for
--   954,869.00.
-- • Since discounts account for the highest overall leakage,
--   the business should review its discount strategy to ensure
--   promotions generate sufficient additional sales to justify
--   the revenue sacrificed.
-- • Reducing unnecessary returns and encouraging lower-cost
--   payment methods can further improve overall profitability.
-- • Some orders had no matching logistics records and were
--   therefore assigned a logistics loss of 0 using COALESCE.
--   This indicates a possible data completeness issue and may
--   cause total logistics leakage to be underestimated.
    





