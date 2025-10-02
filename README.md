# Test Management System - Versioni i Personalizuar

## Përshkrimi
Ky është një sistem i menaxhimit të testeve i ndërtuar me Spring Boot dhe Java. Sistemi lejon krijimin, menaxhimin dhe administrimin e testeve online.

## Funksionalitetet e Reja të Shtuara

### 1. Model i Zgjeruar për Testet
- **Titulli**: Emri i testit
- **Përshkrimi**: Përshkrim i detajuar i testit
- **Lënda**: Lënda mbi të cilën bazohet testi
- **Kohëzgjatja**: Koha në minuta për përfundimin e testit
- **Numri i Pyetjeve**: Sa pyetje ka testi
- **Nota Kalimtare**: Nota minimale për të kaluar testin
- **Niveli i Vështirësisë**: EASY, MEDIUM, HARD
- **Statusi**: DRAFT, ACTIVE, INACTIVE, ARCHIVED

### 2. Modeli i Pyetjeve (Question)
- Teksti i pyetjes
- Lloji i pyetjes: Multiple Choice, True/False, Short Answer, Essay
- Pikët që jep pyetja
- Lidhja me testin përkatës

### 3. Modeli i Përgjigjeve (Answer)
- Teksti i përgjigjes
- A është e saktë apo jo
- Lidhja me pyetjen përkatëse
- Renditja e përgjigjeve

### 4. Controller i Statistikave
- Statistika të përgjithshme të testeve
- Grupimi i testeve sipas vështirësisë
- Grupimi i testeve sipas lëndës

### 5. Validime të Avancuara
- Validime për të gjitha fushat e reja
- Mesazhe gabimi në shqip
- Kufizime logjike për vlerat

## Struktura e Databazës
```sql
test -> question -> answer
```

## Si të Fillosh

### 1. Përgatitja e Mjedisit
```bash
# Klono projektin
git clone [repository-url]

# Hyr në dosjen e projektit
cd testManagement

# Ngrih infrastrukturën me Docker
docker-compose up -d
```

### 2. Testimi i API-ve
Pas nisjes së aplikacionit:
- **Swagger UI**: http://localhost:3000/testManagement-backend/swagger-ui.html
- **API Docs**: http://localhost:3000/testManagement-backend/v3/api-docs

### 3. Databaza
- **phpMyAdmin**: http://localhost:8099
- **Keycloak**: http://localhost:8180

## API Endpoints të Reja

### Testet
- `GET /api/tests/getAll` - Merr të gjitha testet
- `POST /api/tests/save` - Krijon një test të ri
- `PUT /api/tests/{id}` - Përditëson një test
- `GET /api/tests/{id}` - Merr një test sipas ID-së
- `DELETE /api/tests/{id}` - Fshin një test

### Statistikat
- `GET /api/test-statistics/summary` - Statistika të përgjithshme
- `GET /api/test-statistics/by-difficulty` - Testet sipas vështirësisë
- `GET /api/test-statistics/by-subject` - Testet sipas lëndës

## Hapat e Ardhshëm për Personalizim

### 1. Implementimi i Pyetjeve dhe Përgjigjeve
- Krijimi i controller-ave për Question dhe Answer
- Implementimi i service-ave përkatëse
- Shtimi i endpoint-ave për menaxhimin e pyetjeve

### 2. Sistemi i Vlerësimit
- Krijimi i modelit për rezultatet e testeve
- Implementimi i logjikës për vlerësimin automatik
- Raportimi i rezultateve

### 3. Frontend-i
- Krijimi i një interface-i web për administratorët
- Interface për studentët që do të marrin testet
- Dashboard për statistikat

### 4. Funksionalitete të Avancuara
- Import/Export i testeve
- Planifikimi i testeve
- Njoftimet email
- Integrimi me sisteme të tjera

## Teknologjitë e Përdorura
- **Backend**: Spring Boot 2.7.17, Java 17
- **Database**: MariaDB 10.4
- **Security**: Keycloak, OAuth2
- **Documentation**: Swagger/OpenAPI
- **Build Tool**: Gradle
- **Containerization**: Docker

