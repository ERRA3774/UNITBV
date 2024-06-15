# Retele de calculatoare

## Modulul 1

### TODO 1

1. Un calculator nu este **autonom** atunci când el poate să fie **pornit**, să fie 
**oprit** sau să fie **controlat**  în mod forţat de către un altul. 
2. Dacă impunem calculatoarelor cerinţa de a fi autonome, atunci excludem relaţia de 
tip **master-slave**  între ele.  
3. Modelul centralizat presupune un calculator **puternic** la care sunt legate mai 
multe **terminale**, care nu au capacitate de **procesare**, ci servesc doar pentru 
introducerea sau primirea datelor. 
4. Modelul client/server se referă la împărţirea **operatiilor de prelucrare** a 
datelor între **un calculator pe care se executa aplicatia client** şi un **calculator** 
mai puternic. 
5. Un server dedicat este un calculator care **functioneaza** doar ca server, 
rulând **programe specializate** pentru îndeplinirea unor anumite funcţionalităţi. 


### TODO 2

1. Într-o reţea peer-to-peer nu există **servere dedicate** şi nici o organizare 
**ierarhica** a calculatoarelor. 
2. Într-o reţea peer-to-peer fiecare calculator are şi **rolul de client** si cel de 
**server**, neexistând un **administrator** responsabil pentru întreaga reţea.  
3. Serverele de **fisiere** şi de **tiparire** administrează accesul şi folosirea de 
către utilizatori a resurselor de tip fişier şi imprimantă. 
4. Serverele de aplicaţii pun la dispoziţia **clientilor** componenta **server** a 
aplicaţiilor de tip **client-server**, precum şi **datele** respective. 
5. Serverele de poştă gestionează transferul de **mesaje electronice** către 
**utilizatorii** reţelei. 
6. O reţea metropolitană (Metropolitan Area Network - MAN) este **o versiune extinsa
 de LAN** ce se poate întinde pe zona ocupată de un grup de birouri învecinate sau 
 chiar **suprafata unui oras**. 
7. Gazdele sau reţelele LAN sunt conectate prin **sisteme intermediare** sau elemente 
de **comutare (routere)**, care formează **o subretea de comunicatie**

### TODO 3

1. Topologia fizică se referă la **dispunerea** fizică în teren a **calculatoarelor**, a 
**cablurilor** şi celorlalte **componente** ale reţelei. 
2. În cazul în care calculatoarele sunt conectate de-a lungul unui singur 
**cablu (segment)** , topologia poartă numele de **magistrala (bus)** 
3. Magistrala este o topologie **pasiva** 
4. Într-o topologie **activa** calculatoarele regenerează **semnalul** şi transferă 
**datele** în reţea. 
5. Pentru a opri **reflectarea** semnalului, la fiecare capăt al cablului este plasată 
o componentă numită **terminator** care are rolul de **a absorbi** semnalele 
libere. 
6. Topologia inel **conecteaza** o gazdă la următoarea şi ultima gazdă la 
**prima** 
7. În cadrul topologiei stea, calculatoarele sunt conectate prin segmente de 
cablu la o **componenta centrala*, numită **concentrator (hub)** 
8. În cadrul topologiei magistrală-stea există mai multe **retele** cu topologie 
**magistrala si stea**, conectate prin intermediul unor trunchiuri liniare de tip **magistrala** 

### TODO 4

1. Nivelul Aplicatie este **cel mai inalt** în ierarhia OSI şi serveşte drept **fereastra** prin 
care aplicaţiile au acces la **serviciile de retea** 
2. Nivelul Prezentare determină **formatul** folosit pentru **schimbul de date** între 
calculatoarele din reţea.  
3. Nivelul Sesiune permite ca două aplicaţii aflate pe **calculatoare** diferite să 
**stabileasca**, să **foloseasca** şi să încheie o **conexiune** numită sesiune.  
4. Nivelul Transport asigură transportul pachetelor de date la **destinatie**, în 
**succesiune**, fără **pierderi** şi fără **duplicate**. 
5. Nivelul Reţea gestioneaza **adresele logice (IP)** De asemenea, acest nivel determină 
**ruta (calea de acces)** de la sursă la destinaţie într-o **inter-retea**. 
6. Nivelul Legătură de date transmite **cadrele de date** către nivelul Fizic, cel care 
realizează transportul **sirurilor de biti**.  
7. La gazda sursă are loc fenomenul de **incapsulare** Datele circulă de **sus in jos**; 
fiecare nivel primeşte o structura de date de la **nivelul superior** şi adaugă o 
**zona de informatie specifica lui (antet)**, care conţine informaţii adresate **nivelului corespondent**de la gazda destinaţie.  
8. La gazda destinaţie are loc fenomenul de **decapsulare**. Fiecare **nivel (cu exceptia nivelului fizic)** primeşte de la **nivelul inferior** structura de date adresată lui, extrage **informatia** adresată lui şi transmite restul de date către **nivelul superior**. 
9. Dacă modelul OSI este un standard orientativ, TCP/IP este o **arhitectura** utilizată de reţeaua **Internet si de predecesorul ei, ARPANET**. Modelul TCP/IP are patru niveluri: **Aplicatie, Transport, Internet, Access la retea**.

### Test De evaluare 1:

1. Modelul client/server se referă la:   
a) Împărţirea operaţiilor de prelucrare a datelor între mai multe calculatoare pe care se execută aplicaţia client.  
b) Împărţirea operaţiilor de prelucrare a datelor între mai multe calculatoare pe care se execută aplicaţia server. 
**c) Împărţirea operaţiilor de prelucrare a datelor între un calculator pe care se execută aplicaţia client şi un calculator mai puternic pe care se execută aplicaţia server.**   
d) Împărţirea operaţiilor de prelucrare a datelor pe un calculator multi
procesor. 

2. Topologia în care nu există capete libere este:   
**a) Inel.**   
b) Magistrală.   
c) Stea extinsă  
d) Magistrală-stea.

3. Topologia care îsi are originile în arhitectura unui calculator mainframe, este:  
a) Inel.   
b) Magistrală.   
**c) Stea**   
d) Magistrală-stea.  

4. Relativ la modelul OSI, care nivel asigură transportul pachetelor de date la destinaţie, în succesiune, fără pierderi şi fără duplicate:   
a) Aplicaţie.   
b) Prezentare. 
c) Sesiune.  
**d) Transport.**  

5. O subreţea de comunicaţie este alcătuită din: 
a) Topologii diverse.    
b) Routere.   
**c) Mai multe reţele locale.**  
d) Exclusiv cabluri.  

6. Relativ la modelul OSI, determinarea căii de acces se face la nivelul: 
a) Fizic.   
b) Legătură de date.   
**c) Reţea.**  
d) Transport.  

7. Relativ la modelul OSI conversia setului de caractere şi stabilirea unui format comun apare la nivelul:   
**a) Prezentare.**   
b) Sesiune.   
c) Transport.  
d) Reţea.  

8. Prin care fenomen datele circulă de sus în jos, fiecare nivel primeşte o structura de date de 
la nivelul superior şi adaugă o zonă de informaţie specifica lui (antet), care conţine informaţii 
adresate nivelului corespondent de la gazda destinaţie: 
a) Concatenare.  
b) Adăugare.   
**c) Încapsulare.**  
d) Decapsulare.

9. Modelul TCP/IP are:  
**a) 4 nivele.**   
b) 3 nivele.   
c) 2 nivele.  
d) 1 nivel.  

10. Protocolul TCP se află la nivelul: 
a) Aplicaţie.   
**b) Transport.**   
c) Reţea.   
d) Acces la reţea  

11. Regulile după care nivelurile comunica între ele formează: 
a) Serverul nivelului respectiv.   
**b) Protocolul nivelului respectiv.**     
c) Interfaţa nivelului respectiv.  
d) Clientul nivelului respectiv.  

12. Pentru unităţile care sunt conectate direct la o reţea se foloseşte termenul de: 
a) Client.  
**b) Gazdă.**  
c) Calculator.  
d) Sistem de calcul.  

13. TCP/IP include serviciile oferite de nivelurile prezentare şi sesiune ale modelului OSI, în nivelul său:  
**a) Aplicaţie.**   
b) Transport.   
c) Reţea.   
d) Acces la reţea.  

