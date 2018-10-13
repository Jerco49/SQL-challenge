-- USE sakila;

-- 1a
/*
select first_name, last_name
from actor;
*/

-- 1b
/*
select concat(first_name, ' ', last_name) as Actor_Name
from actor;
*/

-- 2a
/*
select actor_id, first_name, last_name
from actor
where first_name = "Joe";
*/

-- 2b
/*
select actor_id, first_name, last_name
from actor
where last_name like '%GEN%';
*/

-- 2c
/*
select actor_id, first_name, last_name
from actor
where last_name like '%LI%'
order by last_name, first_name;
*/

-- 2d
/*
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');
*/

-- 3a
/*
alter table actor add description
	BLOB;
*/

-- 3b

/* alter table actor drop description; */

-- 4a
/*
select last_name, count(*) as matching
from actor
group by last_name;
*/

-- 4b
/*
select last_name, count(*) as matching
from actor
group by last_name
having matching >= 2;
*/

-- 4c
/*
update actor
set first_name = "HARPO"
WHERE (first_name = "GROUCHO") and (last_name = "WILLIAMS");
*/

-- 4d
/*
update actor
set first_name = "GROUCHO"
WHERE (first_name = "HARPO") and (last_name = "WILLIAMS");
*/

-- 5a
/*
show create table address;
*/

-- 6a
/*
select staff.first_name, staff.last_name, address.address
from staff
left join address on staff.address_id = address.address_id;
*/

-- 6b
/*
select staff.first_name, staff.last_name, sum(payment.amount) as Total_Amount
from staff
left join payment on staff.staff_id = payment.staff_id
group by first_name
order by first_name;
*/

-- 6c
/*
select film.title, count(film_actor.actor_id) as Actors_per_Title
from film
inner join film_actor on film.film_id = film_actor.film_id
group by film.title
order by film.title;
*/

-- 6d
/*
select film.title, count(inventory.inventory_id) as In_Inventory
from film
inner join inventory on film.film_id = inventory.film_id
where film.title = 'Hunchback Impossible';
*/

-- 6e
/*
select customer.first_name, customer.last_name, sum(payment.amount) as Total_Amount_Paid
from payment
left join customer on payment.customer_id = customer.customer_id
group by customer.last_name
order by customer.last_name;
*/

-- 7a
/*
select title
from film
where (title like 'K%' or 'Q%') and (language_id in 
	(
		select language_id
        from language
        where name = 'English'
	)
);
*/

-- 7b
/*
select first_name, last_name
from actor
where actor_id in 
	(
		select actor_id
        from film_actor
        where film_id in 
			(
				select film_id
                from film
                where title = 'Alone Trip'
			)
	);
*/

-- 7c
/*
select customer.first_name, customer.last_name, customer.email
from customer
left join address on customer.address_id = address.address_id
left join city on address.city_id = city.city_id
left join country on city.country_id = country.country_id
where country.country = 'Canada';
*/

-- 7d
/*
select title
from film
where rating = 'G' or 'PG';
*/

-- 7e
/*
select film.title, count(payment.payment_id) as Times_Rented
from payment
left join rental on payment.rental_id = rental.rental_id
left join inventory on rental.inventory_id = inventory.inventory_id
left join film on inventory.film_id = film.film_id
group by film.title
order by Times_Rented desc;
*/

-- 7f
/*
select store.store_id, sum(payment.amount) as Total_Business
from payment
left join customer on payment.customer_id = customer.customer_id
left join store on customer.store_id = store.store_id
group by store.store_id;
*/

-- 7g
/*
select store.store_id, city.city, country.country
from store
left join address on store.address_id = address.address_id
left join city on address.city_id = city.city_id
left join country on city.country_id = country.country_id
group by store.store_id;
*/

-- 7h
/*
select category.name, sum(payment.amount) as Total_Revenue
from rental
left join inventory on rental.inventory_id = inventory.inventory_id
left join payment on rental.rental_id = payment.rental_id 
left join film_category on inventory.film_id = film_category.film_id
left join category on film_category.category_id = category.category_id

-- right join film_category on category.category_id = film_category.category_id
-- right join inventory on film_category.film_id = inventory.film_id
-- right join rental on inventory.inventory_id = rental.inventory_id
-- right join payment on payment.rental_id = rental.rental_id

group by category.name
order by sum(payment.amount) desc
limit 5;

-- payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
*/

-- 8a
/*
create view top_categories_query as 
(
	select category.name, sum(payment.amount) as Total_Revenue
	from rental
	left join inventory on rental.inventory_id = inventory.inventory_id
	left join payment on rental.rental_id = payment.rental_id 
	left join film_category on inventory.film_id = film_category.film_id
	left join category on film_category.category_id = category.category_id
	group by category.name
	order by sum(payment.amount) desc
	limit 5;
);
*/

-- 8b

-- select * from top_categories_query;

-- 8c

-- drop view top_categories_query;