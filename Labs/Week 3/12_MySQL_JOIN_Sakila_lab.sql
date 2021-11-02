#Instructions
use sakila;
#Which actor has appeared in the most films?

SELECT 
    actor.first_name,
    actor.last_name,
    COUNT(*) AS number_of_films
FROM
    actor
        INNER JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY number_of_films DESC
LIMIT 1;

#Most active customer (the customer that has rented the most number of films)

SELECT * FROM rental;

SELECT 
    customer.first_name,
    customer.last_name,
    COUNT(*) AS number_of_rentals
FROM
    customer
        INNER JOIN
    rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY number_of_rentals DESC
LIMIT 1
;

#List number of films per category.

SELECT 
    category.name AS category_name,
    COUNT(film_category.film_id) AS number_of_films
FROM
    category
        INNER JOIN
    film_category ON category.category_id = film_category.category_id
GROUP BY category.name
;

#Display the first and last names, as well as the address, of each staff member.

SELECT 
    first_name, last_name, address
FROM
    staff
        INNER JOIN
    address ON staff.address_id = address.address_id
;

#Display the total amount rung up by each staff member in August of 2005.
SELECT 
    first_name, last_name, SUM(amount) AS total_amount
FROM
    staff
        INNER JOIN
    payment ON staff.staff_id = payment.staff_id
WHERE payment_date LIKE "2005-08%"
GROUP BY staff.staff_id
;


#List each film and the number of actors who are listed for that film.

SELECT title, count(actor_id) as number_of_actors
FROM film
inner join film_actor on film.film_id = film_actor.film_id
GROUP BY title
;


#Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name. 
SELECT 
    first_name, last_name, SUM(amount) AS total_amount
FROM
    customer
        INNER JOIN
    payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
#ORDER BY total_amount desc
ORDER BY last_name
;

#Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try.
SELECT 
    title, COUNT(rental.inventory_id) AS total_rentals
FROM
    INVENTORY
        INNER JOIN
    RENTAL ON inventory.inventory_id = rental.inventory_id
        INNER JOIN
    FILM ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY total_rentals DESC
LIMIT 1
;

SELECT 
    MAX(count) as total_rentals
FROM
    (SELECT 
        title, COUNT(rental.inventory_id) AS count
    FROM
        INVENTORY
    LEFT JOIN RENTAL ON inventory.inventory_id = rental.inventory_id
    LEFT JOIN FILM ON inventory.film_id = film.film_id
    GROUP BY title) derived_table

;


select max(count)
from (
  select
    name,
    count(*) as count
  from emp1
  group by name) x
#SELECT * FROM INVENTORY;
#SELECT * FROM FILM;