-- ============================================================
-- FILE: 05_transform_and_load.sql
-- PROJECT: Marketplace Revenue Leakage & Gap Analysis
-- ============================================================
-- PURPOSE:
-- Transform and load data from the raw staging tables into
-- the final analytical tables.
--
-- ETL RULES APPLIED:
-- 1. Removed leading/trailing spaces.
-- 2. Removed carriage-return and line-feed characters.
-- 3. Converted text fields into appropriate numeric/date types.
-- 4. Replaced missing descriptive values with 'Unknown'.
-- 5. Preserved missing numeric values as NULL.
-- 6. Preserved negative and invalid business values for analysis.
-- 7. Did not invent or alter business facts.
--
-- SCHEMA ADJUSTMENTS:
-- 1. Removed the foreign key between orders.payment_method
--    and payment_fees.payment_method because the source contains
--    the invalid value 'INVALID'.
-- 2. Changed logistics_cost.delivery_days to allow NULL because
--    722 source records have missing delivery-day values.
-- ============================================================



USE marketplace_revenue_analysis;

-- ===================================================
-- PAYMENT FEES
-- ===================================================

INSERT INTO payment_fees
(
    payment_method,
    fee_percentage,
    settlement_days
)
SELECT
    TRIM(payment_method),
    CAST(fee_percentage AS DECIMAL(5,2)),
    CASE
        WHEN TRIM(settlement_days) = '' THEN NULL
        ELSE CAST(settlement_days AS UNSIGNED)
    END
FROM raw_payment_fees;

SELECT *
FROM payment_fees;

SELECT COUNT(*) AS Total_Rows
FROM payment_fees;

-- ===================================================
-- PRODUCTS
-- ===================================================

use marketplace_revenue_analysis;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM products;

SET SQL_SAFE_UPDATES = 1;

SELECT COUNT(*) AS total_products
FROM products;

INSERT INTO products
(
    product_id,
    category,
    sub_category,
    brand,
    supplier_id,
    cost_price,
    mrp,
    weight_kg,
    launch_date
)
SELECT
    CAST(TRIM(product_id) AS UNSIGNED),

    COALESCE(
        NULLIF(TRIM(category), ''),
        'Unknown'
    ),

    COALESCE(
        NULLIF(TRIM(sub_category), ''),
        'Unknown'
    ),

    COALESCE(
        NULLIF(TRIM(brand), ''),
        'Unknown'
    ),

    CAST(TRIM(supplier_id) AS UNSIGNED),

    CAST(TRIM(cost_price) AS DECIMAL(10,2)),

    CAST(TRIM(mrp) AS DECIMAL(10,2)),

    CAST(
        NULLIF(TRIM(weight_kg), '')
        AS DECIMAL(8,2)
    ),

    STR_TO_DATE(
        TRIM(launch_date),
        '%Y-%m-%d'
    )

FROM raw_products;

SELECT
    COUNT(*) AS total_products,
    SUM(category = 'Unknown') AS unknown_categories,
    SUM(sub_category = 'Unknown') AS unknown_sub_categories,
    SUM(brand = 'Unknown') AS unknown_brands,
    SUM(weight_kg IS NULL) AS missing_weights,
    SUM(cost_price < 0) AS negative_cost_prices,
    SUM(cost_price > mrp) AS cost_above_mrp,
    SUM(launch_date IS NULL) AS invalid_launch_dates
FROM products;

-- ============================================
-- ORDERS
-- ============================================

DESCRIBE orders;

DESCRIBE raw_orders;

ALTER TABLE orders
DROP FOREIGN KEY fk_orders_payment_fees;

SHOW CREATE TABLE orders;

INSERT INTO orders
(
    order_id,
    order_date,
    customer_id,
    product_id,
    quantity,
    selling_price,
    order_status,
    payment_method,
    order_channel,
    warehouse_id
)

SELECT
    CAST(TRIM(order_id) AS UNSIGNED),

    STR_TO_DATE(
        TRIM(order_date),
        '%Y-%m-%d'
    ),

    CAST(TRIM(customer_id) AS UNSIGNED),

    CAST(TRIM(product_id) AS UNSIGNED),

    CAST(TRIM(quantity) AS SIGNED),

    CAST(TRIM(selling_price) AS DECIMAL(10,2)),

    COALESCE(
        NULLIF(TRIM(order_status),''),
        'Unknown'
    ),

    TRIM(payment_method),

    COALESCE(
        NULLIF(TRIM(order_channel),''),
        'Unknown'
    ),

    CAST(TRIM(warehouse_id) AS UNSIGNED)

FROM raw_orders;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT
    COUNT(*) AS total_orders,
    SUM(order_status = 'Unknown') AS unknown_status,
    SUM(order_channel = 'Unknown') AS unknown_channel,
    SUM(quantity <= 0) AS invalid_quantity,
    SUM(payment_method = 'INVALID') AS invalid_payment_method
FROM orders;


-- ============================================
-- DISCOUNTS
-- ============================================


DESCRIBE discounts;

DESCRIBE raw_discounts;

INSERT INTO discounts
(
    discount_id,
    order_id,
    discount_amount,
    discount_type,
    coupon_code,
    is_stackable
)

SELECT
    CAST(TRIM(discount_id) AS UNSIGNED),

    CAST(TRIM(order_id) AS UNSIGNED),

    CAST(TRIM(discount_amount) AS DECIMAL(10,2)),

    COALESCE(
        NULLIF(TRIM(discount_type),''),
        'Unknown'
    ),

    NULLIF(
        TRIM(coupon_code),
        ''
    ),

    NULLIF(
        TRIM(is_stackable),
        ''
    )

FROM raw_discounts;

SELECT COUNT(*) AS total_discounts
FROM discounts;

SELECT
    COUNT(*) AS total_discounts,

    SUM(discount_type = 'Unknown') AS unknown_discount_type,

    SUM(coupon_code IS NULL) AS missing_coupon_code,

    SUM(is_stackable IS NULL) AS missing_stackable,

    SUM(is_stackable NOT IN ('Y','N') AND is_stackable IS NOT NULL) AS invalid_stackable

FROM discounts;

SELECT
    is_stackable,
    HEX(is_stackable) AS hex_value,
    COUNT(*) AS row_count
FROM discounts
GROUP BY is_stackable, HEX(is_stackable)
ORDER BY row_count DESC;

SELECT
    is_stackable,
    HEX(is_stackable) AS hex_value,
    COUNT(*) AS row_count
FROM raw_discounts
GROUP BY is_stackable, HEX(is_stackable)
ORDER BY row_count DESC;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM discounts;

INSERT INTO discounts
(
    discount_id,
    order_id,
    discount_amount,
    discount_type,
    coupon_code,
    is_stackable
)
SELECT
    CAST(TRIM(discount_id) AS UNSIGNED),

    CAST(TRIM(order_id) AS UNSIGNED),

    CAST(TRIM(discount_amount) AS DECIMAL(10,2)),

    COALESCE(
        NULLIF(TRIM(discount_type), ''),
        'Unknown'
    ),

    NULLIF(
        TRIM(coupon_code),
        ''
    ),

    NULLIF(
        TRIM(
            REPLACE(
                REPLACE(
                    is_stackable,
                    CHAR(13),
                    ''
                ),
                CHAR(10),
                ''
            )
        ),
        ''
    )

FROM raw_discounts;

SELECT
    COUNT(*) AS total_discounts,
    SUM(discount_type = 'Unknown') AS unknown_discount_type,
    SUM(coupon_code IS NULL) AS missing_coupon_code,
    SUM(is_stackable IS NULL) AS missing_stackable,
    SUM(
        is_stackable NOT IN ('Y', 'N')
        AND is_stackable IS NOT NULL
    ) AS invalid_stackable
FROM discounts;

SET SQL_SAFE_UPDATES = 1;

-- ============================================
-- RETURNS
-- ============================================


DESCRIBE returns;

DESCRIBE raw_returns;

INSERT INTO returns
(
    return_id,
    order_id,
    return_flag,
    return_reason,
    return_initiated_date,
    refund_mode,
    refund_status,
    customer_fault_flag
)

SELECT
    CAST(TRIM(return_id) AS UNSIGNED),

    CAST(TRIM(order_id) AS UNSIGNED),

    NULLIF(
        TRIM(
            REPLACE(
                REPLACE(return_flag, CHAR(13), ''),
                CHAR(10),
                ''
            )
        ),
        ''
    ),

    COALESCE(
        NULLIF(TRIM(return_reason), ''),
        'Unknown'
    ),

    STR_TO_DATE(
        NULLIF(TRIM(return_initiated_date), ''),
        '%Y-%m-%d'
    ),

    COALESCE(
        NULLIF(TRIM(refund_mode), ''),
        'Unknown'
    ),

    COALESCE(
        NULLIF(TRIM(refund_status), ''),
        'Unknown'
    ),

    NULLIF(
        TRIM(
            REPLACE(
                REPLACE(customer_fault_flag, CHAR(13), ''),
                CHAR(10),
                ''
            )
        ),
        ''
    )

FROM raw_returns;

SELECT COUNT(*) AS total_returns
FROM returns;

SELECT
    COUNT(*) AS total_returns,

    SUM(return_reason = 'Unknown') AS unknown_return_reason,

    SUM(refund_mode = 'Unknown') AS unknown_refund_mode,

    SUM(refund_status = 'Unknown') AS unknown_refund_status,

    SUM(return_flag IS NULL) AS missing_return_flag,

    SUM(
        return_flag NOT IN ('Y', 'N')
        AND return_flag IS NOT NULL
    ) AS invalid_return_flag,

    SUM(customer_fault_flag IS NULL) AS missing_customer_fault_flag,

    SUM(
        customer_fault_flag NOT IN ('Y', 'N')
        AND customer_fault_flag IS NOT NULL
    ) AS invalid_customer_fault_flag,

    SUM(
        return_flag = 'Y'
        AND return_reason = 'Unknown'
    ) AS returned_without_reason

FROM returns;

SELECT
    customer_fault_flag,
    HEX(customer_fault_flag) AS hex_value,
    COUNT(*) AS row_count
FROM returns
GROUP BY customer_fault_flag, HEX(customer_fault_flag)
ORDER BY row_count DESC;

SELECT
    return_flag,
    HEX(return_flag) AS hex_value,
    COUNT(*) AS row_count
FROM returns
GROUP BY return_flag, HEX(return_flag)
ORDER BY row_count DESC;


-- ============================================
-- LOGISTICS COST
-- ============================================

DESCRIBE logistics_cost;

DESCRIBE raw_logistics_cost;

ALTER TABLE logistics_cost
MODIFY delivery_days INT NULL;

INSERT INTO logistics_cost
(
    logistics_id,
    order_id,
    shipping_cost,
    reverse_shipping_cost,
    delivery_days,
    delivery_status
)
SELECT
    CAST(TRIM(logistics_id) AS UNSIGNED),

    CAST(TRIM(order_id) AS UNSIGNED),

    CAST(TRIM(shipping_cost) AS DECIMAL(10,2)),

    CAST(TRIM(reverse_shipping_cost) AS DECIMAL(10,2)),

    CAST(
        NULLIF(TRIM(delivery_days), '')
        AS SIGNED
    ),

    COALESCE(
        NULLIF(TRIM(delivery_status), ''),
        'Unknown'
    )

FROM raw_logistics_cost;

SELECT
    COUNT(*) AS total_logistics,
    SUM(delivery_days IS NULL) AS missing_delivery_days,
    SUM(delivery_status = 'Unknown') AS unknown_delivery_status,
    SUM(shipping_cost < 0) AS negative_shipping_cost,
    SUM(reverse_shipping_cost < 0) AS negative_reverse_shipping_cost
FROM logistics_cost;
