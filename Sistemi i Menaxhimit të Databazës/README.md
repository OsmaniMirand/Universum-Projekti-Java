# Library Management System - Database Project

## 1. Hyrje (Introduction)

### Përshkrim i projektit
Ky projekt implementon një "Library Management System" - sistem për menaxhimin e bibliotekës që mundëson:
- Menaxhimin e librave dhe autorëve
- Regjistrimin e anëtarëve të bibliotekës
- Huazimin dhe kthimin e librave
- Gjenerimin e raporteve dhe statistikave

### Objektivat
- Dizajnimi dhe implementimi i një baze të dhënash funksionale
- Mundësimi i ruajtjes, përpunimit dhe analizimit të të dhënave
- Krijimi i një sistemi të plotë për menaxhimin e bibliotekës

### Scope
Sistemi mbulon:
- Menaxhimi i librave, autorëve dhe kategorive
- Regjistrimi i anëtarëve
- Procesi i huazimit dhe kthimit
- Raporte dhe statistika
- Ndërlidhje komplekse mes të dhënave

## 2. Database Design

### ERD (Entity-Relationship Diagram)
Sistemi përmban 6 tabela kryesore:
1. **Authors** - Autorët e librave
2. **Categories** - Kategoritë e librave
3. **Books** - Librat
4. **Members** - Anëtarët e bibliotekës
5. **Loans** - Huazimet
6. **Book_Authors** - Tabela lidhëse për marrëdhënien N:M mes librave dhe autorëve

### Marrëdhëniet
- Authors ↔ Books (N:M përmes Book_Authors)
- Categories → Books (1:N)
- Members → Loans (1:N)
- Books → Loans (1:N)