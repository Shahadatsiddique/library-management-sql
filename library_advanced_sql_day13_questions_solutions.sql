/*
PROJECT: Library Management System - Advanced SQL Practice
PHASE 3 | DAY 13 | MySQL

Contains database setup, sample data, and SQL questions with solutions.
WARNING: This script drops and recreates the four tables. Run only in a practice database.
NOTE: The sample dataset is self-contained; adjust sample rows if your local database differs.
*/

CREATE DATABASE IF NOT EXISTS library;
USE library;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Fines;
DROP TABLE IF EXISTS Issued_Books;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Books;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. CREATE TABLES
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    genre VARCHAR(60),
    total_copies INT NOT NULL,
    available_copies INT NOT NULL
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    join_date DATE
);

CREATE TABLE Issued_Books (
    issue_id INT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

CREATE TABLE Fines (
    fine_id INT PRIMARY KEY,
    issue_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    paid BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (issue_id) REFERENCES Issued_Books(issue_id)
);

-- 2. SAMPLE DATA
INSERT INTO Books (book_id, title, author, genre, total_copies, available_copies) VALUES
(1, 'The Alchemist', 'Paulo Coelho', 'Fiction', 5, 2),
(2, 'Database Management Systems', 'Raghu Ramakrishnan', 'Technology', 4, 2),
(3, 'Atomic Habits', 'James Clear', 'Self-Help', 4, 4),
(4, 'Wings of Fire', 'A. P. J. Abdul Kalam', 'Biography', 3, 1),
(5, 'Python Crash Course', 'Eric Matthes', 'Technology', 4, 2),
(6, 'Clean Code', 'Robert C. Martin', 'Technology', 3, 0);

INSERT INTO Members (member_id, name, email, join_date) VALUES
(101, 'Rahul Sharma', 'rahul@example.com', '2024-01-10'),
(102, 'Priya Singh', 'priya@example.com', '2024-02-15'),
(103, 'Amit Kumar', 'amit@example.com', '2024-03-20'),
(104, 'Sneha Roy', 'sneha@example.com', '2024-04-05'),
(105, 'Neha Verma', 'neha@example.com', '2024-06-12');

INSERT INTO Issued_Books (issue_id, book_id, member_id, issue_date, return_date) VALUES
(1001, 1, 101, '2024-05-01', NULL),
(1002, 2, 102, '2024-05-03', NULL),
(1003, 4, 103, '2024-05-05', '2024-05-15'),
(1004, 1, 104, '2024-05-10', NULL),
(1005, 5, 101, '2024-05-12', NULL);

INSERT INTO Fines (fine_id, issue_id, amount, paid) VALUES
(1, 1003, 25.00, TRUE),
(2, 1002, 40.00, FALSE),
(3, 1005, 15.00, FALSE);

-- 3. QUESTIONS WITH SOLUTIONS

-- Q1. Find books with available copies above the overall average. (Subquery + AVG)
SELECT book_id, title, available_copies
FROM Books
WHERE available_copies > (SELECT AVG(available_copies) FROM Books);

-- Q2. Classify each book by stock availability. (CASE)
SELECT book_id, title, available_copies,
       CASE
           WHEN available_copies = 0 THEN 'Out of Stock'
           WHEN available_copies <= 2 THEN 'Low Stock'
           ELSE 'Available'
       END AS availability_status
FROM Books
ORDER BY book_id;

-- Q3. Count books in each genre. (GROUP BY + COUNT)
SELECT genre, COUNT(*) AS number_of_books
FROM Books
GROUP BY genre
ORDER BY number_of_books DESC;

-- Q4. Show genres containing more than one book. (HAVING)
SELECT genre, COUNT(*) AS number_of_books
FROM Books
GROUP BY genre
HAVING COUNT(*) > 1;

-- Q5. Find issue records from May 1 through May 10, 2024. (Date range)
SELECT issue_id, book_id, member_id, issue_date, return_date
FROM Issued_Books
WHERE issue_date BETWEEN '2024-05-01' AND '2024-05-10'
ORDER BY issue_date;

-- Q6. Find books that have never been issued. (LEFT JOIN + IS NULL)
SELECT b.book_id, b.title
FROM Books b
LEFT JOIN Issued_Books i ON b.book_id = i.book_id
WHERE i.issue_id IS NULL
ORDER BY b.book_id;

-- Q7. Find members who have never issued a book. (LEFT JOIN + IS NULL)
SELECT m.member_id, m.name
FROM Members m
LEFT JOIN Issued_Books i ON m.member_id = i.member_id
WHERE i.issue_id IS NULL
ORDER BY m.member_id;

-- Q8. Count how many times each book was issued, including books never issued.
SELECT b.book_id, b.title, COUNT(i.issue_id) AS times_issued
FROM Books b
LEFT JOIN Issued_Books i ON b.book_id = i.book_id
GROUP BY b.book_id, b.title
ORDER BY times_issued DESC, b.book_id;

-- Q9. Find members with at least one currently unreturned book. (JOIN + IS NULL)
SELECT DISTINCT m.member_id, m.name
FROM Members m
JOIN Issued_Books i ON m.member_id = i.member_id
WHERE i.return_date IS NULL
ORDER BY m.member_id;

-- Q10. Calculate total fines grouped by whether they have been paid. (GROUP BY + SUM)
SELECT paid, SUM(amount) AS total_fine_amount
FROM Fines
GROUP BY paid;

-- Q11. Find books with available copies below the overall average. (Subquery + AVG)
SELECT book_id, title, available_copies
FROM Books
WHERE available_copies < (SELECT AVG(available_copies) FROM Books)
ORDER BY available_copies;

-- Q12. Show genres whose average available copies are at least 2. (AVG + HAVING)
SELECT genre, AVG(available_copies) AS average_available_copies
FROM Books
GROUP BY genre
HAVING AVG(available_copies) >= 2
ORDER BY average_available_copies DESC;

-- Q13. Label each book as previously issued or never issued. (CASE + EXISTS)
SELECT b.book_id, b.title,
       CASE
           WHEN EXISTS (SELECT 1 FROM Issued_Books i WHERE i.book_id = b.book_id)
               THEN 'Previously Issued'
           ELSE 'Never Issued'
       END AS issue_status
FROM Books b
ORDER BY b.book_id;

-- Q14. Find books whose available copies exceed the average for their own genre.
-- Concept: correlated subquery.
SELECT b.book_id, b.title, b.genre, b.available_copies
FROM Books b
WHERE b.available_copies > (
    SELECT AVG(b2.available_copies)
    FROM Books b2
    WHERE b2.genre = b.genre
)
ORDER BY b.genre, b.available_copies DESC;

-- Q15. Find members whose issue count is above the average issue count
-- among members who have at least one issue record. (Correlated subquery)
SELECT m.member_id, m.name
FROM Members m
WHERE (
    SELECT COUNT(*)
    FROM Issued_Books i
    WHERE i.member_id = m.member_id
) > (
    SELECT AVG(member_issue_counts.issue_count)
    FROM (
        SELECT COUNT(*) AS issue_count
        FROM Issued_Books
        GROUP BY member_id
    ) AS member_issue_counts
);

-- 4. QUICK REVISION
-- WHERE: filters rows before grouping.
-- HAVING: filters grouped/aggregated results.
-- CASE: returns a value based on conditions.
-- IS NULL: checks NULL values; do not write = NULL.
-- LEFT JOIN: preserves all rows from the left table.
-- COUNT(i.issue_id): counts only matched issue records after a LEFT JOIN.
-- AVG(): calculates an average.
-- Subquery: a query inside another query.
-- Correlated subquery: refers to a value from the outer query.
-- EXISTS: checks whether a subquery returns at least one row.
-- BETWEEN: includes both endpoints for date/value comparisons.
