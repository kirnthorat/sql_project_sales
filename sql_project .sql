create table retail_sales(
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender	char(15),
age	int,
category char(15),
quantiy	int,
price_per_unit float,
cogs float,
total_sale	float
)

select * from retail_sales;

-- import data 
select * from retail_sales;

-- clean data
select * from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

delete from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- how many sales we have 
select count(total_sale) from retail_sales;

--  how many customer we have 
select count(customer_id) from retail_sales;

-- how many unique category 
select distinct category from retail_sales;

select * from retail_sales;
 
-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
select * from retail_sales
where sale_date='2022-11-05';

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022.
	select * from retail_sales
	where category ='Clothing'
	and quantiy >=4
	and sale_date >='2022-11-01' 
	and sale_date < '2022-12-01'
	order by sale_date asc;
	
-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.
	select category, sum(total_sale) as total_sales from retail_sales
	group by category; 
	
-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
	select round(avg(age),2) as average_age from retail_sales
	where category ='Beauty'; 
	
-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
	select total_sale from retail_sales
	where total_sale >1000;
	
-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
	select category, gender, count(transactions_id) as total_transaction 
	from retail_sales
	group by category, gender;
	
-- Q7. Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year.
	select 
	extract (year from sale_date) as year,
	extract (month from sale_date) as month,
	avg(total_sale)as avg_sale from retail_sales
	group by 1,2
	order by 1,3 desc
	limit 2;
	
-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales.
	 select customer_id, sum(total_sale) as total_sales from retail_sales
	 group by  total_sale, customer_id  
	 order by total_sales desc
	 limit 5;
	 
-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.
	select category, count(distinct customer_id) from retail_sales
	group by category;
	
-- Q10. Write a SQL query to create each shift and number of orders:Morning: <= 12, Afternoon:Between 12 and 17, Evening: > 17	
with hourly_sale
as
(
select *,
case
when extract(hour from sale_time)< 12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afteroon'
else 'Evening'
end as shift
from retail_sales
)
select shift, count(*) as total_orders
from hourly_sale
group by shift;