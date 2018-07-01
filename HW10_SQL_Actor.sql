SELECT first_name, last_name FROM sakila.actor;

Describe actor;

SELECT concat(first_name, last_name) AS 'Actor Name' FROM actor; 

SELECT actor_id, first_name, last_name FROM sakila.actor
WHERE first_name = "Joe";

SELECT last_name FROM actor
WHERE last_name LIKE '%GEN%';

SELECT last_name, first_name FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD middle_name varchar(45);

ALTER TABLE actor
MODIFY middle_name blob;

ALTER TABLE actor
DROP COLUMN middle_name;

SELECT last_name, count(last_name)  FROM sakila.actor
group by last_name;

SELECT last_name, count(last_name)  FROM sakila.actor
group by last_name HAVING count(last_name) >= 2;

UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id = 172;

SELECT staff.first_name, staff.last_name, staff.address_id, address.address_id
FROM staff
INNER JOIN address
ON address.address_id = staff.address_id;

SELECT amount, SUM(amount) FROM payment
WHERE staff_id IN 
(
	SELECT staff_id FROM staff
    WHERE first_name, last_name IN 
    (
		SELECT first_name, last_name
        FROM staff
        WHERE payment_date LIKE '%05-08%'
	)
);

SELECT film_actor.film_id, film_actor.actor_id, film.title, film.film_id
FROM film
INNER JOIN film_actor ON
film_actor.film_id = film.film_id;

SELECT SUM(inventory_id) FROM inventory
WHERE film_id IN 
(
	SELECT film_id FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
);

SELECT customer.first_name, customer.last_name, customer.customer_id, payment.customer_id, payment.amount
FROM customer
INNER JOIN payment ON
customer.customer_id = payment.customer_id
ORDER BY last_name ASC;


SELECT * FROM language
WHERE language_id = 
(
	SELECT language_id
    FROM film
    WHERE title = 
    (
		SELECT title
        FROM film
        WHERE title LIKE 'K%' AND 'Q%'
	)
);

SELECT first_name, last_name FROM actor
WHERE actor_id IN
(
	SELECT actor_id FROM film_actor
	WHERE film_id = 
	(
		SELECT film_id FROM film
		WHERE title = 'ALONE TRIP'
	)
);

SELECT first_name, last_name, email FROM customer
WHERE address_id IN
(
	SELECT address_id FROM address
    WHERE city_id IN
    (
		SELECT city_id FROM city
        WHERE country_id = 20
	)
);

SELECT title, rental_rate FROM sakila.film
ORDER BY rental_rate DESC;

SELECT store_id FROM payment
WHERE staff_id IN
(
	SELECT staff_id FROM staff
    WHERE store_id IN
    (
		SELECT store_id FROM store
        ORDER BY store_id ASC
	)
);

SELECT store_id FROM store
WHERE address_id IN
(
	SELECT address_id FROM address
    WHERE city_id IN
    (
		SELECT city_id FROM city
        WHERE city IN
        (
			SELECT city FROM city
            WHERE country_id IN
            (
				SELECT country_id FROM country
				ORDER BY country
			)
		)
	)
);

SELECT name FROM category
WHERE category_id IN
(
	SELECT category_id FROM film_category
    WHERE film_id IN
    (
		SELECT film_id FROM inventory
        WHERE inventory_id IN
        (
			SELECT inventory_id FROM rental
            WHERE rental_id IN
            (
				SELECT rental_id FROM payment
                WHERE amount IN
                (
					SELECT amount FROM payment
                    ORDER BY amount DESC
				)
			)
		)
	)
);

CREATE VIEW top_five_genres AS
SELECT name FROM category
WHERE category_id IN
(
	SELECT category_id FROM film_category
    WHERE film_id IN
    (
		SELECT film_id FROM inventory
        WHERE inventory_id IN
        (
			SELECT inventory_id FROM rental
            WHERE rental_id IN
            (
				SELECT rental_id FROM payment
                WHERE amount IN
                (
					SELECT amount FROM payment
                    ORDER BY amount DESC
				)
			)
		)
	)
);

DROP VIEW top_five_genres

