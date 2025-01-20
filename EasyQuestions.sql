
Q1. Who is the senior most employee based on their job title

select * from employee 
order by levels 
desc limit 1;


Q2.Which country have the most invoices?
select count(*),billing_country 
from invoice 
group by billing_country 
order by 1 desc;


--Q3.What are top 3 values of total invoice
select total from invoice 
order by total desc 
limit 3;

--Q4.Which city has the best customers? We would like to throw a promotional music festival in the city 
--we made the most money. Write a query that returns one city that has the highest sum of invoice total.
-- Return both the city name and sum of all invoice totals

select billing_city,sum(total) invoice_total 
from invoice 
group by billing_city 
order by 2 desc limit 1;


-- Q5. Who is the best customer? Write a query who has spent the most money will be declared as the best customer.
-- Write a query that returns the person who has spent the most money.

select c.first_name , sum(total) as total_amount 
from invoice i join customer c on i.customer_id = c.customer_id 
group by c.first_name 
order by total_amount desc 
limit 1 ;


