# Relational Schema

## Skema Relacionale e Tabelave

### 1. Authors
```sql
Authors(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
```

### 2. Categories
```sql
Categories(
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
```

### 3. Books
```sql
Books(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(13) UNIQUE,
    publication_year YEAR,
    pages INT,
    category_id INT NOT NULL,
    available_copies INT DEFAULT 0,
    total_copies INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
)
```

### 4. Members
```sql
Members(
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    membership_date DATE NOT NULL,
    membership_type ENUM('student', 'faculty', 'public') DEFAULT 'public',
    status ENUM('active', 'suspended', 'expired') DEFAULT 'active'
)
```

### 5. Loans
```sql
Loans(
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('active', 'returned', 'overdue') DEFAULT 'active',
    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
)
```

### 6. Book_Authors
```sql
Book_Authors(
    book_id INT,
    author_id INT,
    role ENUM('primary_author', 'co_author') DEFAULT 'primary_author',
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
)
```

## Çelësat dhe Constraints

### Primary Keys
- Authors: author_id
- Categories: category_id
- Books: book_id
- Members: member_id
- Loans: loan_id
- Book_Authors: (book_id, author_id) - Composite Key

### Foreign Keys
- Books.category_id → Categories.category_id
- Loans.book_id → Books.book_id
- Loans.member_id → Members.member_id
- Book_Authors.book_id → Books.book_id
- Book_Authors.author_id → Authors.author_id

### Unique Constraints
- Categories.category_name
- Books.isbn
- Members.email