# SQL DVD Queries Project

This is a repo of my SQL project where I practice various SQL queries using the dvdrental database. The dvdrental database is a sample database from the SQL - From Zero to Hero course on Udemy. It contains fictional data about a DVD rental store.

## Database Schema

The dvdrental database consists of 15 tables: actor, film, film_actor, category, film_category, store, inventory, rental, payment, staff, customer, address, city, country, and language. The following ER diagram shows the relationships between these tables.

!ER diagram

## Queries

In this project, I wrote SQL queries to answer various questions about the DVD rental business, such as:

- What are the most popular genres in each country?
- Which actors have the most loyal customers?
- How does the staff performance affect the revenue?
- What are the best months and days to run promotions?

The queries are organized in ascending order of complexity, from basic queries using SELECT, WHERE, and ORDER BY clauses, to advanced queries using JOIN, GROUP BY, HAVING, and subqueries. You can find the queries and the results in the queries folder.

## How to Run the Queries

To run the queries, you need to have PostgreSQL installed on your machine. You can download PostgreSQL from here. After installing PostgreSQL, you need to restore the dvdrental database using the dvdrental.tar file. You can find the instructions on how to do that here. Once you have the database ready, you can use any PostgreSQL client, such as pgAdmin or psql, to connect to the database and run the queries.
