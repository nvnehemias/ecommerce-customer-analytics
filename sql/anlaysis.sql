
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


-- Ranking Top Customers by Spending
with customer_spending as (

	select 
		c.customer_unique_id,
		round(sum(p.payment_value),2) as total_spent
	from customers c 
	join orders o on c.customer_id = o.customer_id
	join payments p on o.order_id = p.order_id 
	group by 1 
)

select 
customer_unique_id,
total_spent,
rank() over(order by total_spent desc) as spending_rank
from customer_spending 
limit 20;


-- Running Revenue Total
with monthly_sales as (

	select 
		date_trunc('month',o.order_purchase_timestamp) as month,
		sum(p.payment_value) as revenue 
	from orders o 
	join payments p on o.order_id = p.order_id
	group by 1 
)

select 
month,
revenue,
sum(revenue) over(order by month) as running_total
from monthly_sales;


-- Customer Segmentation
with customer_orders as (

	select 
		c.customer_unique_id,
		count(o.order_id) as total_orders,
		sum(p.payment_value) as total_spent
	from customers c 
	join orders o on c.customer_id = o.customer_id
	join payments p on o.order_id = p.order_id 
	group by 1 
)

select
customer_unique_id,
total_orders,
total_spent,
case
	when total_spent > 1000 then 'High Value'
	when total_spent > 500 then 'Medium Value'
	else 'Low Value'
end as customer_segment
from customer_orders;