# Interview Notes

## What did you build?
A normalized MySQL database for managing students, departments, courses, enrollments, marks, attendance and fees.

## Why normalization?
To reduce duplicate data and improve consistency. Related entities are stored separately and connected using foreign keys.

## Why primary keys?
They uniquely identify records.

## Why foreign keys?
They maintain relationships and referential integrity between tables.

## What is a JOIN?
A JOIN combines rows from related tables using a matching condition.

## What did you do for optimization?
I added indexes to columns commonly used in joins and filtering and used EXPLAIN to inspect query execution plans.

## What is deduplication?
Finding and handling duplicate records. This project includes duplicate-detection queries and UNIQUE constraints.

## What is a VIEW?
A saved SQL query that can be used like a virtual table for reusable reporting.

## What should you improve next?
- Add a FastAPI API
- Add authentication
- Add pagination
- Add automated tests
- Add a small HTML/CSS/JavaScript dashboard
