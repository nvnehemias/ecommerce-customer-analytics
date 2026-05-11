
-- Total Revenue
select 
round(sum(payment_value),2) as total_revenue
from payments;


-- Orders by State
select 
customer_state,
count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by 1
order by 2 desc;

-- Top Product Category 
select 
p.product_category_name,
round(sum(oi.price),2) as revenue
from order_items oi 
join products p on oi.product_id = p.product_id
group by 1
order by 2 desc
limit 10;


-- Average Review Score by Category
select 
p.product_category_name,
round(avg(r.review_score),2) as avg_review
from reviews r 
join orders o on r.order_id = o.order_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
group by 1
order by 2 desc;


-- Monthly Revenue Trend
select 
date_trunc('month',o.order_purchase_timestamp) as month,
round(sum(p.payment_value),2) as monthly_revenue
from orders o 
join payments p on o.order_id = p.order_id
group by 1 
order by 1;


