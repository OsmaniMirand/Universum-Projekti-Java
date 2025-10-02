-- Advanced Queries for Library Management System
-- Minimum 10 queries with various SQL features

USE library_management;


SELECT l.loan_id, b.title, CONCAT(m.first_name, ' ', m.last_name) as member_name, 
       l.loan_date, l.due_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.status = 'active';

SELECT b.title, CONCAT(a.first_name, ' ', a.last_name) as author_name, 
       c.category_name, b.publication_year
FROM Books b
INNER JOIN Book_Authors ba ON b.book_id = ba.book_id
INNER JOIN Authors a ON ba.author_id = a.author_id
INNER JOIN Categories c ON b.category_id = c.category_id
ORDER BY b.title;


SELECT CONCAT(m.first_name, ' ', m.last_name) as member_name, 
       m.email, b.title, l.loan_date, l.status
FROM Members m
LEFT JOIN Loans l ON m.member_id = l.member_id AND l.status = 'active'
LEFT JOIN Books b ON l.book_id = b.book_id
ORDER BY m.last_name;


SELECT c.category_name, COUNT(b.book_id) as total_books, 
       SUM(b.total_copies) as total_copies
FROM Categories c
LEFT JOIN Books b ON c.category_id = b.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_books DESC;


SELECT m.membership_type, 
       COUNT(l.loan_id) as total_loans,
       AVG(l.fine_amount) as avg_fine,
       SUM(l.fine_amount) as total_fines
FROM Members m
JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.membership_type
HAVING COUNT(l.loan_id) > 0;

SELECT b.title, c.category_name, b.publication_year, b.available_copies
FROM Books b
JOIN Categories c ON b.category_id = c.category_id
ORDER BY c.category_name ASC, b.title ASC;


SELECT b.book_id, b.title, b.available_copies
FROM Books b
WHERE b.book_id NOT IN (
    SELECT DISTINCT book_id 
    FROM Loans 
    WHERE book_id IS NOT NULL
);


SELECT DISTINCT m.member_id, CONCAT(m.first_name, ' ', m.last_name) as member_name, 
       m.email, m.phone
FROM Members m
WHERE EXISTS (
    SELECT 1 
    FROM Loans l 
    WHERE l.member_id = m.member_id 
    AND l.status = 'overdue'
);


SELECT b.title, b.publication_year, CONCAT(a.first_name, ' ', a.last_name) as author
FROM Books b
JOIN Book_Authors ba ON b.book_id = ba.book_id
JOIN Authors a ON ba.author_id = a.author_id
WHERE b.publication_year BETWEEN 1900 AND 2000
AND (b.title LIKE '%the%' OR a.last_name LIKE 'S%')
ORDER BY b.publication_year DESC;


SELECT a.first_name, a.last_name, a.nationality,
       COUNT(DISTINCT b.book_id) as books_written,
       COUNT(DISTINCT l.loan_id) as times_loaned,
       AVG(b.pages) as avg_pages
FROM Authors a
JOIN Book_Authors ba ON a.author_id = ba.author_id
JOIN Books b ON ba.book_id = b.book_id
LEFT JOIN Loans l ON b.book_id = l.book_id
GROUP BY a.author_id, a.first_name, a.last_name, a.nationality
HAVING COUNT(DISTINCT b.book_id) >= 1
ORDER BY times_loaned DESC, books_written DESC;


SELECT b.title, c.category_name, 
       COUNT(l.loan_id) as loan_count,
       RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(l.loan_id) DESC) as popularity_rank
FROM Books b
JOIN Categories c ON b.category_id = c.category_id
LEFT JOIN Loans l ON b.book_id = l.book_id
GROUP BY b.book_id, b.title, c.category_id, c.category_name
ORDER BY c.category_name, popularity_rank;

SELECT l.loan_id, b.title, CONCAT(m.first_name, ' ', m.last_name) as member_name,
       l.loan_date, l.due_date,
       DATEDIFF(CURDATE(), l.due_date) as days_overdue,
       CASE 
           WHEN l.return_date IS NOT NULL THEN 'Returned'
           WHEN CURDATE() > l.due_date THEN 'Overdue'
           ELSE 'Active'
       END as current_status,
       CASE 
           WHEN DATEDIFF(CURDATE(), l.due_date) > 0 AND l.return_date IS NULL 
           THEN DATEDIFF(CURDATE(), l.due_date) * 0.50
           ELSE 0
       END as calculated_fine
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.status IN ('active', 'overdue')
ORDER BY days_overdue DESC;