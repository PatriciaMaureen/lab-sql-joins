USE sakila;
-- 1. 
SELECT c.name, COUNT(fc.film_id) AS num_films
FROM sakila.film_category fc
JOIN sakila.category c
ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY num_films DESC;

-- 2. 
SELECT s.store_id, c.city, co.country
FROM sakila.store s
JOIN sakila.address a 
ON s.address_id = a.address_id
JOIN sakila.city c
ON a.city_id = c.city_id
JOIN sakila.country co
ON c.country_id = co.country_id;

-- 3.
SELECT st.store_id, SUM(p.amount) AS total_revenue
FROM sakila.payment p
JOIN sakila.staff s
ON p.staff_id = s.staff_id
JOIN sakila.store st
ON s.store_id = st.store_id
GROUP BY st.store_id
ORDER BY total_revenue DESC;

-- 4. 
SELECT c.name AS category_name, AVG(f.length) AS avg_running_time
FROM sakila.film f
JOIN sakila.film_category fc
ON f.film_id = fc.film_id
JOIN sakila.category c
ON c.category_id = fc.category_id
GROUP BY category_name
ORDER BY avg_running_time DESC;

-- 5.
SELECT c.name AS category_name, AVG(f.length) AS avg_running_time
FROM sakila.film f
JOIN sakila.film_category fc
ON f.film_id = fc.film_id
JOIN sakila.category c
ON c.category_id = fc.category_id
GROUP BY category_name
ORDER BY avg_running_time DESC
LIMIT 3;

-- 6. I assume with most frequent you mean the last 10 movies that were rented.
SELECT f.title AS film, COUNT(r.rental_id) AS rental_count
FROM sakila.rental r
JOIN sakila.inventory i
ON r.inventory_id = i.inventory_id 
JOIN sakila.film f
ON i.film_id = f.film_id
GROUP BY film
ORDER BY rental_count DESC
LIMIT 10;

-- 7. Yes it seems like we have 4 copys of that 
SELECT f.title AS film, s.store_id
FROM sakila.film f
JOIN sakila.inventory i
ON f.film_id = i.film_id
JOIN sakila.store s
ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;

-- 8. 
SELECT * FROM sakila.inventory; 
SELECT
    f.title AS film_title,
    CASE
        WHEN i.film_id IS NOT NULL THEN 'Available'
        ELSE 'NOT Available'
    END AS availability_status
FROM
    film f
LEFT JOIN
    inventory i ON f.film_id = i.film_id
GROUP BY
    f.title, i.inventory_id;