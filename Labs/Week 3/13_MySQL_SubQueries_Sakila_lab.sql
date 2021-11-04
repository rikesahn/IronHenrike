use sakila;

#1 How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT 
    title, COUNT(inventory_id) AS copies
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
WHERE title = 'Hunchback Impossible'
;



#2 List all films whose length is longer than the average of all the films.

SELECT avg(length) as average
from film 
;

SELECT title, length
FROM film
WHERE length > (SELECT avg(length) from film)
;



#3 Use subqueries to display all actors who appear in the film Alone Trip.

SELECT 
    first_name, last_name, title
FROM
    film_actor
        INNER JOIN
    actor ON actor.actor_id = film_actor.actor_id
        INNER JOIN
    film ON film.film_id = film_actor.film_id
WHERE
    title = 'Alone Trip'
;

SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'))
;

#4 Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id = (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'family'))
;

#5.1 Get name and email from customers from Canada using subqueries. 

SELECT 
    CONCAT(customer.first_name,
            ' ',
            customer.last_name) AS name,
    customer.email
FROM
    customer
WHERE
    address_id IN (SELECT 
            address_id
        FROM
            address
        WHERE
            city_id IN (SELECT 
                    city_id
                FROM
                    city
                WHERE
                    country_id IN (SELECT 
                            country_id
                        FROM
                            country
                        WHERE
                            country = 'canada')));

#5.2 Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

SELECT 
    CONCAT(customer.first_name,
            ' ',
            customer.last_name) AS name,
    customer.email
FROM
    customer
        LEFT JOIN
    address ON customer.address_id = address.address_id
        LEFT JOIN
    city ON address.city_id = city.city_id
        LEFT JOIN
    country ON city.country_id = country.country_id
WHERE
    country = 'canada'
;

#6 Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_actor
        WHERE
            actor_id = (SELECT 
                    actor.actor_id
                FROM
                    actor
                        INNER JOIN
                    film_actor ON actor.actor_id = film_actor.actor_id
                GROUP BY actor.actor_id
                ORDER BY count(*) DESC
                LIMIT 1));


#7 Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments


#8 Customers who spent more than the average payments. 

#Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name. 
SELECT 
    first_name, last_name, 
    SUM(amount) AS total_amount
FROM
    customer
        LEFT JOIN
    payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;
#WHERE
#    customer_id in (select sum(amount)  from payment > (SELECT 
#            AVG(amount)
#        FROM
;

SELECT 
    *
FROM
    customer;
SELECT 
    AVG(amount)
FROM
    payment;
    
Solution from Hon-Kiu:
##Customers who spent more than the average payments.
create temporary table sakila.avg_amt
select sum(p.amount) as ans, c.customer_id
from sakila.payment as p inner join sakila.customer as c
using(customer_id)
group by customer_id;

select customer_id, sum(amount) as summ from sakila.payment
group by customer_id
having summ > (select avg(ans) from sakila.avg_amt)
order by summ DESC;
