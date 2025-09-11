-- SQL Basics Assignment Solutions 

-- Q1. Create a table called employees with the following structure:
-- emp_id (integer, should not be NULL and should be a primary key)
-- emp_name (text, should not be NULL)
-- age (integer, should have a check constraint to ensure the age is at least 18)
-- email (text, should be unique for each employee)
-- salary (decimal, with a default value of 30,000).
-- Answer:
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(150) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000
);

-- Q2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
-- Answer:
-- Constraints help maintain accuracy, reliability, and integrity of data.
-- Examples:
-- PRIMARY KEY → Ensures unique identification of rows.
-- FOREIGN KEY → Ensures referential integrity between tables.
-- NOT NULL → Prevents NULL values where data must exist.
-- UNIQUE → Ensures no duplicate values in a column.
-- CHECK → Ensures a condition (e.g., age >= 18).
-- DEFAULT → Assigns a value when none is provided.

-- Q3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
-- Answer:
-- NOT NULL ensures that a column cannot be left empty.
-- Example: emp_name VARCHAR(100) NOT NULL
-- PRIMARY KEY cannot contain NULL values because every row must be uniquely identified.

-- Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
-- Answer:
ALTER TABLE employees
ADD CONSTRAINT chk_salary CHECK (salary > 0);

ALTER TABLE employees
DROP CONSTRAINT chk_salary;

-- Q5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
-- Answer:
INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (1, 'UBAID', 15, 'ubaid21@gmail.com');
-- Error: CHECK constraint failed: age must be >= 18

-- Q6. You created a products table without constraints as follows:
-- CREATE TABLE products (
--   product_id INT,
--   product_name VARCHAR(50),
--   price DECIMAL(10, 2)
-- );
-- Now, you realise that:
-- The product_id should be a primary key
-- The price should have a default value of 50.00
-- Answer:
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

-- Q7. You have two tables: Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
-- Answer:
SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c
ON s.class_id = c.class_id;

-- Q8. Consider the following three tables: Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order. (Hint: use INNER JOIN and LEFT JOIN)
-- Answer:
SELECT o.order_id, cu.customer_name, p.product_name
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
INNER JOIN customers cu ON o.customer_id = cu.customer_id;

-- Q9. Given the following tables: Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
-- Answer:
SELECT p.product_name, SUM(o.amount) AS total_sales
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name;

-- Q10. You are given three tables: Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.
-- Answer:
SELECT o.order_id, c.customer_name, oi.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id;


-- SQL Commands Assignment Solutions 

-- Q1. Identify the primary keys and foreign keys in maven movies db. Discuss the differences.
-- Answer:
-- PRIMARY KEY uniquely identifies a row in a table (e.g., customer_id in customer table).
-- FOREIGN KEY is used to link two tables (e.g., store_id in customer table referencing store table).

-- Q2. List all details of actors
-- Answer:
SELECT * FROM actor;

-- Q3. List all customer information from DB.
-- Answer:
SELECT * FROM customer;

-- Q4. List different countries.
-- Answer:
SELECT DISTINCT country FROM country;

-- Q5. Display all active customers.
-- Answer:
SELECT * FROM customer WHERE active = 1;

-- Q6. List of all rental IDs for customer with ID 1.
-- Answer:
SELECT rental_id FROM rental WHERE customer_id = 1;

-- Q7. Display all the films whose rental duration is greater than 5.
-- Answer:
SELECT * FROM film WHERE rental_duration > 5;

-- Q8. List the total number of films whose replacement cost is greater than $15 and less than $20.
-- Answer:
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

-- Q9. Display the count of unique first names of actors.
-- Answer:
SELECT COUNT(DISTINCT first_name) AS unique_first_names FROM actor;

-- Q10. Display the first 10 records from the customer table.
-- Answer:
SELECT * FROM customer LIMIT 10;

-- Q11. Display the first 3 records from the customer table whose first name starts with ‘b’.
-- Answer:
SELECT * FROM customer
WHERE first_name LIKE 'b%'
LIMIT 3;

-- Q12. Display the names of the first 5 movies which are rated as ‘G’.
-- Answer:
SELECT title FROM film
WHERE rating = 'G'
LIMIT 5;

-- Q13. Find all customers whose first name starts with "a".
-- Answer:
SELECT * FROM customer
WHERE first_name LIKE 'a%';

-- Q14. Find all customers whose first name ends with "a".
-- Answer:
SELECT * FROM customer
WHERE first_name LIKE '%a';

-- Q15. Display the list of first 4 cities which start and end with ‘a’.
-- Answer:
SELECT city FROM city
WHERE city LIKE 'a%a'
LIMIT 4;

-- Q16. Find all customers whose first name have "NI" in any position.
-- Answer:
SELECT * FROM customer
WHERE first_name LIKE '%NI%';

-- Q17. Find all customers whose first name have "r" in the second position.
-- Answer:
SELECT * FROM customer
WHERE first_name LIKE '_r%';

-- Q18. Find all customers whose first name starts with "a" and are at least 5 characters in length.
-- Answer:
SELECT * FROM customer
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

-- Q19. Find all customers whose first name starts with "a" and ends with "o".
-- Answer:
SELECT * FROM customer
WHERE first_name LIKE 'a%o';

-- Q20. Get the films with pg and pg-13 rating using IN operator.
-- Answer:
SELECT * FROM film
WHERE rating IN ('PG', 'PG-13');

-- Q21. Get the films with length between 50 to 100 using between operator.
-- Answer:
SELECT * FROM film
WHERE length BETWEEN 50 AND 100;

-- Q22. Get the top 50 actors using limit operator.
-- Answer:
SELECT * FROM actor
LIMIT 50;

-- Q23. Get the distinct film ids from inventory table.
-- Answer:
SELECT DISTINCT film_id FROM inventory;


-- SQL Functions, Joins, and Window Functions Solutions 

-- FUNCTIONS

-- Q1. Retrieve the total number of rentals made in the Sakila database.
-- Answer:
SELECT COUNT(*) AS total_rentals FROM rental;

-- Q2. Find the average rental duration (in days) of movies rented from the Sakila database.
-- Answer:
SELECT AVG(rental_duration) AS avg_rental_days FROM film;

-- Q3. Display the first name and last name of customers in uppercase.
-- Answer:
SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name FROM customer;

-- Q4. Extract the month from the rental date and display it alongside the rental ID.
-- Answer:
SELECT rental_id, EXTRACT(MONTH FROM rental_date) AS rental_month FROM rental;

-- Q5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
-- Answer:
SELECT customer_id, COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id;

-- Q6. Find the total revenue generated by each store.
-- Answer:
SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

-- Q7. Determine the total number of rentals for each category of movies.
-- Answer:
SELECT c.name AS category, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Q8. Find the average rental rate of movies in each language.
-- Answer:
SELECT l.name AS language, AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

-- JOINS

-- Q9. Display the title of the movie, customer's first name, and last name who rented it.
-- Answer:
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

-- Q10. Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
-- Answer:
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

-- Q11. Retrieve the customer names along with the total amount they've spent on rentals.
-- Answer:
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN rental r ON p.rental_id = r.rental_id
GROUP BY c.first_name, c.last_name;

-- Q12. List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- Answer:
SELECT cu.first_name, cu.last_name, f.title
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON cu.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY cu.first_name, cu.last_name, f.title;

-- Q13. Display the top 5 rented movies along with the number of times they've been rented.
-- Answer:
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

-- Q14. Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Answer:
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT s.store_id) = 2;

-- WINDOW FUNCTIONS

-- Q1. Rank the customers based on the total amount they've spent on rentals.
-- Answer:
SELECT c.customer_id, c.first_name, c.last_name, 
       SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS rank_order
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Q2. Calculate the cumulative revenue generated by each film over time.
-- Answer:
SELECT f.title, p.payment_date, SUM(p.amount) 
       OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id;

-- Q3. Determine the average rental duration for each film, considering films with similar lengths.
-- Answer:
SELECT f.title, f.length, 
       AVG(f.rental_duration) OVER (PARTITION BY f.length) AS avg_rental_duration
FROM film f;

-- Q4. Identify the top 3 films in each category based on their rental counts.
-- Answer:
SELECT c.name AS category, f.title, COUNT(r.rental_id) AS rental_count,
       RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name, f.title;

-- Q5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
-- Answer:
SELECT c.customer_id, c.first_name, c.last_name, 
       COUNT(r.rental_id) AS total_rentals,
       COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER() AS diff_from_avg
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Q6. Find the monthly revenue trend for the entire rental store over time.
-- Answer:
SELECT DATE_TRUNC('month', p.payment_date) AS month, SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY DATE_TRUNC('month', p.payment_date)
ORDER BY month;

-- Q7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
-- Answer:
SELECT customer_id, first_name, last_name, total_spent
FROM (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
           NTILE(5) OVER (ORDER BY SUM(p.amount) DESC) AS percentile_rank
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) ranked_customers
WHERE percentile_rank = 1;

-- Q8. Calculate the running total of rentals per category, ordered by rental count.
-- Answer:
SELECT c.name AS category, COUNT(r.rental_id) AS rental_count,
       SUM(COUNT(r.rental_id)) OVER (ORDER BY COUNT(r.rental_id)) AS running_total
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;

-- Q9. Find the films that have been rented less than the average rental count for their respective categories.
-- Answer:
SELECT f.title, c.name AS category, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY f.title, c.name
HAVING COUNT(r.rental_id) < AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.name);

-- Q10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
-- Answer:
SELECT month, monthly_revenue
FROM (
    SELECT DATE_TRUNC('month', p.payment_date) AS month, SUM(p.amount) AS monthly_revenue,
           RANK() OVER (ORDER BY SUM(p.amount) DESC) AS revenue_rank
    FROM payment p
    GROUP BY DATE_TRUNC('month', p.payment_date)
) ranked_months
WHERE revenue_rank <= 5;


-- Normalization & CTE Solutions

-- NORMALIZATION

-- Q1. First Normal Form (1NF):
-- a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
-- Answer:
-- Example: If a table "customer_orders" stores multiple order IDs in one column (comma-separated), it violates 1NF.
-- To normalize: create a separate table "orders" where each row contains a single order_id with customer_id as foreign key.

-- Q2. Second Normal Form (2NF):
-- a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
-- If it violates 2NF, explain the steps to normalize it.
-- Answer:
-- Example: A table with composite key (film_id, actor_id) but with non-key attribute like film_title violates 2NF.
-- To normalize: separate into Film table (film_id, film_title) and Film_Actor table (film_id, actor_id).

-- Q3. Third Normal Form (3NF):
-- a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.
-- Answer:
-- Example: If a table stores (customer_id, city, country), then city → country is a transitive dependency.
-- To normalize: separate into City table (city_id, city, country_id) and Customer table (customer_id, city_id).

-- Q4. Normalization Process:
-- a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
-- Answer:
-- Step 1 (Unnormalized): Customer table with repeating groups (multiple phone numbers in one row).
-- Step 2 (1NF): Split into separate rows for each phone number.
-- Step 3 (2NF): If composite key exists, remove partial dependencies by splitting into separate tables.

-- CTE BASICS

-- Q5. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.
-- Answer:
WITH ActorFilmCount AS (
    SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT * FROM ActorFilmCount;

-- Q6. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.
-- Answer:
WITH FilmLang AS (
    SELECT f.title, l.name AS language, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM FilmLang;

-- Q7. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.
-- Answer:
WITH CustomerRevenue AS (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT * FROM CustomerRevenue;

-- Q8. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
-- Answer:
WITH FilmRank AS (
    SELECT title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT * FROM FilmRank;

-- Q9. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.
-- Answer:
WITH FrequentRenters AS (
    SELECT customer_id, COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)
SELECT c.customer_id, c.first_name, c.last_name, fr.rental_count
FROM customer c
JOIN FrequentRenters fr ON c.customer_id = fr.customer_id;

-- Q10. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table.
-- Answer:
WITH MonthlyRentals AS (
    SELECT DATE_TRUNC('month', rental_date) AS rental_month, COUNT(*) AS total_rentals
    FROM rental
    GROUP BY DATE_TRUNC('month', rental_date)
)
SELECT * FROM MonthlyRentals;

-- Q11. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
-- Answer:
WITH ActorPairs AS (
    SELECT fa1.film_id, fa1.actor_id AS actor1, fa2.actor_id AS actor2
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT * FROM ActorPairs;

-- Q12. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column.
-- Answer:
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE staff_id = 1   -- Replace with manager_id

    UNION ALL

    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    INNER JOIN EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * FROM EmployeeHierarchy;


