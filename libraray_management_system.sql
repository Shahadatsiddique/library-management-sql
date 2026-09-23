-- ============================================
-- LIBRARY MANAGEMENT SYSTEM
-- ============================================

-- 1. Create Database
-- CREATE DATABASE library;
USE library;


-- ============================================
-- 2. BOOKS TABLE
-- ============================================

-- CREATE TABLE Books (
    -- book_id INT PRIMARY KEY,
    -- title VARCHAR(100),
--     author VARCHAR(50),
--     genre VARCHAR(30),
--     total_copies INT,
--     available_copies INT
-- );

-- Insert Books
-- INSERT INTO Books
-- (book_id, title, author, genre, total_copies, available_copies)
-- VALUES
-- (1, 'The Alchemist', 'Paulo Coelho', 'Fiction', 5, 2),
-- (2, 'Clean Code', 'Robert Martin', 'Technology', 3, 0),
-- (3, 'Atomic Habits', 'James Clear', 'Self-Help', 4, 4),
-- (4, 'Wings of Fire', 'A.P.J. Abdul Kalam', 'Biography', 3, 1),
-- (5, 'Python Crash Course', 'Eric Matthes', 'Technology', 4, 2);


-- ============================================
-- 3. MEMBERS TABLE
-- ============================================

-- CREATE TABLE Members (
--     member_id INT PRIMARY KEY,
--     name VARCHAR(50),
--     email VARCHAR(50),
--     join_date DATE
-- );

-- Insert Members
-- INSERT INTO Members
-- (member_id, name, email, join_date)
-- VALUES
-- (101, 'Rahul Sharma', 'rahul@email.com', '2024-01-15'),
-- (102, 'Priya Singh', 'priya@email.com', '2024-02-10'),
-- (103, 'Amit Kumar', 'amit@email.com', '2024-03-05'),
-- (104, 'Sneha Roy', 'sneha@email.com', '2024-03-20');


-- ============================================
-- 4. ISSUED BOOKS TABLE
-- ============================================

-- CREATE TABLE Issued_Books (
--     issue_id INT PRIMARY KEY,
--     book_id INT,
--     member_id INT,
--     issue_date DATE,
--     return_date DATE,

--     FOREIGN KEY (book_id)
--         REFERENCES Books(book_id),

--     FOREIGN KEY (member_id)
--         REFERENCES Members(member_id)
-- );

-- Insert Issued Books
-- INSERT INTO Issued_Books
-- (issue_id, book_id, member_id, issue_date, return_date)
-- VALUES
-- (1001, 1, 101, '2024-05-01', NULL),
-- (1002, 2, 102, '2024-05-03', NULL),
-- (1003, 4, 103, '2024-05-05', '2024-05-15'),
-- (1004, 1, 104, '2024-05-10', NULL),
-- (1005, 5, 101, '2024-05-12', NULL);


-- ============================================
-- 5. FINES TABLE
-- ============================================

-- CREATE TABLE Fines (
--     fine_id INT PRIMARY KEY,
--     issue_id INT,
--     amount DECIMAL(10,2),
--     paid BOOLEAN,

--     FOREIGN KEY (issue_id)
--         REFERENCES Issued_Books(issue_id)
-- );

-- Insert Fines
-- INSERT INTO Fines
-- (fine_id, issue_id, amount, paid)
-- VALUES
-- (1, 1003, 50.00, TRUE),
-- (2, 1001, 20.00, FALSE);


-- ============================================
-- 6. SQL QUERIES
-- ============================================

-- Query 1:
-- Find the total number of books issued by each member

SELECT
    m.name,
    COUNT(i.issue_id) AS total_books
FROM Members m
JOIN Issued_Books i
    ON m.member_id = i.member_id
GROUP BY m.name;


-- Query 2:
-- Find books having exactly 2 available copies

SELECT
    author,title
FROM Books
WHERE available_copies = 2;


-- Query 3:
-- Rank books within each genre based on total copies using functions

SELECT
    genre,
    title,
    total_copies,
    Row_number() OVER (
    ORDER BY total_copies DESC
	) As Row_No,
    RANK() OVER (
        ORDER BY total_copies DESC
    ) AS rnk,
    Dense_Rank() over(
        order by total_copies desc
    )as d_rnk
FROM Books;

-- Query 4:
-- Divide the books into groups by genre, then rank the books inside each group

SELECT
    genre,
    title,
    total_copies,
    RANK() OVER (
        PARTITION BY genre
        ORDER BY total_copies DESC
    ) AS genre_rank
FROM Books;

-- Query 5:
--  Which books are the most available within each genre?

SELECT
    genre,
    title,
    available_copies,
    RANK() OVER (
        ORDER BY available_copies DESC
    ) AS availability_rank
FROM Books;

-- Query 6:
-- finding total_copies of each genre using cte
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
    total_copies
FROM RankedBooks
