# Library Management System (SQL Database Project)

## Overview
A relational database system designed to manage library operations including book inventory, member records, book issuing, and fine tracking. Built using SQL with a normalized schema and demonstrates real-world querying techniques used in support and data-related roles.

## Objective
To design a properly normalized database that models a library's core operations and to write queries that solve common reporting and troubleshooting problems — similar to what a Support/Database Engineer handles in production environments.

## Database Schema

The project consists of 4 related tables:

| Table | Description |
|-------|-------------|
| **Books** | Stores book details — title, author, genre, total and available copies |
| **Members** | Stores library member details |
| **Issued_Books** | Tracks which member issued which book, and on what dates |
| **Fines** | Tracks fines generated for late returns |

### Relationships
- `Issued_Books.book_id` → references `Books.book_id`
- `Issued_Books.member_id` → references `Members.member_id`
- `Fines.issue_id` → references `Issued_Books.issue_id`

The schema follows normalization principles (up to 3NF) to avoid data redundancy and maintain data integrity through primary and foreign key constraints.

## Key SQL Concepts Used
- Table creation with **Primary Key** and **Foreign Key** constraints
- **JOIN** operations across multiple tables
- **GROUP BY** and aggregate functions (`COUNT`)
- **Window Functions** — `RANK() OVER (PARTITION BY ... ORDER BY ...)`
- Filtering with `WHERE` and `NULL` handling

## Sample Queries

**1. Member-wise total books issued**
```sql
SELECT m.name, COUNT(i.issue_id) AS total_books
FROM Members m
JOIN Issued_Books i ON m.member_id = i.member_id
GROUP BY m.name;
```

**2. Books currently unavailable**
```sql
SELECT title, genre, available_copies
FROM Books
WHERE available_copies = 0;
```

**3. Rank books by copies within each genre (Window Function)**
```sql
SELECT genre, title, total_copies,
RANK() OVER (PARTITION BY genre ORDER BY total_copies DESC) AS rnk
FROM Books;
```

## Tech Stack
- SQL (SQLite / MySQL compatible)
- Tested using DB Fiddle / SQLite

## What This Project Demonstrates
- Ability to design a normalized relational schema from scratch
- Writing multi-table JOIN queries for real reporting needs
- Using window functions for ranked/grouped analysis
- Understanding of data integrity via constraints

## Future Improvements
- Add stored procedures for issuing/returning books automatically
- Add triggers to auto-update `available_copies` on issue/return
- Build a simple Python (CLI) interface on top of this schema

## Author
Shahadat — Aspiring SQL / Support Engineer
