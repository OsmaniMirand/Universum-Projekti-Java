# Test Cases and Validation

## 1. Funksionalitetet Kryesore - Test Cases

### Test Case 1: Krijimi i Tabelave
**Objektivi**: Verifikimi i krijimit të të gjitha tabelave me constraints të duhura

**Hapat**:
1. Ekzekutimi i DDL script
2. Verifikimi i strukturës së tabelave
3. Testimi i constraints

**Rezultati i Pritshëm**: Të gjitha tabelat krijohen me sukses

```sql
-- Verifikimi i tabelave
SHOW TABLES;
DESCRIBE Authors;
DESCRIBE Books;
DESCRIBE Members;
DESCRIBE Loans;
DESCRIBE Categories;
DESCRIBE Book_Authors;
```

### Test Case 2: Futja e të Dhënave
**Objektivi**: Testimi i INSERT operations në të gjitha tabelat

**Hapat**:
1. Ekzekutimi i DML script
2. Verifikimi i të dhënave të futura
3. Testimi i Foreign Key constraints

**Rezultati i Pritshëm**: Të dhënat futen me sukses

```sql
-- Verifikimi i të dhënave
SELECT COUNT(*) FROM Authors;
SELECT COUNT(*) FROM Books;
SELECT COUNT(*) FROM Members;
SELECT COUNT(*) FROM Loans;
```

### Test Case 3: Integriteti i të Dhënave
**Objektivi**: Testimi i constraints dhe integritetit referencial

**Test 3.1 - UNIQUE Constraint**:
```sql
-- Duhet të dështojë - email duplicate
INSERT INTO Members (first_name, last_name, email, membership_date) 
VALUES ('Test', 'User', 'john.smith@email.com', CURDATE());
```

**Test 3.2 - Foreign Key Constraint**:
```sql
-- Duhet të dështojë - category_id që nuk ekziston
INSERT INTO Books (title, category_id, total_copies) 
VALUES ('Test Book', 999, 1);
```

**Test 3.3 - NOT NULL Constraint**:
```sql
-- Duhet të dështojë - first_name NULL
INSERT INTO Members (last_name, email, membership_date) 
VALUES ('Test', 'test@email.com', CURDATE());
```

### Test Case 4: Query Performance
**Objektivi**: Testimi i performancës së query-ve komplekse

**Hapat**:
1. Ekzekutimi i të gjitha query-ve nga queries.sql
2. Matja e kohës së ekzekutimit
3. Verifikimi i rezultateve

### Test Case 5: Stored Procedures
**Objektivi**: Testimi i funksionalitetit të procedurave

**Test 5.1 - LoanBook Procedure**:
```sql
-- Test i suksesshëm
CALL LoanBook(1, 1, 14);

-- Test me libër të pa-disponueshëm
UPDATE Books SET available_copies = 0 WHERE book_id = 1;
CALL LoanBook(1, 2, 14);
```

**Test 5.2 - ReturnBook Procedure**:
```sql
-- Test kthimi me vonesë
CALL ReturnBook(1);
```

## 2. Rezultatet e Testeve

### Tabela e Rezultateve - Krijimi i Tabelave
| Tabela | Status | Constraints | Indexes |
|--------|--------|-------------|---------|
| Authors | ✅ Success | ✅ PK, NOT NULL | ✅ Created |
| Categories | ✅ Success | ✅ PK, UNIQUE | ✅ Created |
| Books | ✅ Success | ✅ PK, FK, UNIQUE | ✅ Created |
| Members | ✅ Success | ✅ PK, UNIQUE, ENUM | ✅ Created |
| Loans | ✅ Success | ✅ PK, FK, ENUM | ✅ Created |
| Book_Authors | ✅ Success | ✅ Composite PK, FK | ✅ Created |

### Tabela e Rezultateve - Futja e të Dhënave
| Tabela | Records Inserted | Status |
|--------|------------------|--------|
| Authors | 8 | ✅ Success |
| Categories | 8 | ✅ Success |
| Books | 10 | ✅ Success |
| Members | 8 | ✅ Success |
| Loans | 10 | ✅ Success |
| Book_Authors | 10 | ✅ Success |

### Tabela e Rezultateve - Query Performance
| Query # | Description | Execution Time | Records Returned |
|---------|-------------|----------------|------------------|
| 1 | Active Loans | < 1ms | 6 |
| 2 | Books with Authors | < 1ms | 10 |
| 3 | Members and Loans | < 1ms | 8 |
| 4 | Books per Category | < 1ms | 8 |
| 5 | Loan Statistics | < 1ms | 3 |
| 6 | Sorted Books | < 1ms | 10 |
| 7 | Never Loaned Books | < 1ms | 2 |
| 8 | Overdue Members | < 1ms | 1 |
| 9 | Advanced Filtering | < 1ms | 5 |
| 10 | Complex Aggregation | < 1ms | 8 |

## 3. Demonstrimi i Integritetit

### Constraint Violations (Expected Failures)
```sql
-- 1. Duplicate Email
ERROR 1062: Duplicate entry 'john.smith@email.com' for key 'email'

-- 2. Invalid Foreign Key
ERROR 1452: Cannot add or update a child row: a foreign key constraint fails

-- 3. NULL in NOT NULL field
ERROR 1048: Column 'first_name' cannot be null

-- 4. Invalid ENUM value
ERROR 1265: Data truncated for column 'status' at row 1
```

### Successful Operations
```sql
-- Valid INSERT
Query OK, 1 row affected

-- Valid UPDATE
Query OK, 1 row affected

-- Valid DELETE with CASCADE
Query OK, 2 rows affected
```