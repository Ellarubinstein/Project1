-- KPI 1: Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
select * FROM ORDERS ;
SELECT * FROM payments;


select 
case 
when weekday(o.order_purchase_timestamp) in (5,6) then "weekend" 
else "weekday"
end as day_type,
concat(round((sum(payment_value)/ (select sum(payment_value) from payments )*100),2),'%') as Total_sales
from payments p join orders o on p.order_id = o.order_id
group by day_type;




-- 2 Number of Orders with review score 5 and payment type as credit card

select 
review_score as review_score, 
count(rev.order_id) as total, 
pay.payment_type as type_of_card 
from reviews as rev
inner join  payments as pay 
on rev.ORDER_ID = pay.ORDER_ID 
where rev.review_score = 5
and pay.PAYMENT_TYPE = 'credit_card';

-- kpi 3 Average number of days taken for order_delivered_customer_date for pet_shop
select * from orders;
select * from order_items;
select * from products ;

select pro.PRODUCT_CATEGORY_NAME,
 round(avg(datediff(ords.order_customer_delivered_date,ords.order_purchase_timestamp))) as average_days 
from orders as ords
 inner join order_items as ordtms 
on ords.ORDER_ID = ordtms.order_id
inner join products as pro
on ordtms.product_id = pro.product_id
where pro.PRODUCT_CATEGORY_NAME = 'pet_shop';

-- kpi 4 Average price and payment values from customers of sao paulo city
select * from customers;
select * from payments;
select * from order_items;
select * from orders;

select customers.CUSTOMER_CITY,
round(avg(order_items.price),2) as avg_price ,round(avg(payments.PAYMENT_VALUE),2) as avg_payvalue 
from payments 
inner join order_items 
on order_items.order_id = payments.ORDER_ID
inner join orders 
on payments.ORDER_ID = orders.ORDER_ID
inner join customers
on orders.CUSTOMER_ID= customers.CUSTOMER_ID
where customers.CUSTOMER_CITY = "sao paulo" ;

-- KPI 5 Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.
select * from reviews;
select * from orders;

select  reviews.review_score ,
round(avg(datediff(orders.ORDER_CUSTOMER_DELIVERED_DATE,orders.ORDER_PURCHASE_TIMESTAMP)),1) as avg_shipping_days
from orders 
 inner join reviews 
on orders.ORDER_ID = reviews.order_id
group by reviews.review_score
order by avg_shipping_days;



