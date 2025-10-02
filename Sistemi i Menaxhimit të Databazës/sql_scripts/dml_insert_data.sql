-- DML (Data Manipulation Language) Scripts
-- Insert Sample Data for Library Management System

USE library_management;


INSERT INTO Authors (first_name, last_name, birth_date, nationality) VALUES
('George', 'Orwell', '1903-06-25', 'British'),
('J.K.', 'Rowling', '1965-07-31', 'British'),
('Stephen', 'King', '1947-09-21', 'American'),
('Agatha', 'Christie', '1890-09-15', 'British'),
('Ernest', 'Hemingway', '1899-07-21', 'American'),
('Jane', 'Austen', '1775-12-16', 'British'),
('Mark', 'Twain', '1835-11-30', 'American'),
('Virginia', 'Woolf', '1882-01-25', 'British');


INSERT INTO Categories (category_name, description) VALUES
('Fiction', 'Fictional literature and novels'),
('Science Fiction', 'Science fiction and fantasy books'),
('Mystery', 'Mystery and detective novels'),
('Romance', 'Romantic literature'),
('Horror', 'Horror and thriller books'),
('Classic Literature', 'Classic and timeless literature'),
('Biography', 'Biographical and autobiographical works'),
('History', 'Historical books and documentaries');


INSERT INTO Books (title, isbn, publication_year, pages, category_id, available_copies, total_copies, language) VALUES
('1984', '9780451524935', 1949, 328, 1, 3, 5, 'English'),
('Animal Farm', '9780451526342', 1945, 112, 1, 2, 3, 'English'),
('Harry Potter and the Philosopher''s Stone', '9780747532699', 1997, 223, 2, 4, 6, 'English'),
('The Shining', '9780307743657', 1977, 447, 5, 2, 4, 'English'),
('Murder on the Orient Express', '9780062693662', 1934, 256, 3, 3, 5, 'English'),
('Pride and Prejudice', '9780141439518', 1813, 432, 4, 5, 7, 'English'),
('The Old Man and the Sea', '9780684801223', 1952, 127, 1, 2, 3, 'English'),
('Adventures of Huckleberry Finn', '9780486280615', 1884, 224, 6, 3, 4, 'English'),
('To the Lighthouse', '9780156907392', 1927, 209, 6, 1, 2, 'English'),
('It', '9781501142970', 1986, 1138, 5, 1, 3, 'English');


INSERT INTO Members (first_name, last_name, email, phone, address, membership_date, membership_type, status) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '123 Main St, City', '2023-01-15', 'public', 'active'),
('Emily', 'Johnson', 'emily.johnson@email.com', '555-0102', '456 Oak Ave, City', '2023-02-20', 'student', 'active'),
('Michael', 'Brown', 'michael.brown@email.com', '555-0103', '789 Pine Rd, City', '2023-03-10', 'faculty', 'active'),
('Sarah', 'Davis', 'sarah.davis@email.com', '555-0104', '321 Elm St, City', '2023-01-25', 'public', 'active'),
('David', 'Wilson', 'david.wilson@email.com', '555-0105', '654 Maple Dr, City', '2023-04-05', 'student', 'active'),
('Lisa', 'Anderson', 'lisa.anderson@email.com', '555-0106', '987 Cedar Ln, City', '2022-12-01', 'public', 'suspended'),
('Robert', 'Taylor', 'robert.taylor@email.com', '555-0107', '147 Birch Way, City', '2023-05-12', 'faculty', 'active'),
('Jennifer', 'Martinez', 'jennifer.martinez@email.com', '555-0108', '258 Spruce St, City', '2023-06-18', 'student', 'active');


INSERT INTO Book_Authors (book_id, author_id, role) VALUES
(1, 1, 'primary_author'),
(2, 1, 'primary_author'),
(3, 2, 'primary_author'),
(4, 3, 'primary_author'),
(5, 4, 'primary_author'),
(6, 6, 'primary_author'),
(7, 5, 'primary_author'),
(8, 7, 'primary_author'),
(9, 8, 'primary_author'),
(10, 3, 'primary_author');


INSERT INTO Loans (book_id, member_id, loan_date, due_date, return_date, status, fine_amount) VALUES
(1, 1, '2024-01-10', '2024-01-24', '2024-01-22', 'returned', 0.00),
(3, 2, '2024-01-15', '2024-01-29', NULL, 'active', 0.00),
(5, 3, '2024-01-20', '2024-02-03', NULL, 'active', 0.00),
(2, 4, '2024-01-05', '2024-01-19', '2024-01-25', 'returned', 3.00),
(6, 5, '2024-01-25', '2024-02-08', NULL, 'active', 0.00),
(4, 1, '2024-01-30', '2024-02-13', NULL, 'active', 0.00),
(7, 7, '2024-01-12', '2024-01-26', '2024-01-24', 'returned', 0.00),
(8, 8, '2024-01-18', '2024-02-01', NULL, 'overdue', 5.50),
(9, 2, '2024-01-22', '2024-02-05', NULL, 'active', 0.00),
(10, 3, '2024-01-28', '2024-02-11', NULL, 'active', 0.00);

-- UPDATE Examples
-- Update available copies after a return
UPDATE Books SET available_copies = available_copies + 1 WHERE book_id = 1;


UPDATE Members SET status = 'expired' WHERE membership_date < '2022-01-01';


UPDATE Loans SET status = 'overdue' WHERE due_date < CURDATE() AND status = 'active';

DELETE FROM Loans WHERE loan_id = 1 AND status = 'returned';

