use sakila;

# Review the tables in the database: explore all columns of the following tables
select * from country, store, rental, actor, address, category;

# Select one column from a table: get the column "title" from table "film" 
select title from film;

# get the unique list languages and show it with title "language" 
SELECT DISTINCT name as language FROM language;

#SELECT * from store; 

#5.1 Find out how many stores does the company have?
SELECT count(store_id) from store;
select count(*) from store;

#5.2 Find out how many employees staff does the company have?
SELECT count(staff_id) from staff;

#5.3 Return a list of employee first names only?
SELECT first_name from staff;


