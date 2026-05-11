CREATE TABLE customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix INT,
    customer_city TEXT,
    customer_state TEXT
);

CREATE TABLE orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    price NUMERIC,
    freight_value NUMERIC
);

CREATE TABLE products (
    product_id TEXT,
    product_category_name TEXT,
    product_name_lenght NUMERIC,
    product_description_lenght NUMERIC, 
    product_photos_qty INT, 
    product_weight_g NUMERIC,
    product_length_cm NUMERIC, 
    product_height_cm NUMERIC, 
    product_width_cm NUMERIC
);

CREATE TABLE payments (
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value NUMERIC
);

CREATE TABLE reviews (
    review_id TEXT,
    order_id TEXT,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);