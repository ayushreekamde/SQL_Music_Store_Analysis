-- Set2:Moderate

-- Q1.Write a query to return the email, first name, last name, & Genre of all Rock Music listeners.
-- Return your list ordered alphabetically by email starting with A


select distinct c.email,c.first_name,c.last_name 
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
where track_id in(
select track_id from track t
join genre g on t.genre_id = g.genre_id
where g.name like 'Rock'
)
order by c.email;


-- Q2.Let's invite the artists who have written the most rock music in our dataset.
-- write query that returns the artist name and total track count of the top 10 rock bands.

select ar.artist_id,ar.name,count(ar.artist_id)as number_of_songs
from artist ar join album a on a.artist_id = ar.artist_id
join track tr on a.album_id = tr.album_id 
join genre g on g.genre_id = tr.genre_id
where g.name = 'Rock'
group by ar.artist_id
order by number_of_songs desc 
limit 10;


-- Q3.Return all the track names that have a song length longer than the average song length.
-- Return the name and milliseconds for each track.Order by the song length with the longest songs listed first.

select name,milliseconds from track 
where milliseconds > (select avg(milliseconds) from track)
order by 2 desc



