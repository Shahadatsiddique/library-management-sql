# Advanced SQL Practice | Day 13 of My Job-Ready Journey

## 📌 Project Overview

This repository documents my hands-on practice with **Advanced SQL using MySQL**, as part of my journey toward becoming a job-ready software developer.

**Day 13 of my overall learning journey marks Day 1 of my Advanced SQL learning phase.**

I have already built a Library Management System database and practised SQL concepts through that project. Now, I am using the same project database structure to strengthen my SQL knowledge, improve my query-writing skills, and solve practical problems independently.

Rather than only studying SQL syntax, my goal is to understand the logic behind each query and learn how SQL can solve real-world data problems.

## 🎯 Learning Objectives

* Strengthen my understanding of SQL fundamentals and advanced querying.
* Practise writing queries independently.
* Understand the difference between `WHERE` and `HAVING`.
* Work with aggregate functions and subqueries.
* Use `CASE` expressions for conditional logic.
* Handle `NULL` values correctly.
* Find unmatched records using `LEFT JOIN` and `IS NULL`.
* Practise correlated subqueries and `EXISTS`.
* Improve problem-solving skills for SQL interviews and entry-level IT roles.

## 🗄️ Database Used

For this practice, I am using the database structure from my **Library Management System project**.

The database models basic library operations, including book inventory, library members, book issuance, returns, and fines.

### Database Tables

| Table          | Description                                                                        |
| -------------- | ---------------------------------------------------------------------------------- |
| `Books`        | Stores book details, authors, genres, and copy availability.                       |
| `Members`      | Stores library member information.                                                 |
| `Issued_Books` | Records which books are issued to which members, including issue and return dates. |
| `Fines`        | Stores fine amounts and payment status associated with issued books.               |

### 1. Books

| Column             | Description                       |
| ------------------ | --------------------------------- |
| `book_id`          | Primary key identifying each book |
| `title`            | Book title                        |
| `author`           | Book author                       |
| `genre`            | Book category                     |
| `total_copies`     | Total copies owned by the library |
| `available_copies` | Copies currently available        |

### 2. Members

| Column      | Description                         |
| ----------- | ----------------------------------- |
| `member_id` | Primary key identifying each member |
| `name`      | Member's name                       |
| `email`     | Member's email address              |
| `join_date` | Date the member joined              |

### 3. Issued_Books

| Column        | Description                                                                   |
| ------------- | ----------------------------------------------------------------------------- |
| `issue_id`    | Primary key identifying each issue record                                     |
| `book_id`     | Foreign key referencing `Books`                                               |
| `member_id`   | Foreign key referencing `Members`                                             |
| `issue_date`  | Date the book was issued                                                      |
| `return_date` | Date the book was returned; `NULL` means it has not been recorded as returned |

### 4. Fines

| Column     | Description                              |
| ---------- | ---------------------------------------- |
| `fine_id`  | Primary key identifying each fine        |
| `issue_id` | Foreign key referencing `Issued_Books`   |
| `amount`   | Fine amount                              |
| `paid`     | Indicates whether the fine has been paid |

## 📚 Day 13 — Questions and Concepts Practised

Day 13 focused on strengthening SQL through practical questions based on the Library Management System database.

| No. | Practice Problem                                      | SQL Concepts                     |
| --: | ----------------------------------------------------- | -------------------------------- |
|   1 | Find books with above-average available copies        | Subquery, `AVG()`                |
|   2 | Categorize books by availability                      | `CASE`                           |
|   3 | Count books in each genre                             | `GROUP BY`, `COUNT()`            |
|   4 | Find genres containing more than one book             | `HAVING`, aggregation            |
|   5 | Find issues within a date range                       | `BETWEEN`, date filtering        |
|   6 | Find books that have never been issued                | `LEFT JOIN`, `IS NULL`           |
|   7 | Find members who have never issued a book             | `LEFT JOIN`, `IS NULL`           |
|   8 | Count issue records for each book                     | `LEFT JOIN`, `COUNT()`           |
|   9 | Find members with unreturned books                    | `JOIN`, `IS NULL`                |
|  10 | Calculate total fines by payment status               | `GROUP BY`, `SUM()`              |
|  11 | Find books with below-average available copies        | Subquery, `AVG()`                |
|  12 | Find genres meeting an average-availability condition | `AVG()`, `HAVING`                |
|  13 | Identify books that have or have not been issued      | `CASE`, `EXISTS`                 |
|  14 | Find books above their genre's average availability   | Correlated subquery              |
|  15 | Find members with above-average issue counts          | Correlated subquery, aggregation |

The complete SQL file contains the table creation statements, sample records, questions, solutions, and revision comments.

## 💻 Example SQL Problem

### Problem: Find books that have never been issued

**Objective:** Identify books in the `Books` table that do not have a corresponding record in `Issued_Books`.

```sql
SELECT
    b.book_id,
    b.title
FROM Books b
LEFT JOIN Issued_Books i
    ON b.book_id = i.book_id
WHERE i.issue_id IS NULL;
```

**How it works:**

* `LEFT JOIN` retains all books, including those without a matching issue record.
* `IS NULL` filters for books with no matching issue record.
* This approach is also useful for finding customers who have never placed orders or products that have never been sold.

## 🧠 My Self-Practice Approach

I am using this learning phase to develop the ability to solve SQL problems independently.

My approach is to:

1. Understand the problem before writing the query.
2. Identify the tables and columns needed.
3. Decide which SQL concepts fit the problem.
4. Write and execute the query in MySQL.
5. Check whether the result matches the expected logic.
6. Review mistakes and understand why the solution works.

The focus is not just on completing questions, but on building the confidence to explain my SQL solutions during technical interviews.

## 🛠️ Technology and Tools

* **Database:** MySQL
* **Query Language:** SQL
* **Database Tool:** MySQL Workbench
* **Version Control:** Git and GitHub

## 📂 Repository Contents

```text
library-management-system/
│
├── library_advanced_sql_day13_questions_solutions.sql
└── README.md
```

The SQL file includes the practice database setup, sample data, and all 15 questions with their solutions.

## 🚀 Learning Roadmap

This work is part of my broader job-ready learning journey.

* **Phase 1:** Python fundamentals and Personal Expense Tracker project.
* **Phase 2:** SQL and Library Management System project.
* **Phase 3:** Advanced SQL practice and interview-oriented problem-solving.

**Current progress:** Day 13 overall | Day 1 of Advanced SQL.

I will continue practising more advanced SQL problems, improving my query logic, and preparing for entry-level IT opportunities.

## 📌 Key Takeaway

Building a project gave me a practical database to work with. Self-practice is now helping me move beyond writing basic queries toward understanding how to solve more complex data problems.

My goal is to develop strong fundamentals, write clear SQL queries, and become more confident in explaining my solutions.

---

**Learning by building. Improving through practice. Preparing for real-world problems.**

#SQL #MySQL #AdvancedSQL #SQLPractice #LibraryManagementSystem #ProblemSolving #LearningJourney
