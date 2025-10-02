-- Stored Procedures for Library Management System

USE library_management;

DELIMITER //


CREATE PROCEDURE LoanBook(
    IN p_book_id INT,
    IN p_member_id INT,
    IN p_loan_days INT
)
BEGIN
    DECLARE v_available_copies INT;
    DECLARE v_member_status VARCHAR(20);
    DECLARE v_due_date DATE;
   
    SELECT available_copies INTO v_available_copies 
    FROM Books WHERE book_id = p_book_id;
    

    SELECT status INTO v_member_status 
    FROM Members WHERE member_id = p_member_id;
    

    SET v_due_date = DATE_ADD(CURDATE(), INTERVAL p_loan_days DAY);
    
   
    IF v_available_copies > 0 AND v_member_status = 'active' THEN
        -- Insert loan record
        INSERT INTO Loans (book_id, member_id, loan_date, due_date, status)
        VALUES (p_book_id, p_member_id, CURDATE(), v_due_date, 'active');
        
    
        UPDATE Books 
        SET available_copies = available_copies - 1 
        WHERE book_id = p_book_id;
        
        SELECT 'Book loaned successfully' as message, LAST_INSERT_ID() as loan_id;
    ELSE
        SELECT 'Cannot loan book - either unavailable or member not active' as message, 0 as loan_id;
    END IF;
END //

CREATE PROCEDURE ReturnBook(
    IN p_loan_id INT
)
BEGIN
    DECLARE v_book_id INT;
    DECLARE v_due_date DATE;
    DECLARE v_days_overdue INT;
    DECLARE v_fine_amount DECIMAL(10,2);
    DECLARE v_loan_status VARCHAR(20);
    

    SELECT book_id, due_date, status 
    INTO v_book_id, v_due_date, v_loan_status
    FROM Loans WHERE loan_id = p_loan_id;
    
  
    IF v_loan_status IN ('active', 'overdue') THEN
      
        SET v_days_overdue = GREATEST(0, DATEDIFF(CURDATE(), v_due_date));
        
       
        SET v_fine_amount = v_days_overdue * 0.50;
        
     
        UPDATE Loans 
        SET return_date = CURDATE(), 
            status = 'returned',
            fine_amount = v_fine_amount
        WHERE loan_id = p_loan_id;
        

        UPDATE Books 
        SET available_copies = available_copies + 1 
        WHERE book_id = v_book_id;
        
        SELECT 'Book returned successfully' as message, 
               v_fine_amount as fine_amount,
               v_days_overdue as days_overdue;
    ELSE
        SELECT 'Invalid loan ID or book already returned' as message, 0 as fine_amount, 0 as days_overdue;
    END IF;
END //

-- 3. Procedure to generate monthly loan report
CREATE PROCEDURE MonthlyLoanReport(
    IN p_year INT,
    IN p_month INT
)
BEGIN
    SELECT 
        DATE_FORMAT(l.loan_date, '%Y-%m') as month_year,
        COUNT(l.loan_id) as total_loans,
        COUNT(CASE WHEN l.status = 'returned' THEN 1 END) as returned_books,
        COUNT(CASE WHEN l.status = 'active' THEN 1 END) as active_loans,
        COUNT(CASE WHEN l.status = 'overdue' THEN 1 END) as overdue_books,
        SUM(l.fine_amount) as total_fines_collected,
        COUNT(DISTINCT l.member_id) as unique_borrowers
    FROM Loans l
    WHERE YEAR(l.loan_date) = p_year 
    AND MONTH(l.loan_date) = p_month
    GROUP BY DATE_FORMAT(l.loan_date, '%Y-%m');
    
  
    SELECT 
        b.title,
        CONCAT(a.first_name, ' ', a.last_name) as author_name,
        COUNT(l.loan_id) as times_borrowed
    FROM Loans l
    JOIN Books b ON l.book_id = b.book_id
    JOIN Book_Authors ba ON b.book_id = ba.book_id
    JOIN Authors a ON ba.author_id = a.author_id
    WHERE YEAR(l.loan_date) = p_year 
    AND MONTH(l.loan_date) = p_month
    AND ba.role = 'primary_author'
    GROUP BY b.book_id, b.title, a.first_name, a.last_name
    ORDER BY times_borrowed DESC
    LIMIT 5;
END //

DELIMITER ;

-- Example calls:

-- Test LoanBook procedure
-- CALL LoanBook(1, 1, 14);

-- Test ReturnBook procedure  
-- CALL ReturnBook(1);

-- Test MonthlyLoanReport procedure
-- CALL MonthlyLoanReport(2024, 1);