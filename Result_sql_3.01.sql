use sakila;

/*
1. Drop column picture from staff.
*/
ALTER TABLE staff
DROP COLUMN picture;

SELECT * FROM staff;
/*
2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
*/
SELECT * FROM staff; -- to check on the structure of data neded for the task
-- (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)

-- Get the relevant info from other table, store and customer

SELECT c.first_name, c.last_name, c.address_id, c.email, s.store_id 
FROM customer c 
JOIN staff s WHERE s.first_name LIKE ('Jon') AND
c.first_name LIKE ('Tammy') AND c.last_name LIKE ('Sanders');


-- then I copy the row from the output line and paste it in my values line and add other column values

INSERT INTO staff
(first_name, last_name, address_id, email, store_id, active, username, password ,last_update)
VALUES
('Tammy', 'Sanders', '79', 'TAMMY.SANDERS@sakilacustomer.org', '2', 1, 'Tammy', null, DATE(NOW()));

SELECT * FROM staff; -- to check on output.

/*
3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
Use similar method to get inventory_id, film_id, and staff_id.
*/


-- TO FIND OUT, WHICH COLUMNS ARE NEEDED
SELECT * FROM rental; -- to check on needed colums

-- FIND THE FILM ID
SELECT title , film_id FROM film WHERE title = "Academy Dinosaur";

-- FIND CUSTOMER ID OF CHARLOTTE
SELECT customer_id FROM customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'; 

-- to find out, which staff id mike has, and in which store he is occupied
SELECT staff_id, store_id FROM staff WHERE first_name = 'Mike'; 

-- to find the inventory id of the requested film in the correct store.
-- we see that we can use inventory IDs from 1-4 to inster a rent approach into rental table, because Mike is an employee of store 1
SELECT f.title, f.film_id, i.inventory_id, i.store_id FROM film f
JOIN inventory i USING (film_id)
WHERE f.title = 'Academy Dinosaur'AND store_id = 1; 

-- THEN CHECK IF ANY COPY IS NOT RENTABLE, BECAUSE ITS NOT AVAILABLE IN STORE
 SELECT inventory_id, rental_date, return_date FROM rental
 WHERE return_date IS null AND inventory_id IN (1,2,3,4); -- all cpoies seem to be available, so I pick inventory_id 1

 
-- INSERT the rental
INSERT INTO rental
(rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES
(DATE(NOW()), 1, 130, null, 1, DATE(NOW()));

SELECT * FROM rental WHERE customer_id = 130
ORDER BY rental_date DESC; -- as a result i can find the rental ID 16050 for my inserted rental









