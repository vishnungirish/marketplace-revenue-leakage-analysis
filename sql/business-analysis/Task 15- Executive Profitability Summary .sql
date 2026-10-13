-- ============================================================
-- TASK 15: EXECUTIVE PROFITABILITY SUMMARY
-- ============================================================

SELECT

    (
        SELECT SUM(quantity * selling_price)
        FROM orders
    ) AS total_sales,


    (
        SELECT SUM(
            o.quantity * (o.selling_price - p.cost_price)
        )
        FROM orders o
        JOIN products p
            ON o.product_id = p.product_id
    ) AS total_profit,


    (
        SELECT SUM(discount_amount)
        FROM discounts
    ) AS total_discounts,


    (
        SELECT SUM(o.quantity * o.selling_price)
        FROM orders o
        JOIN
        (
            SELECT DISTINCT order_id
            FROM returns
            WHERE return_flag = 'Y'
        ) r
            ON o.order_id = r.order_id
    ) AS total_returns_loss,


    (
        SELECT SUM(
            shipping_cost + reverse_shipping_cost
        )
        FROM logistics_cost
    ) AS total_logistics_cost,


    ROUND((
        SELECT SUM(
            (o.quantity * o.selling_price) *
            (pf.fee_percentage / 100)
        )
        FROM orders o
        JOIN payment_fees pf
            ON o.payment_method = pf.payment_method
    ),2) AS total_payment_fees;
    
    -- ============================================================
-- Result / Business Insight
-- ============================================================
-- • The marketplace generated total sales of 62,826,732.00 and
--   a gross product profit of 32,505,469.00, indicating strong
--   overall sales performance.
--
-- • Discounts were the largest source of profitability leakage,
--   amounting to 5,732,831.00, followed by returns, which
--   resulted in revenue losses of 3,685,054.00.
--
-- • Logistics costs (1,191,826.00) and payment processing fees
--   (1,098,310.53) further reduced the profitability of the
--   marketplace.
--
-- • Although sales performance was strong, the combined impact
--   of discounts, returns, logistics expenses, and payment
--   processing fees significantly reduced the profit retained by
--   the business.
--
-- • To improve profitability, management should optimise
--   discount strategies, reduce avoidable returns, improve
--   logistics efficiency, and encourage lower-cost payment
--   methods such as UPI.