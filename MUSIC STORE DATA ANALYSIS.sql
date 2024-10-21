/*
SQL PROJECT- MUSIC STORE DATA ANALYSIS
*/

create DATABASE MUSIC;
USE MUSIC;
SELECT * FROM ALBUM2;

/*
Question Set 1 - Easy
*/

/*
1. Who is the senior most employee based on job title?
*/
SELECT 
    *
FROM
    EMPLOYEE
ORDER BY levels DESC
LIMIT 1;

/*
2. Which countries have the most Invoices?
*/
SELECT 
    COUNT(*) AS 'No_of_Invoices', billing_country
FROM
    invoice
GROUP BY billing_country
ORDER BY 'No_of_Invoices' DESC;


/*
3. What are top 3 values of total invoice?
*/
SELECT 
    total
FROM
    invoice
ORDER BY total DESC
LIMIT 3;

/*
4. Which city has the best customers? We would like to throw a 
promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals
*/

SELECT 
    SUM(total) AS Invoice_Total, billing_city
FROM
    invoice
GROUP BY billing_city
ORDER BY Invoice_Total DESC
LIMIT 1;

/*
5. Who is the best customer? 
The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money
*/

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(invoice.total) AS Total_Invoice
FROM
    customer
        JOIN
    invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id , customer.first_name , customer.last_name
ORDER BY Total_Invoice DESC
LIMIT 1; 

/*
Question Set 2 – Moderate
*/
/*
1. Write query to return the email, first name,
last name, & Genre of all Rock Music listeners.
Return your list ordered alphabetically by 
email starting with A
*/ 
/*
Ans:- option-1
*/ 
SELECT DISTINCT
    first_name, last_name, email
FROM
    customer
        JOIN
    invoice ON customer.customer_id = invoice.customer_id
        JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE
    track_id IN (SELECT 
            track_id
        FROM
            track
                JOIN
            genre ON track.genre_id = genre.genre_id
        WHERE
            genre.name LIKE 'rock')
ORDER BY email;

/*
Ans:- option-2
*/ 
SELECT DISTINCT
    first_name, last_name, email
FROM
    customer
        JOIN
    invoice ON customer.customer_id = invoice.customer_id
        JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
        JOIN
    track ON invoice_line.track_id = track.track_id
        JOIN
    genre ON track.genre_id = genre.genre_id
WHERE
    genre.name LIKE 'rock'
ORDER BY email;


/*
2. Let's invite the artists who have written the most rock 
music in our dataset. Write a query that returns the Artist name 
and total track count of the top 10 rock bands
*/ 
/* get help */
SELECT 
    artist.artist_id,
    artist.name,
    COUNT(artist.artist_id) AS 'No_of_Songs'
FROM
    track
        JOIN
    album ON album.album_id = track.album_id
        JOIN
    artist ON artist.artist_id = album.artist_id
        JOIN
    genre ON genre.genre_id = track.genre_id
WHERE
    genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY 'No_of_Songs';


/*
3. Return all the track names that have a song length longer 
than the average song length. Return the Name and Milliseconds for each track. 
Order by the song length with the longest songs listed first 
*/ 


select avg(milliseconds) as avg_length_of_song from track;

/*
Ans:- option-1
*/ 
SELECT 
    name, milliseconds
FROM
    track
WHERE
    milliseconds > 251177.7431
ORDER BY milliseconds DESC;
/*
Ans:- option-2
*/ 
SELECT 
    name, milliseconds
FROM
    track
WHERE
    milliseconds > (SELECT 
            AVG(milliseconds) AS avg_length_of_song
        FROM
            track)
ORDER BY milliseconds DESC;
