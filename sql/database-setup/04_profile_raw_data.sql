use marketplace_revenue_analysis;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_product_ids,

    SUM(product_id IS NULL OR TRIM(product_id) = '') AS missing_product_id,
    SUM(category IS NULL OR TRIM(category) = '') AS missing_category,
    SUM(sub_category IS NULL OR TRIM(sub_category) = '') AS missing_sub_category,
    SUM(brand IS NULL OR TRIM(brand) = '') AS missing_brand,
    SUM(supplier_id IS NULL OR TRIM(supplier_id) = '') AS missing_supplier_id,
    SUM(cost_price IS NULL OR TRIM(cost_price) = '') AS missing_cost_price,
    SUM(mrp IS NULL OR TRIM(mrp) = '') AS missing_mrp,
    SUM(weight_kg IS NULL OR TRIM(weight_kg) = '') AS missing_weight_kg,
    SUM(launch_date IS NULL OR TRIM(launch_date) = '') AS missing_launch_date

FROM raw_products;

SELECT *
FROM raw_products
WHERE CAST(cost_price AS DECIMAL(10,2)) < 0
   OR CAST(mrp AS DECIMAL(10,2)) < 0;
   
   SELECT *
FROM raw_products
WHERE CAST(cost_price AS DECIMAL(10,2))
    >
      CAST(mrp AS DECIMAL(10,2));
      
      SELECT *
FROM raw_products
WHERE weight_kg <> ''
AND CAST(weight_kg AS DECIMAL(10,2)) <= 0;

SELECT *
FROM raw_products
WHERE STR_TO_DATE(launch_date,'%Y-%m-%d') IS NULL;

DESCRIBE raw_orders;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders,

    SUM(order_id IS NULL OR TRIM(order_id)='') AS missing_order_id,
    SUM(order_date IS NULL OR TRIM(order_date)='') AS missing_order_date,
    SUM(customer_id IS NULL OR TRIM(customer_id)='') AS missing_customer_id,
    SUM(product_id IS NULL OR TRIM(product_id)='') AS missing_product_id,
    SUM(quantity IS NULL OR TRIM(quantity)='') AS missing_quantity,
    SUM(selling_price IS NULL OR TRIM(selling_price)='') AS missing_selling_price,
    SUM(order_status IS NULL OR TRIM(order_status)='') AS missing_order_status,
    SUM(payment_method IS NULL OR TRIM(payment_method)='') AS missing_payment_method,
    SUM(order_channel IS NULL OR TRIM(order_channel)='') AS missing_order_channel,
    SUM(warehouse_id IS NULL OR TRIM(warehouse_id)='') AS missing_warehouse_id
FROM raw_orders;

SELECT
    order_id,
    COUNT(*) AS occurrences
FROM raw_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT *
FROM raw_orders
WHERE CAST(quantity AS SIGNED) <= 0;

SELECT *
FROM raw_orders
WHERE CAST(selling_price AS DECIMAL(10,2)) < 0;

SELECT *
FROM raw_orders
WHERE STR_TO_DATE(TRIM(order_date), '%Y-%m-%d') IS NULL;

SELECT DISTINCT order_status
FROM raw_orders
ORDER BY order_status;

SELECT DISTINCT payment_method
FROM raw_orders
ORDER BY payment_method;

SELECT DISTINCT order_channel
FROM raw_orders
ORDER BY order_channel;


DESCRIBE raw_discounts;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT discount_id) AS unique_discount_ids,

    SUM(discount_id IS NULL OR TRIM(discount_id)='') AS missing_discount_id,
    SUM(order_id IS NULL OR TRIM(order_id)='') AS missing_order_id,
    SUM(discount_amount IS NULL OR TRIM(discount_amount)='') AS missing_discount_amount,
    SUM(discount_type IS NULL OR TRIM(discount_type)='') AS missing_discount_type,
    SUM(coupon_code IS NULL OR TRIM(coupon_code)='') AS missing_coupon_code,
    SUM(is_stackable IS NULL OR TRIM(is_stackable)='') AS missing_is_stackable
FROM raw_discounts;

SELECT
    discount_id,
    COUNT(*) AS occurrences
FROM raw_discounts
GROUP BY discount_id
HAVING COUNT(*) > 1;

SELECT *
FROM raw_discounts
WHERE CAST(discount_amount AS DECIMAL(10,2)) < 0;

SELECT DISTINCT discount_type
FROM raw_discounts
ORDER BY discount_type;

SELECT DISTINCT is_stackable
FROM raw_discounts
ORDER BY is_stackable;

SELECT *
FROM raw_discounts
WHERE coupon_code IS NULL
   OR TRIM(coupon_code) = '';
   
   
   DESCRIBE raw_returns;
   
   SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT return_id) AS unique_return_ids,

    SUM(return_id IS NULL OR TRIM(return_id)='') AS missing_return_id,
    SUM(order_id IS NULL OR TRIM(order_id)='') AS missing_order_id,
    SUM(return_flag IS NULL OR TRIM(return_flag)='') AS missing_return_flag,
    SUM(return_reason IS NULL OR TRIM(return_reason)='') AS missing_return_reason,
    SUM(return_initiated_date IS NULL OR TRIM(return_initiated_date)='') AS missing_return_date,
    SUM(refund_mode IS NULL OR TRIM(refund_mode)='') AS missing_refund_mode,
    SUM(refund_status IS NULL OR TRIM(refund_status)='') AS missing_refund_status,
    SUM(customer_fault_flag IS NULL OR TRIM(customer_fault_flag)='') AS missing_customer_fault_flag
FROM raw_returns;
   
   SELECT
    return_id,
    COUNT(*) AS occurrences
FROM raw_returns
GROUP BY return_id
HAVING COUNT(*) > 1;

SELECT *
FROM raw_returns
WHERE STR_TO_DATE(TRIM(return_initiated_date), '%Y-%m-%d') IS NULL;

SELECT DISTINCT return_flag
FROM raw_returns
ORDER BY return_flag;

SELECT DISTINCT return_reason
FROM raw_returns
ORDER BY return_reason;

SELECT DISTINCT refund_mode
FROM raw_returns
ORDER BY refund_mode;

SELECT DISTINCT refund_status
FROM raw_returns
ORDER BY refund_status;

SELECT DISTINCT customer_fault_flag
FROM raw_returns
ORDER BY customer_fault_flag;

SELECT *
FROM raw_returns
WHERE TRIM(return_flag) = 'Y'
AND (return_reason IS NULL OR TRIM(return_reason) = '');

describe raw_logistics_cost;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT logistics_id) AS unique_logistics_ids,

    SUM(logistics_id IS NULL OR TRIM(logistics_id)='') AS missing_logistics_id,
    SUM(order_id IS NULL OR TRIM(order_id)='') AS missing_order_id,
    SUM(shipping_cost IS NULL OR TRIM(shipping_cost)='') AS missing_shipping_cost,
    SUM(reverse_shipping_cost IS NULL OR TRIM(reverse_shipping_cost)='') AS missing_reverse_shipping_cost,
    SUM(delivery_days IS NULL OR TRIM(delivery_days)='') AS missing_delivery_days,
    SUM(delivery_status IS NULL OR TRIM(delivery_status)='') AS missing_delivery_status
FROM raw_logistics_cost;

SELECT
    logistics_id,
    COUNT(*) AS occurrences
FROM raw_logistics_cost
GROUP BY logistics_id
HAVING COUNT(*) > 1;

SELECT *
FROM raw_logistics_cost
WHERE CAST(shipping_cost AS DECIMAL(10,2)) < 0;

SELECT *
FROM raw_logistics_cost
WHERE CAST(reverse_shipping_cost AS DECIMAL(10,2)) < 0;

SELECT *
FROM raw_logistics_cost
WHERE CAST(delivery_days AS SIGNED) <= 0;

SELECT DISTINCT delivery_status
FROM raw_logistics_cost
ORDER BY delivery_status;

SELECT *
FROM raw_logistics_cost
WHERE TRIM(delivery_status) = 'Delivered'
AND (delivery_days IS NULL OR TRIM(delivery_days) = '');

DESCRIBE raw_payment_fees;

SELECT 
COUNT(*) AS total_rows,
COUNT(DISTINCT payment_method) AS unique_payment_methods,

    SUM(payment_method IS NULL OR TRIM(payment_method)='') AS missing_payment_method,
    SUM(fee_percentage IS NULL OR TRIM(fee_percentage)='') AS missing_fee_percentage,
    SUM(settlement_days IS NULL OR TRIM(settlement_days)='') AS missing_settlement_days
FROM raw_payment_fees;

SELECT
    payment_method,
    COUNT(*) AS occurrences
FROM raw_payment_fees
GROUP BY payment_method
HAVING COUNT(*) > 1;

SELECT *
FROM raw_payment_fees
WHERE CAST(fee_percentage AS DECIMAL(5,2)) < 0;

SELECT *
FROM raw_payment_fees
WHERE settlement_days <> ''
AND CAST(settlement_days AS SIGNED) <= 0;

SELECT DISTINCT payment_method
FROM raw_payment_fees
ORDER BY payment_method;

SELECT DISTINCT o.payment_method
FROM raw_orders o
LEFT JOIN raw_payment_fees p
ON TRIM(o.payment_method)=TRIM(p.payment_method)
WHERE p.payment_method IS NULL;