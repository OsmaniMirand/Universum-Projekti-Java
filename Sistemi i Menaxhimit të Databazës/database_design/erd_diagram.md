# ERD (Entity-Relationship Diagram)

## Entitetet dhe Atributet

### 1. Authors
- author_id (PK)
- first_name
- last_name
- birth_date
- nationality
- created_at

### 2. Categories
- category_id (PK)
- category_name
- description
- created_at

### 3. Books
- book_id (PK)
- title
- isbn
- publication_year
- pages
- category_id (FK)
- available_copies
- total_copies
- created_at

### 4. Members
- member_id (PK)
- first_name
- last_name
- email
- phone
- address
- membership_date
- membership_type
- status

### 5. Loans
- loan_id (PK)
- book_id (FK)
- member_id (FK)
- loan_date
- due_date
- return_date
- status
- fine_amount

### 6. Book_Authors (Junction Table)
- book_id (FK)
- author_id (FK)
- role (primary_author, co_author)

## Marrëdhëniet

1. **Authors ↔ Books (N:M)**
   - Një autor mund të ketë shumë libra
   - Një libër mund të ketë shumë autorë
   - Implementohet përmes tabelës Book_Authors

2. **Categories → Books (1:N)**
   - Një kategori mund të ketë shumë libra
   - Një libër i përket një kategorie

3. **Members → Loans (1:N)**
   - Një anëtar mund të ketë shumë huazime
   - Një huazim i përket një anëtari

4. **Books → Loans (1:N)**
   - Një libër mund të huazohet shumë herë
   - Një huazim i përket një libri