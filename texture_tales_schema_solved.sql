

## 1. What was the total quantity sold for all products?

select pd.product_name,sum(s.qty) as sales_count
from sales as s inner join product_details as pd
on s.prod_id = pd.product_id
group by pd.product_name
order by sales_count desc;


## 2. What is the total generated revenue for all products before discounts?

select sum(price*qty) total_generated_revenue_before_discount from sales;


## 3. What was the total discount amount for all products?

select round(sum(price*qty*discount)/100,2) as totl_discount_amount
from sales;


## 4. How many unique transactions were there?

select count(distinct(txn_id)) as unique_transaction from sales;


## 5. What are the average unique products purchased in each transaction?

with cte as (
select txn_id,
count(distinct (prod_id)) as product_count
 from sales
 group by txn_id
 ) select round(avg(product_count)) as avg_unique_products_purchased
 from cte;
 
 
## 6. What is the average discount value per transaction?

with cte as (
select txn_id,
sum(price*qty*discount)/100 as discount_value
 from sales
 group by txn_id
 ) select round(avg(discount_value),2) as avg_discount_value
 from cte;
 
 
## 7. What is the average revenue for member transactions and non-member transactions?
 
with cte_member_transaction as (
select txn_id, member,
sum(price*qty) as member_revenue
from sales
group by member,txn_id
)select member,round(avg(member_revenue),2) as avg_revenue
from  cte_member_transaction 
group by member;


## 8. What are the top 3 products by total revenue before discount?

select product_name,prod_id,sum(s.price*qty) total_generated_revenue_before_discount
from sales s inner join product_details pd 
on s.prod_id = pd.product_id 
group by prod_id,product_name
order by total_generated_revenue_before_discount desc
limit 3;


## 9. What are the total quantity, revenue and discount for each segment?

select pd.segment_name,sum(qty) as total_quantity,
sum(s.price*qty) as total_revenue, round(sum(s.price*qty*discount)/100,2) as total_discount
from sales s inner join product_details pd 
on s.prod_id = pd.product_id
group by pd.segment_name;


## 10. What is the top selling product for each segment?

select pd.segment_name,pd.product_name, sum(s.qty) as number_quantity
from sales s inner join product_details pd 
on s.prod_id = pd.product_id
group by pd.segment_name
order by number_quantity desc
;


## 11. What are the total quantity, revenue and discount for each category?

select pd.category_name,sum(qty) as total_quantity,
sum(s.price*qty) as total_revenue, round(sum(s.price*qty*discount)/100,2) as total_discount
from sales s inner join product_details pd 
on s.prod_id = pd.product_id
group by pd.category_name;


## 12. What is the top selling product for each category?

select pd.category_name,pd.product_name, sum(s.qty) as number_quantity
from sales s inner join product_details pd 
on s.prod_id = pd.product_id
group by pd.category_name
order by number_quantity desc
;







