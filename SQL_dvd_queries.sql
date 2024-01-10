-- Counting the number of actors whose first names start with the letter 'P'.

SELECT COUNT(*) as P_actors FROM actor 
WHERE first_name LIKE 'P%';


-- Counting the number of unique districts in the 'address' table.

SELECT COUNT(DISTINCT(district)) as unique_addresses
FROM address


-- Counting the number of films with an 'R' rating and a replacement cost between $5 and $15.

SELECT COUNT(*) as films_R_btw_5and15 FROM film
WHERE rating = 'R'
AND replacement_cost BETWEEN 5 AND 15


-- Counting the number of films with the word 'night' appearing anywhere in the title.

SELECT COUNT(*) as titles_include_night FROM film
WHERE title LIKE '%night%'


-- Retrieving the titles and lengths of films, ordering the results by length in ascending order, and limits the output with 10 records.

SELECT title,length FROM film
ORDER BY length ASC
LIMIT 10


-- Calculating the average replacement cost rounded to two decimal places for films in each rating category.

SELECT rating,
ROUND(AVG(replacement_cost),2) as avg_cost
FROM film
GROUP BY rating


/* Summarizing the total payment amounts made by each customer, 
ordering the results by the total payment amount in descending order, 
and limiting the output to the top 5 customers with the highest total payments. */

SELECT customer_id , SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5


-- Identifying customers who have made 40 or more payments and counts the occurrences for each customer.

SELECT customer_id, COUNT(*)
as payment_count
FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 40


/* Calculating the total payment amounts for customers handled by staff member 2,
grouping the results by customer_id, 
and including only those with a total payment sum exceeding 100. */

SELECT customer_id, SUM(amount)
FROM payment
WHERE staff _id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100


-- Finding the customer whose first name starts with "E" letter, his/her address_id character is less than 500, and alphatically comes first.

SELECT first_name,last_name FROM customer
WHERE first_name LIKE 'E%'
AND address_id <500
ORDER BY customer_id desc
LIMIT 1


/* Extracting the district and email information for customers
located in the 'California' district by performing an 
inner join between the 'address' and 'customer' tables. */

SELECT district,email FROM address
INNER JOIN customer ON
address.address_id = customer.address_id
WHERE district = 'California'


/* Retrieving the titles of films in which actor Nick Wahlberg has participated,
joining the 'film_actor,' 'actor,' and 'film' tables based on actor and film IDs. */

SELECT title,first_name,last_name
FROM film_actor INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE first_name = 'Nick'
AND last_name = 'Wahlberg'


/* Assigning a customer class ('Premium', 'Plus', or 'Normal') 
by using a CASE statement, based on the customer_id they have */

SELECT customer_id,
CASE
	WHEN (customer_id <= 100) THEN 'Premium'
	WHEN (customer_id BETWEEN 100 and 200) THEN 'Plus'
	ELSE 'Normal'
END AS customer_class
FROM customer


/* Counting the number of films categorized as 
'bargains' with a rental rate of 0.99 and
'regular' films with a rental rate of 2.99 by
using conditional aggregation on the 'film' table. */

SELECT
SUM(CASE rental_rate
   WHEN 0.99 THEN 1
   ELSE 0
   END) AS bargains,
SUM(CASE rental_rate
   WHEN 2.99 THEN 1
   ELSE 0
   END) AS regular
FROM film


/* Calculating the count of films with 'R', 'PG', 
and 'PG-13' ratings using conditional aggregation. */

SELECT
sum(case rating
when 'R' then 1
else 0
end) as r,
sum(case rating
   when 'PG' THEN 1
   ELSE 0 END) AS PG,
   SUM(CASE rating
	  when 'PG-13' THEN 1
	  ELSE 0 END) AS PG13 
FROM film


/* Finding the sum of the character lengths of 
inventory_id for each distinct staff member in the 'rental' table. */

SELECT staff_id, 
       SUM(CHAR_LENGTH(CAST(inventory_id AS VARCHAR))) 
	   AS result
FROM rental
GROUP BY staff_id


/* Generating a view named 'customer_info' by combining 
customer names with their corresponding addresses.  */

CREATE VIEW customer_info AS
SELECT first_name,last_name,address FROM customer
INNER JOIN address
ON customer.address_id = address.address_id


/* Extracting and displaying the quarter (pay_month) from 
the payment_date in the 'payment' table using the EXTRACT function. */

SELECT EXTRACT(QUARTER FROM payment_date)
AS pay_month FROM payment


/* Converting the payment_date column to a formatted string in
'MM-dd-YYYY' format for each entry in the 'payment' table. */

SELECT TO_CHAR(payment_date, 'MM-dd-YYYY')
FROM payment


/* Retrieving the film_id and title of films rented between '2005-05-29'
and '2005-05-30' by utilizing a subquery involving the 'rental' and 
'inventory' tables. */

SELECT film_id, title FROM film
WHERE film_id IN
(SELECT inventory.film_id
FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')


/* Retrieving titles and lengths of films with matching
lengths, excluding self-matches, by performing an inner join
on the 'film' table with aliases 'f1' and 'f2'. */

SELECT f1.title , f2.title, f1.length
FROM film AS f1
INNER JOIN film AS f2 ON
f1.film_id = f2.film_id 
AND f1.length = f2.length


/* Generating custom email addresses 
by using string manipulation functions */

SELECT 
LOWER(LEFT(first_name,1)) || LOWER(last_name) || '@gmail.com'
AS custom_email FROM customer


-- Calculating the average rental duration in days for each film.

SELECT film.film_id, 
       AVG(EXTRACT(EPOCH FROM rental.return_date - rental.rental_date) / 86400)::numeric(10,2) AS avg_rental_duration_days
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY avg_rental_duration_days DESC;








