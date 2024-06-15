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


## Modulul 2

### TODO 1

```txt
Biti:        0   0   1   0   1   1   1   1   0   1   0   0   0   0   1   0
NRZ:         _   _       _                   _       _   _   _   _       _

Biti:        0   0   1   0   1   1   1   1   0   1   0   0   0   0   1   0
Ceas:       _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/-

Biti:        0   0   1   0   1   1   1   1   0   1   0   0   0   0   1   0
NRZI:       ___ ___ _/- --- -\_ _/- -\_ _/- --- -\_ ___ ___ ___ ___ _/- --- 

Biti:        0   0   1   0   1   1   1   1   0   1   0   0   0   0   1   0
Manchester: _/- _/- -\_ _/- -\_ -\_ -\_ -\_ _/- -\_ _/- _/- _/- _/- -\_ _/-
```
 
I. Scrieţi codificarea şirului de biţi 1101010011101001, folosind metodele descrise anterior. 

```txt
Biti:        1   1   0   1   0   1   0   0   1   1   1   0   1   0   0   1
NRZ:                 _       _       _   _               _       _   _      

Biti:        1   1   0   1   0   1   0   0   1   1   1   0   1   0   0   1
Ceas:       _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- _/- 

Biti:        1   1   0   1   0   1   0   0   1   1   1   0   1   0   0   1
NRZI:       _/- -\_ ___ _/- --- -\_ ___ ___ _/- -\_ _/- --- -\_ ___ ___ _/-

Biti:        1   1   0   1   0   1   0   0   1   1   1   0   1   0   0   1
Manchester: -\_ -\_ _/- -\_ _/- -\_ _/- _/- -\_ -\_ -\_ _/- -\_ _/- _/- -\_ 
```
II.

1. Metoda NRZ (Non-Return to Zero) asociază bitului 1 o valoare pozitivă a **curentului electric** sau prezenţa 
semnalului **luminos** pe care generic o vom nota cu **high** respectiv o 
**tensiune negativa** sau zero, desemnată prin starea **low**  
2. Codificarea NRZI (Non-Return to Zero Inverted) presupune că gazda sursă realizează o **tensiune** de la 
semnalul **curent** pentru a codifica o cifră binară 1, şi rămâne în **starea curenta** 
pentru a codifica o cifră binară 0. 
3. Codificarea Manchester, codifică bitul 0, respectiv  bitul 1  ca o tranziţie 
**low/high**, respectiv **high/low**. 
4. Semnalul analogic poate fi descompus într-o secvenţă de unde 
**sinusoidale** de diverse **frecvente** şi **amplitudini**  
5. Modemul este componenta care transformă semnalele **discrete** în semnale 
**analogice**. 
6. Banda de transfer este dată de **numarul de biti** ce pot fi transmişi peste o reţea 
într-o anumită **perioada de timp**. 
7. Transmisia în banda de bază presupune transmiterea de **semnale digitale** pe o 
singură **frecventa**. 
8. Transmisia în banda largă presupune transmiterea de **analogice** într-un 
**domeniu de frecvente**.

### TODO 2

1. În funcţie de diametrul **miezului de cupru**, cablul coaxial se împarte în **doua** 
categorii: **subtire (thinnet)** sau **gros (thicknet)**. 
2. Într-un cablu torsadat, scopul **impletirii** firelor este de a reduce 
**interferenta electrica (zgomotul electric)**. 
3. Cablul torsadat ecranat are un **invelis protector** de calitate mai bună decât cea a 
cablului UTP. De asemenea cablul STP include şi o **folie** dispusă în 
jurul fiecărei **perechi de fire**. 
4. Prin convenţie, un impuls de lumină înseamnă bitul **1** şi absenţa 
luminii indică bitul **0**. 
5. Prin ataşarea unei **surse de lumina** la un capăt al **fibrei optice** şi un **detector** la 
celălalt, obţinem un sistem **unidirectional** de transmisie a datelor care acceptă 
semnale **electrice**, le converteşte şi le transmite ca **impulsuri** luminoase şi 
apoi le **reconverteste** la ieşire în semnal **electric**. 
6. Tehnologia undelor radio în bandă îngustă. este similară cu **emisia** unei 
staţii **radio**.  
7. Tehnologia undelor în spectru împrăştiat constă în emiterea **semnalului** într-o 
**gama** de frecvenţe. 

### TODO 3

1.Dezavantajul folosirii repetoarelor este că acestea nu filtrează **traficul in retea**, în sensul că 
datele ce sosesc la unul din **porturile** repetorului sunt transmise **mai departe**, chiar şi în situaţia 
când **nu sunt destinate** unui calculator de pe **cablul respectiv**. 
2. Concentratoare active **regenereaza** şi **retransmit** semnale, la fel ca repetoarele. Datorită 
faptului că au între **opt si doisprezece** porturi pentru conectarea **conectarea calculatoarelor din retea**, concentratoarele mai sunt numite şi **repetoare multiport**. 
3. Când două gazde din reţea trimit date pe cablu **in acelasi timp**, apare o **coliziune** şi datele 
transmise de ambele gazde sunt **distruse**. 

### Test de evaluare 2

1. Metoda 4B/5B se referă la:   
**a) Codificarea datelor intr-un format universal**  
b) Codificarea datelor in semnale  
c) Transmiterea de mesaje catre toate gazdele dintr-o retea  
d) Criptarea datelor     

2. Relativ la repetor, care dintre afirmaţii este adevărată:  
**a) Este utilizat pentru a mări dimensiunea reţelei.**   
b) Micşorează spaţiul de coliziune.   
c) Determină transmiterea mai fiabilă a informaţiei.   
d) Recunoaşte adresa MAC.   

3. Hub-ul este:  
a) Transceiver multiport.     
**c) Repetor multiport.**    
b) De nivel 1.   
d) De nivel 2.  

4. Codificarea NRZI la sursă realizează : 
**a) O tranziţie de la semnalul curent, pentru a codifica o cifră binară 1 şi rămâne în starea curentă, pentru a codifica o cifră binară 0.** 
b) O tranziţie high-low.   
c) O tranziţie de la semnalul curent, pentru a codifica o cifră binară 0 şi rămâne în starea curentă, pentru a codifica o cifră binară 1. 
d) O tranziţie low-igh.  

5. Care dintre metode codifică bitul 0, respectiv bitul 1 ca o tranziţie „low/high”, respectiv „high/low”.   
a) NRZI.   
b) 4B/5B.   
**c) Manchester.**  
d) NRZ.  

6. În cazul cablului coaxial, stratul de ecranare este format din: 
**a) O plasă metalică şi o cămaşă interioară de protecţie.**  
b) O plasă metalică şi o cămaşă exterioară de protecţie.  
c) O plasă din plastic şi o cămaşă interioară de protecţie.   
d) O plasă din plastic şi o cămaşă exterioară de protecţie.  

7. În cazul cablului torsadat, scopul împletirii firelor este: 
**a) De a reduce interferenţa electrică**.   
b) De a reduce traficul în reţea.    
c) De a reduce interferenţa mecanică.   
d) De a reduce dimensiunea cablurilor.   

8. Transmisia în banda largă presupune: 
a) Transmiterea de şiruri de biţi într-un domeniu de frecvenţe.  
b) Transmiterea de semnale analogice într-un domeniu de frecvenţe.  
c) Transmiterea de semnale analogice pe cablu.  
**d) Transmiterea de semnale discrete într-un domeniu de frecvenţe.**  

9. Prin conectarea a două segmente de reţea printr-un repetor, domeniul de coliziune:  
a) Creşte.   
**b) Scade.**  
c) Rămâne constant.   
d) Se dublează.  

10. Stratul de ecranare la cablul coaxial este format:   
a) Dintr-un înveliş de aluminiu   
b) Dintr-o cămaşă exterioară de plastic şi plasă metalică protecţie. 
c) Dintr-un înveliş de plastic.  
**d) Dintr-o plasă metalică şi o cămaşă exterioară de protecţie.** 


### TODO 4 

1. Controlul legăturii logice se referă la stabilirea şi terminarea **legaturilor**, 
controlul **traficului** cadrelor de date, stabilirea succesiunii **cadrelor** şi **confirmarea** 
primirii acestora. 
2. Controlul accesului la mediu se referă la controlul **accesului** şi delimitarea 
**cadrelor**, **detectarea** erorilor şi **recunoasterea** adreselor. 
3. Subnivelul LLC permite nivelului **legatura de date** să funcţioneze independent de 
o anumită **tehnologie** 
4. LLC participă la **incapsularea** datelor şi este o **interfata** între maşina respectivă şi 
o anumită **tehnologie** de **transmitere** a datelor. 
5. Subnivelul MAC comunică direct cu **placa de retea** şi este responsabil pentru 
transportul **fara erori** al datelor între două **calculatoare** din reţea. 
6. Adresa MAC are o lungime de **48 de biti** şi este exprimată prin **12** 
cifre hexazecimale. Primele **6** cifre identifică **producatorul, acest camp fiind administrat de catre IEEE**,  iar celelalte **6** cifre reprezintă **numarul de interfata serial**


### TODO 5

1. Placa de reţea este formată din două componente principale: **interfata cu magistrala calculatorului** 
şi **interfata cu legatura cu mediul de retea**. Acestea sunt legate printr-o **cale de comunicatie**  
2. Înainte ca datele să fie **transmise** în reţea, placa de reţea trebuie să le **converteasca** din 
forma în care ele sunt înţelese de calculator, într-o formă în care acestea pot 
circula prin **cablul de retea**. 
3. Cu DMA **placa de retea** citeşte şi scrie din/în **memoria** gazdei fără o implicare a 
CPU. 
4. Dacă o placă de reţea mai **rapida** comunică cu una mai **lenta**, ele vor 
conveni asupra **vitezei de transmisie** pe care să o folosească. 
5. Portul  I∕ O de bază specifică un **canal** prin care informaţia circulă între 
**dispozitivele hardware** ale calculatorului (cum ar fi **placa de retea**) şi **unitatea centrala de procesare (CPU)** 

### TODO 6

1. Dacă două calculatoare ar plasa **simultan** date pe **cablu**, **cadrele de date** ale unui 
calculator ar intra în **coliziune** cu ale celuilalt şi ambele seturi de date ar fi 
**distruse**. 
2. CSMA/CD este cunoscuta ca **metoda competitionala**, deoarece calculatoarele din reţea 
se află în **competitie**, adică îşi dispută ocazia de a **disputa ocazia de a transmite date**. 
3. Numărul de **coliziuni** şi de încercări de **evitare** este **direct proportional** cu 
**numarul de calculatoare** din reţea, deci la o dimensiune mare a reţelei  CSMA/CD poate fi 
considerată o metoda de acces **lenta**. 
4. 10 Base FL reprezintă specifcaţia IEEE pentru arhitectura **Ethernet** cu cablu de 
**fibra optica**. 
5. În cazul metodei de acces prin transfer de jeton (token passing), există un 
pachet special, denumit **jeton**, care circulă de-a lungul **inelului** de la un 
**calculator** la altul. 
6. La un moment dat, un **singur** jeton poate fi **activ** pe reţea, iar acesta nu 
poate parcurge inelul decât într-un **singur** sens. Metoda de acces prin 
transferul jetonului este **determinista**, ceea ce înseamna că un calculator nu poate 
forţa drumul prin reţea ca într-un mediu **CSMA/CD**.


### TODO 7

1. O punte transferă cadrul de date în funcţie de adresa **nodului de destinatie**. Pe măsură ce 
traficul trece prin punte, informaţiile despre **adresele calculatoarelor** sunt stocate în 
memoria acesteia. 
2. Singurele cadre pentru care nu se face filtrare sunt cele de tip **broadcast**, adică 
acelea destinate **intregii retele**. 
3. În cazul transmiterii **neorientate pe conexiune**, se presupune că fiecare **cadru de date** care 
trebuie transmis conţine adresa **completa** de destinaţie. Pentru a decide cum 
să transmită mai departe un cadru de date, switch-ul consultă o **tabela**, care 
conţine adresele **adresele destinatiilor** posibile şi **porturilor de iesire** către ele.  
4. Drumul urmat de un cadru de date este succesiunea de **switch-uri** prin care trece 
cadrul, de la **gazda sursa** la **gazda destinatie**. 
5. Starea de **conectare** neccesară într-un switch dintr-un **circuit** virtual, constă 
dintr-o intrare într-o **tabela a VC-ului** pentru fiecare conectare.

### Test de evaluare 3

1. Care dintre categoriile IEEE 802 definesc tehnologia token ring:  
a) 802.4.   
b) 802.6.  
**c) 802.5.**   
d) 802.7.

2. Care dintre categoriile IEEE 802 definesc reţele metropolitane:  
a) 802.4.   
**b) 802.6.**  
c) 802.5.   
d) 802.7.  

3. Care dintre subnivelurile nivelului legătură de date este responsabil de controlul 
accesului şi delimitarea cadrelor, detectarea erorilor şi recunoaşterea adreselor.  
a) HUB.   
b) MAC.  
c) Ethernet.    
**d) LLC.** - Logical Link Control

4. Care dispozitiv conectat la placa de reţea detectează când cablul este liber şi 
direcţionează semnalul când gazda îl transmite către mediul de comunicaţie.   
a) HUB.   
**b) Transceiver.**   
c) Switch.  
d) Punte. 

5. Care formulare este corectă:  
**a) Adresa MAC are 48 de biţi şi este dată exclusiv de o autoritate centrală.**   
b) Adresa MAC este introdusă în orice pachet care se transmite prin reţea.    
c) Adresa MAC face ca placa de retea sa se afle in nivelul retea.  
d) Adresa MAC are 8 octeti si nu poate fi schimbata.  

6. Legat de switch, care afirmaţie este corectă:  
a) Este hub multiport.   
b) Este dispozitiv de nivel 3   
**c) Foloseste adresele MAC pentru a micsorarea numarului domeniilor de coliziune.**  
d) Recunoaşte adresele IP  

7. Fast Ethernet înseamnă viteză de transfer de: 
a) 1000 Mbps.   
**b) 100 Mbps.**  
c) 10 Mbps.   
d) 11/22. 

8. Pentru a transfera datele din calculator la placa de reţea, calculatorul şi placa 
trebuie comunică prin intermediul:   
**a) registrului de control CSR.**   
c) registrului de control CSB.  
b) registrului de control SSR.   
d) registrului de control PCR.  


