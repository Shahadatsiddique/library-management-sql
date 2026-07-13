-- create database library;
-- use library;
-- CREATE TABLE Books (
--     book_id INT PRIMARY KEY,
--     title VARCHAR(100),
--     author VARCHAR(50),
--     genre VARCHAR(30),
--     total_copies INT,
--     available_copies INT
-- );
-- Books table data
-- INSERT INTO Books VALUES (1, 'The Alchemist', 'Paulo Coelho', 'Fiction', 5, 2);
-- INSERT INTO Books VALUES (2, 'Clean Code', 'Robert Martin', 'Technology', 3, 0);
-- INSERT INTO Books VALUES (3, 'Atomic Habits', 'James Clear', 'Self-Help', 4, 4);
-- INSERT INTO Books VALUES (4, 'Wings of Fire', 'A.P.J. Abdul Kalam', 'Biography', 3, 1);
-- INSERT INTO Books VALUES (5, 'Python Crash Course', 'Eric Matthes', 'Technology', 4, 2);

-- CREATE TABLE Members (
--     member_id INT PRIMARY KEY,
--     name VARCHAR(50),
--     email VARCHAR(50),
--     join_date DATE
-- );
-- Members table data
-- INSERT INTO Members VALUES (101, 'Rahul Sharma', 'rahul@email.com', '2024-01-15');
-- INSERT INTO Members VALUES (102, 'Priya Singh', 'priya@email.com', '2024-02-10');
-- INSERT INTO Members VALUES (103, 'Amit Kumar', 'amit@email.com', '2024-03-05');
-- INSERT INTO Members VALUES (104, 'Sneha Roy', 'sneha@email.com', '2024-03-20');

-- CREATE TABLE Issued_Books (
--     issue_id INT PRIMARY KEY,
--     book_id INT,
--     member_id INT,
--     issue_date DATE,
--     return_date DATE,
--     FOREIGN KEY (book_id) REFERENCES Books(book_id),
--     FOREIGN KEY (member_id) REFERENCES Members(member_id)
-- );
-- Issued_Books table data
-- INSERT INTO Issued_Books VALUES (1001, 1, 101, '2024-05-01', NULL);
-- INSERT INTO Issued_Books VALUES (1002, 2, 102, '2024-05-03', NULL);
-- INSERT INTO Issued_Books VALUES (1003, 4, 103, '2024-05-05', '2024-05-15');
-- INSERT INTO Issued_Books VALUES (1004, 1, 104, '2024-05-10', NULL);
-- INSERT INTO Issued_Books VALUES (1005, 5, 101, '2024-05-12', NULL);

-- CREATE TABLE Fines (
--     fine_id INT PRIMARY KEY,
--     issue_id INT,
--     amount DECIMAL(10,2),
--     paid BOOLEAN,
--     FOREIGN KEY (issue_id) REFERENCES Issued_Books(issue_id)
-- );
-- Fines table data
-- INSERT INTO Fines VALUES (1, 1003, 50.00, TRUE);
-- INSERT INTO Fines VALUES (2, 1001, 20.00, FALSE);



SELECT m.name, COUNT(i.issue_id) as total_books
FROM Members m
JOIN Issued_Books i ON m.member_id = i.member_id
GROUP BY m.name;

SELECT title FROM Books WHERE available_copies = 2;

SELECT genre, title, total_copies,
RANK() OVER(PARTITION BY genre ORDER BY total_copies DESC) as rnk
FROM Books;