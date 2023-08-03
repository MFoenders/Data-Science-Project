#The Analysis of the case Study 

#01-order numbers 
use magist;
select count(*) as orders_count
from orders;
select count(order_id)
from orders;

#03-Status Order
select order_status, count(*) as orders 
from orders
group by order_status ;

# 04-User Growth 
select year(order_purchase_timestamp) as Year_order , month(order_purchase_timestamp) as Month_order ,  count(customer_id)
from orders 
group by year_order, month_order
order by year_order, month_order;


select
count(month(order_purchase_timestamp)) as Month_order
from orders;


#05Produkt
select count(distinct(product_id)) as products_count
from  products;

#06 The categories with the most products
select count(distinct(product_id)) as products_count , product_category_name
from  products 
group by product_category_name
order by count(product_id) DESC;


#07 the most product sold in the actual transaction
select count(distinct product_id) as n_products
from order_items;


#07 The price for the most expensive and cheapest products
select Max(price) as expensive  , min(price) as cheapest
from order_items;

#08 The higest and lowest payment values
select max(payment_value) as maximum , min(payment_value) as minimum
from order_payments ;

# 09 maxi someone has paid for an order
select sum(payment_value) as highest_order,order_id
from order_payments
group by 
order_id
order by highest_order DESC
limit
1;



#10 what categories of tech products does Magist have?
select count * ,
case
	when product_category_name_english like 'computer' then 'Tech_cat'
    when product_category_name_english like 'electronics' then 'Tech_cat'
	else 'other'
end as big_category
from product_category_name_translation
group by big_category
;



#Filtering the review_score using where clausal
USE magist;
select *
from order_reviews
where review_score =1;

Use Magist;
SELECT count(*),
       CASE
           WHEN product_category_name_english LIKE '%computer%' THEN 'Tech'
           WHEN product_category_name_english LIKE '%audio%' THEN 'Tech'
           WHEN product_category_name_english LIKE '%consoles_games%' THEN 'Tech'
           WHEN product_category_name_english LIKE '%electronics%' THEN 'Tech'
           WHEN product_category_name_english LIKE '%computers_accessories%' THEN 'Tech'
           WHEN product_category_name_english LIKE '%pc_gamer%' THEN 'Tech'
           WHEN product_category_name_english LIKE '%computers%' THEN 'Tech'
           WHEN product_category_name_english LIKE '%tablets_printing_image%' THEN 'Tech'
           WHEN product_category_name_english LIKE '%telephony%' THEN 'Tech'
           ELSE 'other'
       END AS big_category
FROM product_category_name_translation
GROUP BY big_category;


# Using the Datediff function 
# FLOAT(DATEDIFF('day', [order_estimated_delivery_date], [order_delivered_customer_date])) as diff_date_days



#Test to make the percentage of the order_id
Select count(order_id),order_status
from orders
where order_status in ('canceled' ,'unavailable')
group by order_status;

#-- How many orders of computer accessories are actually delivered?
SELECT 
    o.order_status,
    COUNT(o.order_id) AS orders,
    pcnt.product_category_name_english
FROM
    orders AS o
        LEFT JOIN
    order_items AS oi ON o.order_id = oi.order_id
        LEFT JOIN
    products AS p ON oi.product_id = p.product_id
        LEFT JOIN
    product_category_name_translation AS pcnt ON p.product_category_name = pcnt.product_category_name
WHERE
    pcnt.product_category_name_english = 'computers_accessories'
GROUP BY o.order_status
ORDER BY orders DESC;

#the total number of the order_id and the order_status
use Magist;
Select count(order_id),order_status
from orders
left join product_category_name_translation on orders.order_id 
where order_status in ('canceled' ,'unavailable')
group by order_status;


#delivery time for each category:
SELECT 
    pcnt.product_category_name_english,
    COUNT(o.order_id) AS orders,
    DATEDIFF(o.order_delivered_customer_date, o.)) AS number_of_days
FROM
    orders AS o
        LEFT JOIN
    order_items AS oi ON o.order_id = oi.order_id
        LEFT JOIN
    products AS p ON oi.product_id = p.product_id
        LEFT JOIN
    product_category_name_translation AS pcnt ON p.product_category_name = pcnt.product_category_name
WHERE
    o.order_status = 'delivered'
GROUP BY pcnt.product_category_name_english
ORDER BY orders DESC;




