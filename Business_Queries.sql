show databases;
SELECT User, authentication_string FROM mysql.user;
CREATE database walmart_db;
show databases;
show tables;
select count(*) from walmart;
select * from walmart;

-- Types of payment methods 
select distinct payment_method from walmart;

-- Total payments in each catagory
select payment_method, count(*)
from walmart
group by payment_method;

-- Total Brances of Walamrt
select count(distinct Branch) 
from walmart;

select max(quantity) from walmart;

-- 1) Find the different Payment method and number of Transaction and quantity sold?

select payment_method, count(*) as num_of_transaction,
 sum(quantity) as no_qty_sold
from walmart
group by payment_method;

-- 2) Identify the highest rated category in each branch, displaying the branch, category and AVG rating?

SELECT * 
FROM (
    SELECT Branch, category, AVG(rating) AS avg_rating, 
           RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS ranking
    FROM walmart
    GROUP BY Branch, Category
) AS ranked_table  
WHERE ranking = 1;

-- 3) Identify the busiest day for each brand based on the number of transaction

SELECT * from
(
	SELECT 
		Branch, 
		DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS day_name,
		COUNT(*) AS no_of_transaction,
		RANK() OVER (PARTITION BY Branch ORDER BY COUNT(*) DESC) AS ranking
	FROM walmart
	GROUP BY Branch, day_name
) busirst_day_ranking
where ranking = 1;
-- 4) Total quantity of items sold per payment method list the payment method and total quantity ?

select payment_method,
 sum(quantity) as no_qty_sold
from walmart
group by payment_method;

-- 5) Determine the average, minimum and maximum rating of category for each city, 
-- Lists the city, average_rating, min_rating, and max_rating

select city, category,
min(rating) as min_rating,
max(rating) as max_rating,
avg(rating) as avg_rating
from walmart
Group by city, category;

-- 6) Calculate the total profit for each category by considering total profit as (unit_price * quantity * profit_margin)
-- List category and total_profit ordered form highest to lowest profit.

select category,
sum(total) as total_revenue,
sum(total * profit_margin) as proft
from walmart
group by category;

-- 7) Determine the most common method of payment for each branch. Display the branch and preferred payment method. 
select * from walmart;

WITH ranked_methods AS (
    SELECT 
        Branch, 
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER (PARTITION BY Branch ORDER BY COUNT(*) DESC) AS ranking
    FROM walmart
    GROUP BY Branch, payment_method
)
SELECT Branch, payment_method, total_trans, ranking
FROM ranked_methods
WHERE ranking = 1;

-- 8) Categorize sales into three groups MORNING, AFTERNOON, EVENING. Find out which of the and number of invoices.   
select * from walmart;

SELECT 
CASE 
        WHEN HOUR(time) < 12 THEN 'Morning'
        WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_category,
    count(*) as total_invoices
FROM walmart
group by time_category
order by total_invoices;





                                                                                                                                                                                                                                                   
