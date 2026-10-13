-- ============================================================
-- TASK 10: PAYMENT FEE LEAKAGE
-- ============================================================

SELECT
    o.payment_method,
    pf.fee_percentage,

    SUM(o.quantity * o.selling_price) AS total_sales,

    ROUND(SUM(
        (o.quantity * o.selling_price) *
        (pf.fee_percentage / 100)
    ),2) AS total_payment_fee,

    SUM(
        o.quantity * (o.selling_price - p.cost_price)
    ) AS gross_profit,

    SUM(
        o.quantity * (o.selling_price - p.cost_price)
    )
    -
    ROUND(SUM(
        (o.quantity * o.selling_price) *
        (pf.fee_percentage / 100)
    ),2) AS net_profit

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

JOIN payment_fees pf
    ON o.payment_method = pf.payment_method

GROUP BY
    o.payment_method,
    pf.fee_percentage

ORDER BY total_payment_fee DESC;

-- ============================================================
-- Result / Business Insight
-- ============================================================
-- • COD generated the highest total payment gateway fee
--   (437,274.08) due to its highest fee percentage (3.50%),
--   resulting in the largest reduction in net profit.
-- • Although UPI processed the highest total sales
--   (12,673,196.00), its low fee percentage (1.20%) resulted
--   in the lowest payment fee among the major payment methods,
--   preserving the highest net profit.
-- • CARD and WALLET incurred moderate payment gateway fees
--   because of their fee percentages of 2.10% and 2.00%
--   respectively.
-- • Promoting lower-fee payment methods such as UPI can help
--   reduce payment processing costs and improve overall
--   profitability.
-- • Orders with INVALID payment methods were excluded because
--   no corresponding payment fee percentage was available.