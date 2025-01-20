-- Set 3 -Advance

-- Q1:Find out how much amount spent by each customer on artists?
-- Write query to return customer name,artist name, total spent

with best_selling_artist as (
select ar.artist_id as artist_id, ar.name as artist_name,
sum(il.unit_price * il.quantity) as total_sales
from invoice_line il
join track tr on il.track_id = tr.track_id
join album a on tr.album_id = a.album_id
join artist ar on a.artist_id = ar.artist_id
group by 1
order by 3 desc
limit 1
)
select c.customer_id,c.first_name,c.last_name,bsa.artist_name,sum(il.unit_price * il.quantity) as total_spent
from customer c join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track tr on il.track_id = tr.track_id
join album a on tr.album_id = a.album_id
join best_selling_artist bsa on a.artist_id = bsa.artist_id
group by 1,2,3,4
order by 5 desc;



-- Q2.we want to find out the most popular music Genre for each country.
-- We determine the most popular genre as the highest amount of purchases.
-- write a query that returns each country along with the top genre.
-- For countries where the maximum number of purchases is shared return all genres.


with popular_genre as(
select count(il.quantity) as purchase, c.country,g.name,g.genre_id,
row_number() over(partition by c.country order by count(il.quantity) desc)
as row_no from invoice_line il 
join invoice i on i.invoice_id = il.invoice_id
join customer c on c.customer_id = i.customer_id
join track tr on tr.track_id = il.track_id
join genre g on g.genre_id = tr.genre_id
group by 2,3,4
order by 2 asc,1 desc
)
select * from popular_genre where row_no <= 1


-- Q3.Write a query that determines the customer that has spent the most on music for each country.
-- Write a query that returns the country along with the top customers and how much they spent.
-- For countries where the top amount spent is shared, provide all the customers who spent this amount.


with customer_with_country as(
select c.customer_id,first_name,last_name,billing_country, sum(total) as total_spending,
row_number() over(partition by billing_country order by sum(total)desc)as row_num
from invoice i
join customer c on c.customer_id = i.customer_id
group by 1,2,3,4
order by 4 asc,5 desc
)
select * from customer_with_country where row_num <=1;


-- Method 2 :with recursive cte
with recursive
customer_with_country as(
select c.customer_id,first_name,last_name,billing_country,sum(total) as total_spending
from invoice i
join customer c on c.customer_id= i.customer_id
group by 1,2,3,4
order by 1,5 desc),

country_max_spending as(
select billing_country, max(total_spending) as max_spending
from customer_with_country cc
group by billing_country
)

select cc.billing_country,cc.total_spending,cc.first_name,cc.last_name,cc.customer_id
from customer_with_country cc
join country_max_spending ms
on cc.billing_country = ms.billing_country
where cc.total_spending = ms.max_spending
order by 1;



