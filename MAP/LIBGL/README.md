# LIBGL

https://github.com/ERRA3774/UNITBV/assets/93817419/cb43bea7-d812-450d-aa00-87c886424d63

```txt
Tema 2 - MVP ID

Se cere sa se dezvolte o aplicaţie implementată în limbajul C#, obligatoriu de tip WPF, platforma .NET Framework 4.5+,
Visual Studio 2019+, folosind server de baze de date Microsoft SQL Server 2019 sau mai nou.  

Aplicaţia trebuie să permită gestiunea unei biblioteci.
Se vor putea introduce şi modifica date legate de cărţi, tipuri de cărţi, edituri, autori, utilizatori si carti împrumutate.
Se doreşte validarea datelor introduse, tratarea excepţiilor, precum şi prezenţa structurii MVVM. 

Aplicaţia trebuie să permită adăugare, modificare şi ştergere în tabelele menţionate mai jos: 
• Edituri: tabela Publisher (PublisherId, Name,  Active) (0.5 p) 
• Autori:  tabela Author (AuthorId, FirstName, LastName, BirthDate, Active)  (0.5 p) 
• Tip de cărti: tabela BookType (BookTypeId, Name, Active) – ex: Manuale şcolare  (0.5 p) 
• Cărti: tabela Book (BookId, BookTypeId, PublisherId, Title, PublishYear, Stock, Active (0.5 p) 
• Se va crea o tabelă de legătură AuthorBook, deoarece o carte poate avea mai multi autori 
(Id, AuthorId, BookId, NumberInList– pentru a ajuta la afişarea autorilor în ordine) (0.5 p) 
• Utilizatori ai bibliotecii: User (UserId, FirstName,  LastName, Email, Phone, Active) (0.5 p) 
• O tabelă pentru împrumuturi: UserBook (Id, UserId, BookId, StartDate, ReturnDate) (0.5 p) 

Meniul va arăta astfel: EDITURI - AUTORI – TIPURI DE CĂRŢI - CĂRŢI – ÎMPRUMUTURI 

Pentru fiecare meniu vom avea două submeniuri: Lista (edituri, autori…) si Adaugă (editură/autor…). 
De exemplu, la click pe un anumit autor din lista de autori se va deschide o fereastră cu datele precompletate ale autorului
(id-ul său din baza de date nu se va afişa, ci va fi doar folosit pentru aducerea din baza de date a informaţiilor legate de
autorul selectat), iar la adăugarea unui nou autor se va deschide aceeaşi fereastră ca la editare, dar fără datele precompletate,
urmând a se insera un nou autor în baza de date cu un Id alocat automat în SQL Server (deci se va crea o singură fereastră pentru
adăugarea/editarea aceleiaşi entităţi).

Ştergerile din sistem se vor opera doar la nivel logic, setând Active = 0. 
De exemplu, un autor pentru care momentan nu mai avem nicio carte disponibilă se poate dezactiva pentru a nu se mai afişa în lista
de autori disponibili, dar nu se şterge din tabela ‘Author’, ci doar se marchează ca inactiv (Active = 0), pentru ca datele deja
adăugate despre autor să rămână în baza de date, putând fi reactivate în cazul aducerii în bibliotecă a unui exemplar al unei
cărţi scrise de acelaşi autor. 

Se va stoca în câmpul Stock numărul de exemplare pentru fiecare carte din bibliotecă. 
Disponibilitatea unei cărti va putea fi calculată și afișată în funcție de numărul de exemplare 1 (Stock în tabela Book) și de
numărul total de împrumuturi ale acelei cărți fără dată de returnare (cu ReturnDate NULL în tabela UserBook pentru cartea cu
respectivul BookId). 

Alte cerinţe: 
(3p): Se cere ca în fiecare listă accesată din meniu să fie posibilă căutarea (filtrarea) după 
unul sau două câmpuri, ca de exemplu: 
-căutarea în lista de autori a unui autor după Nume (LastName) 
-căutarea în lista de cărţi a unei cărţi după titlu (Title) 
- căutarea în lista de cărţi a cărţilor publicate de un anumit autor 

(1.5p): De asemenea, se cere ca în fiecare dintre liste să fie posibilă sortarea (ordonarea) 
după toate câmpurile/coloanele din grid, pentru a putea vedea, de exemplu: 
- cărţile publicate de un anumit autor selectat, ordonate după anul publicării cărţii  
- cărţile unei edituri selectate, ordonate după numele editurii  
- cărţile împrumutate de un anumit utilizator, ordonate după data împrumutului 

```
