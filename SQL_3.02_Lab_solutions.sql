

-- Lab | SQL Subqueries 3.02

USE sakila;

-- How many copies of the film Hunchback Impossible exist in the inventory system?

Select count(distinct(inventory_id))
from inventory i
inner join film
using (film_id) 
where title = 'Hunchback Impossible';


-- List all films whose length is longer than the average of all the films.

Select title
from film
where length>(select avg(length) from film);

-- Use subqueries to display all actors who appear in the film Alone Trip.

Select first_name, last_name
from actor
WHERE actor_id in (
 select actor_id 
 from film_actor
 where film_id=(
 select film_id
 from film
 where title='alone Trip')
 );


-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

Select title
from film
WHERE film_id in (
 select film_id 
 from film_category
 where category_id=(
 select category_id
 from category
 where name='family')
 );

-- Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, 
-- you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

Select first_name, email
from customer
WHERE address_id in (
 select address_id 
 from address
 where city_id in(
 select city_id
 from city
 where country_id=(
 select country_id
 from country
 where country='canada')
 ));


-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films.
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

Select title
from film
WHERE film_id in (
 select film_id 
 from film_actor
 where actor_id=(
 select actor_id
 from film_actor
 group by actor_id
 order by count(film_id) desc
 limit 1
 )
 );
 

-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

Select title
from film
WHERE film_id in (
 select film_id 
 from inventory
 where inventory_id in (
 select inventory_id
 from rental
 where customer_id =(
 select customer_id
 from payment
 group by customer_id
 order by sum(amount) DESC
 Limit 1
 )
 ));

-- Customers who spent more than the average payments.

Select distinct customer_id
from payment
where amount>(select avg(amount) from payment)
group by customer_id;


select avg(amount)
from payment;

select *
from payment;
