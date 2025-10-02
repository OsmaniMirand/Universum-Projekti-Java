# Data Dictionary

## Përshkrimi i Tabelave dhe Kolonave

### 1. Authors - Tabela e Autorëve
| Kolona | Lloji i të Dhënës | Qëllimi | Vërejtje |
|--------|------------------|---------|----------|
| author_id | INT AUTO_INCREMENT | Identifikuesi unik i autorit | Primary Key |
| first_name | VARCHAR(50) NOT NULL | Emri i autorit | Detyrueshëm |
| last_name | VARCHAR(50) NOT NULL | Mbiemri i autorit | Detyrueshëm |
| birth_date | DATE | Data e lindjes | Opsionale |
| nationality | VARCHAR(50) | Kombësia e autorit | Opsionale |
| created_at | TIMESTAMP | Data e krijimit të regjistrimit | Auto-generated |

### 2. Categories - Tabela e Kategorive
| Kolona | Lloji i të Dhënës | Qëllimi | Vërejtje |
|--------|------------------|---------|----------|
| category_id | INT AUTO_INCREMENT | Identifikuesi unik i kategorisë | Primary Key |
| category_name | VARCHAR(100) NOT NULL UNIQUE | Emri i kategorisë | Detyrueshëm, unik |
| description | TEXT | Përshkrimi i kategorisë | Opsionale |
| created_at | TIMESTAMP | Data e krijimit | Auto-generated |

### 3. Books - Tabela e Librave
| Kolona | Lloji i të Dhënës | Qëllimi | Vërejtje |
|--------|------------------|---------|----------|
| book_id | INT AUTO_INCREMENT | Identifikuesi unik i librit | Primary Key |
| title | VARCHAR(200) NOT NULL | Titulli i librit | Detyrueshëm |
| isbn | VARCHAR(13) UNIQUE | Kodi ISBN i librit | Unik, opsional |
| publication_year | YEAR | Viti i publikimit | Opsionale |
| pages | INT | Numri i faqeve | Opsionale |
| category_id | INT NOT NULL | Lidhja me kategorinë | Foreign Key |
| available_copies | INT DEFAULT 0 | Kopjet e disponueshme | Default 0 |
| total_copies | INT DEFAULT 0 | Kopjet totale | Default 0 |
| created_at | TIMESTAMP | Data e regjistrimit | Auto-generated |

### 4. Members - Tabela e Anëtarëve
| Kolona | Lloji i të Dhënës | Qëllimi | Vërejtje |
|--------|------------------|---------|----------|
| member_id | INT AUTO_INCREMENT | Identifikuesi unik i anëtarit | Primary Key |
| first_name | VARCHAR(50) NOT NULL | Emri i anëtarit | Detyrueshëm |
| last_name | VARCHAR(50) NOT NULL | Mbiemri i anëtarit | Detyrueshëm |
| email | VARCHAR(100) UNIQUE NOT NULL | Email-i i anëtarit | Unik, detyrueshëm |
| phone | VARCHAR(15) | Numri i telefonit | Opsionale |
| address | TEXT | Adresa e anëtarit | Opsionale |
| membership_date | DATE NOT NULL | Data e anëtarësimit | Detyrueshëm |
| membership_type | ENUM | Lloji i anëtarësimit | student/faculty/public |
| status | ENUM | Statusi i anëtarit | active/suspended/expired |

### 5. Loans - Tabela e Huazimeve
| Kolona | Lloji i të Dhënës | Qëllimi | Vërejtje |
|--------|------------------|---------|----------|
| loan_id | INT AUTO_INCREMENT | Identifikuesi unik i huazimit | Primary Key |
| book_id | INT NOT NULL | Lidhja me librin | Foreign Key |
| member_id | INT NOT NULL | Lidhja me anëtarin | Foreign Key |
| loan_date | DATE NOT NULL | Data e huazimit | Detyrueshëm |
| due_date | DATE NOT NULL | Data e kthimit | Detyrueshëm |
| return_date | DATE | Data aktuale e kthimit | Null nëse nuk është kthyer |
| status | ENUM | Statusi i huazimit | active/returned/overdue |
| fine_amount | DECIMAL(10,2) | Gjoba për vonesë | Default 0.00 |

### 6. Book_Authors - Tabela Lidhëse
| Kolona | Lloji i të Dhënës | Qëllimi | Vërejtje |
|--------|------------------|---------|----------|
| book_id | INT | Lidhja me librin | Part of Composite PK |
| author_id | INT | Lidhja me autorin | Part of Composite PK |
| role | ENUM | Roli i autorit | primary_author/co_author |

## Integriteti i të Dhënave

### Constraints të Aplikuara
1. **NOT NULL**: Fushat e detyrueshme
2. **UNIQUE**: Email i anëtarëve, ISBN i librave, emri i kategorive
3. **FOREIGN KEY**: Ruajtja e integritetit referencial
4. **CHECK**: Vlerat e ENUM për status dhe lloje
5. **DEFAULT**: Vlera të paracaktuara për fusha specifike