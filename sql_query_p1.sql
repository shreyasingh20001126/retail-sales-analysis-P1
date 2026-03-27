-- SQL Retail Sales Analysis - P1
CREATE DATABASE p1_retail_db;


-- Create TABLE
DROP TABLE IF EXISTS retail_sales;

SELECT COUNT(*) FROM sales_data;
create table retail_sales
	(
		transactions_id	INT primary key,
		sale_date DATE,
		sale_time TIME,	
		customer_id	INT,
		gender	VARCHAR(15),
		age	INT,
		category VARCHAR(15),	
		quantiy	INT,
		price_per_unit	FLOAT,
		cogs FLOAT,	
    	total_sale FLOAT
	)
	

select * from retail_sales 
LIMIT 10

select 
	COUNT(*)
from retail_sales 


select * from retail_sales 
where transactions_id is null

select * from retail_sales 
where sale_date is null


select * from retail_sales 
where 
transactions_id is null
or 
sale_date is null
or 
sale_time is null
or 
gender is null
or 
category is null
or 
quantiy is null
or 
cogs is null
or 
total_sale is null

--data cleaning

delete from retail_sales 
where 
transactions_id is null
or 
sale_date is null
or 
sale_time is null
or 
gender is null
or 
category is null
or 
quantiy is null
or 
cogs is null
or 
total_sale is null


/*data exploration*/

--How many sales we have

select count(*) as total_Sale from retail_sales 

--how many unique customers we have?

select count(distinct customer_id) as total_sale from retail_sales

-- how many category we have

select count(distinct category)as total_sale from retail_sales

-- name of the distinct category
select distinct category from retail_sales

-- Data analysis & business key problems & answers

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


--Q1 Write a sql query to retrieve all columns for sales made on 2022-11-05

select *
from retail_sales
where sale_date= '2022-11-05';

--Q2 to retrive all transactions where the category is clothing and the quantity sold is more than 4 in the month of nov-2022 

select *
from retail_sales
where category ='Clothing'
and quantiy  >=4
and extract (month from sale_date)=11
and extract (year from sale_date)=2022;

--Q3 Write a sql query to calculate the total sales (total_sale) for each category.

select 
category,
SUM(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1

--Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
Round(avg(age),2) as avg_age
from retail_sales 
where category ='Beauty'

--Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale>1000

--Q6 Write a SQL query to find the total number of transactyions (transacxtions_id) made by each gender in each category.
select 
category,
gender,
count(*) as total_trans
from retail_sales 
group by 
category,
gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
    
-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- End of project





