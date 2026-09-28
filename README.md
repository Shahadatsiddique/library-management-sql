# Library Management System — SQL & MySQL

## Overview

A relational database project designed to manage basic library operations such as book inventory, member records, book issuing, and fine tracking.

The project was built using SQL and MySQL and focuses on practical database concepts such as relational table design, primary and foreign keys, JOINs, aggregation, filtering, window functions, CTEs, and stored procedures.

## Objective

The objective of this project is to design a structured library database and use SQL queries to perform common data retrieval and analysis tasks.

The project demonstrates how SQL can be used to:

* Manage related records across multiple tables
* Track books and their availability
* Track members and issued books
* Analyze book issuance using aggregate functions
* Rank books based on the number of copies
* Organize analytical queries using CTEs
* Create reusable stored procedures for frequently used operations

---

## Database Schema

The database contains four related tables:

| Table            | Description                                                                                |
| ---------------- | ------------------------------------------------------------------------------------------ |
| **Books**        | Stores book information including title, author, genre, total copies, and available copies |
| **Members**      | Stores library member information such as name, email, and joining date                    |
| **Issued_Books** | Tracks which member issued which book along with issue and return dates                    |
| **Fines**        | Stores fine information related to issued books, including amount and payment status       |

### Relationships

```text
Books
  │
  │ book_id
  ▼
Issued_Books
  │
  │ member_id
  ▼
Members

Issued_Books
  │
  │ issue_id
  ▼
Fines
```

### Foreign Key Relationships

* `Issued_Books.book_id` → `Books.book_id`
* `Issued_Books.member_id` → `Members.member_id`
* `Fines.issue_id` → `Issued_Books.issue_id`

Primary and foreign key constraints are used to establish relationships between the tables and maintain data integrity.

---

## Database Structure

### 1. Books

Stores information about the books available in the library.

Main columns:

* `book_id`
* `title`
* `author`
* `genre`
* `total_copies`
* `available_copies`

### 2. Members

Stores library member information.

Main columns:

* `member_id`
* `name`
* `email`
* `join_date`

### 3. Issued_Books

Tracks books issued to members.

Main columns:

* `issue_id`
* `book_id`
* `member_id`
* `issue_date`
* `return_date`

### 4. Fines

Stores fines associated with issued books.

Main columns:

* `fine_id`
* `issue_id`
* `amount`
* `paid`

---

# Key SQL Concepts Used

## 1. Primary & Foreign Keys

Primary keys uniquely identify records in each table, while foreign keys connect related tables.

Examples:

```sql
PRIMARY KEY (book_id)
```

and:

```sql
FOREIGN KEY (book_id)
REFERENCES Books(book_id)
```

---

## 2. JOIN & GROUP BY

The project uses `JOIN` and `GROUP BY` to analyze the number of books issued by each member.

### Example

```sql
SELECT
    m.name,
    COUNT(i.issue_id) AS total_books
FROM Members m
JOIN Issued_Books i
    ON m.member_id = i.member_id
GROUP BY m.name;
```

This combines member information with issued-book records and calculates the total number of issued books for each member.

---

## 3. Filtering with WHERE

The project uses `WHERE` to retrieve books based on their available copies.

### Example

```sql
SELECT
    author,
    title
FROM Books
WHERE available_copies = 2;
```

This returns books that currently have exactly two available copies.

---

## 4. Window Functions

The project uses multiple SQL window functions to rank books based on their total number of copies.

### ROW_NUMBER()

```sql
ROW_NUMBER() OVER (
    ORDER BY total_copies DESC
)
```

### RANK()

```sql
RANK() OVER (
    ORDER BY total_copies DESC
)
```

### DENSE_RANK()

```sql
DENSE_RANK() OVER (
    ORDER BY total_copies DESC
)
```

These functions are used to demonstrate different ranking approaches on the book data.

---

## 5. Ranking Books Within Each Genre

The project also uses `PARTITION BY` with `RANK()` to rank books separately within each genre.

```sql
SELECT
    genre,
    title,
    total_copies,
    RANK() OVER (
        PARTITION BY genre
        ORDER BY total_copies DESC
    ) AS genre_rank
FROM Books;
```

This allows the ranking to restart for each genre.

---

## 6. Ranking Based on Available Copies

The project also ranks books according to their available copies.

```sql
SELECT
    genre,
    title,
    available_copies,
    RANK() OVER (
        ORDER BY available_copies DESC
    ) AS availability_rank
FROM Books;
```

This can be used to identify books with higher availability.

---

# Common Table Expression (CTE)

A CTE is used to organize ranked book data before selecting the required columns.

```sql
WITH RankedBooks AS (
    SELECT
        genre,
        title,
        total_copies,
        RANK() OVER (
            ORDER BY total_copies DESC
        ) AS rnk
    FROM Books
)
SELECT
    genre,
    title,
    total_copies,
    rnk
FROM RankedBooks;
```

This demonstrates how a CTE can be combined with a window function to make analytical queries easier to organize and read.

---

# Stored Procedures

The project includes stored procedures for reusable database operations.

## 1. GetBooks

A parameterized stored procedure is used to retrieve books having at least a specified number of total copies.

```sql
CREATE PROCEDURE GetBooks(IN min_copies INT)
BEGIN
    SELECT
        genre,
        title,
        total_copies
    FROM Books
    WHERE total_copies >= min_copies
    ORDER BY total_copies DESC;
END
```

Example:

```sql
CALL GetBooks(4);
```

This procedure accepts `min_copies` as an input parameter and returns matching books.

---

## 2. GetBooksRankedByCopies

A second stored procedure retrieves books along with their rank based on total copies.

```sql
CREATE PROCEDURE GetBooksRankedByCopies()
BEGIN
    SELECT
        genre,
        title,
        total_copies,
        RANK() OVER (
            ORDER BY total_copies DESC
        ) AS copy_rank
    FROM Books;
END
```

Example:

```sql
CALL GetBooksRankedByCopies();
```

This demonstrates the use of window functions inside a stored procedure.

---

# Sample Data

The project includes sample records for:

* 5 books
* 4 members
* 5 issued-book records
* 2 fine records

The sample data allows the SQL queries, ranking functions, CTE, and stored procedures to be tested against realistic library-related records.

---

# Tech Stack

* **Database:** MySQL
* **Language:** SQL
* **Database Tool:** MySQL Workbench
* **Version Control:** Git / GitHub

---

# What This Project Demonstrates

This project demonstrates practical understanding of:

* Relational database design
* Primary and foreign key relationships
* SQL table creation and data insertion
* JOIN operations
* `GROUP BY` and aggregate functions
* Filtering using `WHERE`
* Sorting using `ORDER BY`
* Window functions
* `ROW_NUMBER()`
* `RANK()`
* `DENSE_RANK()`
* `PARTITION BY`
* Common Table Expressions (CTEs)
* Stored procedures
* Parameterized stored procedures
* Basic database data analysis

---

# Project Structure

```text
Library-Management-System/
│
├── library.sql
└── README.md
```

The `library.sql` file contains the database structure, sample data, SQL queries, window-function examples, CTE, and stored procedures.

---

# Future Improvements

Possible future enhancements include:

* Add triggers to automatically update `available_copies` when books are issued or returned
* Add procedures for issuing and returning books
* Add more detailed fine calculations
* Add additional reporting queries
* Build a Python CLI application connected to the MySQL database
* Add a simple frontend for library operations

---

# Author

**Shahadat Siddique**

Aspiring Software Engineer / Python Developer / SQL Developer
