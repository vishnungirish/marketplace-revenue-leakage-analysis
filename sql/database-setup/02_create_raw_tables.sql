USE marketplace_revenue_analysis;

USE marketplace_revenue_analysis;

CREATE TABLE raw_products (
    product_id VARCHAR(50),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    brand VARCHAR(100),
    supplier_id VARCHAR(50),
    cost_price VARCHAR(50),
    mrp VARCHAR(50),
    weight_kg VARCHAR(50),
    launch_date VARCHAR(50)
);

CREATE TABLE raw_payment_fees (
    payment_method VARCHAR(100),
    fee_percentage VARCHAR(50),
    settlement_days VARCHAR(50)
);

CREATE TABLE raw_orders (
    order_id VARCHAR(50),
    order_date VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity VARCHAR(50),
    selling_price VARCHAR(50),
    order_status VARCHAR(100),
    payment_method VARCHAR(100),
    order_channel VARCHAR(100),
    warehouse_id VARCHAR(50)
);

CREATE TABLE raw_discounts (
    discount_id VARCHAR(50),
    order_id VARCHAR(50),
    discount_amount VARCHAR(50),
    discount_type VARCHAR(100),
    coupon_code VARCHAR(100),
    is_stackable VARCHAR(20)
);

CREATE TABLE raw_returns (
    return_id VARCHAR(50),
    order_id VARCHAR(50),
    return_flag VARCHAR(20),
    return_reason VARCHAR(100),
    return_initiated_date VARCHAR(50),
    refund_mode VARCHAR(100),
    refund_status VARCHAR(100),
    customer_fault_flag VARCHAR(20)
);

CREATE TABLE raw_logistics_cost (
    logistics_id VARCHAR(50),
    order_id VARCHAR(50),
    shipping_cost VARCHAR(50),
    reverse_shipping_cost VARCHAR(50),
    delivery_days VARCHAR(50),
    delivery_status VARCHAR(100)
);

