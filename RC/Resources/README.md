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

9. Numărul de coliziuni şi de încercări de evitare a acestora este direct proporţional cu:  
a) numărul de procese care se execută pe calculatoare din reţea.   
**b) numărul de calculatoare din reţea.**  
c) numărul de servere din reţea.   
d) numărul de switch-uri din reţea.   

10. Care dintre metodele de acces la mediul de comunicaţie nu este competiţională: 
a) CSMA/CD.   
b) CSMA/AC.  
c) Transfer de jeton.   
**d) Token Ring.**    

11. În cazul transmiterii neorientate pe conexiune a cadrelor de date, se presupune că:  
a) Fiecare cadru de date care trebuie transmis, este trimis gazdei următoare din reţea.   
**b) Fiecare cadru de date care trebuie transmis, conţine adresa completă de destinaţie.**   
c) Fiecare cadru de date care trebuie transmis, este trimis următorului switch.  
d) Fiecare cadru de date care trebuie transmis, este trimis următorului router. 


## Modulul 3

### TODO 1

1. Se dă adresa 126.95.0.0. Scrieţi tipul şi clasa adresei.

```txt
Clasa A - primul bit al primului octet = 0
Clasa B - primii 2 biti ai primului octet = 10
Clasa C - primii 3 biti ai primului octet = 110
Clasa D - primii 4 biti ai primului octet = 1110
Clasa E - primii 4 biti ai primului octet = 1111

Ip: 126.95.0.0 -> 0111 1110. 0101 1111. 0000 0000. 0000 0000 => Clasa A
```

2. Scrieţi adresa reţelei din care face parte gazda de adresă 190.19.23.98. Scrieţi adresa de difuzare pe această reţea.
```txt
Ip: 190.19.23.98 -> 1011 1110. 0001 0011. 0001 0111. 0110 0010 => Clasa B

Network Ip  : 190.19.0.0
Broadcast Ip: 190.19.255.255
```
 
3. Scrieţi o adresă de gazdă de clasă C. Scrieţi adresele reţelei din care face 
parte gazda. Care este adresa de broadcast pe această reţea.

```
Clasa C - primii 3 biti ai primului octet = 110 => 1100 0000 = 192
Network Ip  : 192.168.1.0
Broadcast Ip: 192.168.1.255
```


### TODO 2

1. Dacă adresa IP este 190.95.92.144 şi masca de subreţea este 255.255.254.0, determinaţi:  

a) Numărul de biţi împrumutaţi pentru a se crea subreţele.   

```txt

Ip: 190.95.92.144

190 -> 1011 1110
 95 -> 0101 1111
 92 -> 0101 1100
144 -> 1001 0000

190.95.92.144 -> 1011 1110. 0101 1111. 0101 1100. 1001 0000 => Clasa B
Net    mask: 255.255.0.0
Subnet mask: 255.255.254.0

255 -> 1111 1111
255 -> 1111 1111
254 -> 1111 1110
  0 -> 0000 0000

255.255.254.0 -> 1111 1111. 1111 1111. 1111 1110. 0000 0000

Numarul zecimal 254 convertit in binar reprezinta numarul de biti imprumutati 7 pentru a crea subretele
```

b) Adresa sub-reţelei căreia îi aparţine o gazda dată.    

```txt

Pentru a determina subreteaua careia ii apartine gazda, efectuam operatia AND intre reprezentarile binare ale adresei IP si mastii de subretea.

Adreasa Ip : 190.95.92.144
Subnet mask: 255.255.254.0

1011 1110. 0101 1111. 0101 1100. 1001 0000 | AND
1111 1111. 1111 1111. 1111 1110. 0000 0000 |
-------------------------------------------+
1011 1110. 0101 1111. 0101 1100. 0000 0000

Adresa subretea: 190.95.92.0
```

2. Aceeşi problemă pentru adresa 126.95.0.0 cu masca 255.252.0.0, respectiv 199.99.33.88, cu masca 255.255.255.252 

```txt
Ip            : 126.95.0.0   -> 0111 1110. 0101 1111. 0000 0000. 0000 0000 => Clasa A
Masca subretea: 255.252.0.0  -> 1111 1111. 1111 1100. 0000 0000. 0000 0000 
Masca retea   : 255.0.0.0    -> 1111 1111. 0000 0000. 0000 0000. 0000 0000

Numarul zecimal 252 convertit in binar reprezinta numarul de biti imprumutati 6 pentru a crea subretele

0111 1110. 0101 1111. 0000 0000. 0000 0000 | AND
1111 1111. 1111 1100. 0000 0000. 0000 0000 |
------------------------------------------+
0111 1110. 0101 1000. 0000 0000. 0000 0000

Adresa subretea: 126.88.0.0


Ip            : 199.99.33.88    -> 1100 0111. 0110 0011. 0010 0001. 0101 1000 => Clasa C
Masca subretea: 255.255.255.252 -> 1111 1111. 1111 1111. 1111 1111. 1111 1100
Masca retea   : 255.255.255.0   -> 1111 1111. 1111 1111. 1111 1111. 0000 0000

Numarul zecimal 252 convertit in binar reprezinta numarul de biti imprumutati 6 pentru a crea subretele

1100 0111. 0110 0011. 0010 0001. 0101 1000 | AND
1111 1111. 1111 1111. 1111 1111. 1111 1100 |
------------------------------------------+
1100 0111. 0110 0011. 0010 0001. 0101 1000

Adresa subretea: 199.99.33.88
```

3. Se dă adresa 130.131.255.255.  

a) Carei clase îi aparţine adresa dată? De ce tip este adresa? 

```txt
130.131.255.255 -> 1000 0010. 1000 0011. 1111 1111. 1111 1111

Clasa: B
Tip adresa: Adresa de broadcast  
```

b) Care este masca de sub-reţea implicită? Care este adresa reţelei? 

```txt
130.131.255.255

Adresa de retea: 130.131.0.0
Masca subretea 255.255.0.0
```

c) Care este adresa celei de a 25-a gazde din această reţea?  

```txt
Adresa de retea: 130.131.0.0
Adresa celei de a 25-a gazde: 130.131.0.25
```

d) Câte gazde pot exista în întreaga reţea, conform celor de mai sus?

```txt
Pot exista 2^16 - 2 de gazde
```

e) Câţi biţi trebuie să se împrumute, dacă:  
* numărul este minim şi se crează 17 subreţele,  
* numărul este maxim, astfel încât în fiecare subreţea să existe 31 de gazde.

```txt
Pp n = nr de biti imprumutati

Numărul este minim şi se crează 17 subreţele
2^n >= 17
2^0 = 1  >= 17 F
2^1 = 2  >= 17 F
2^2 = 4  >= 17 F
2^3 = 8  >= 17 F
2^4 = 16 >= 17 F
2^5 = 32 >= 17 A
Numarul de biti care trebuie imprumutati = 5

Numărul este maxim, astfel încât în fiecare subreţea să existe 31 de gazde.
2^h - 2 >= 31
2^0 - 2 = -1 >= 31 F
2^1 - 2 = 0  >= 31 F
2^2 - 2 = 2  >= 31 F
2^3 - 2 = 6  >= 31 F
2^4 - 2 = 14 >= 31 F
2^5 - 2 = 30 >= 31 F
2^6 - 2 = 62 >= 31 A
Numarul de biti care trebuie imprumutati = 6
```

f) În condiţiile de la e.1., să se scrie adresa IP a ultimei subreţele, domeniul adreselor gazdelor, adresa IP de broadcast pentru această subreţea, adresa celei de a 19 - a gazde din această subreţea.

```txt

1000 0010. 1000 0011. 1111 1111. 1111 1111

2 <= k <= 14

```

g) Dacă se împrumută 4 biţi pentru crearea de subreţele, să se scrie într-un tabel adresa IP a fiecărei subreţele, domeniul adreselopentru gazde, adresa de broadcast.

e) Câte gazde se pot crea în cadrul reţelei iniţiale, dacă nu se fac subreţele?  

4. Se dă adresa IP 194.195.196.198, cu masca de reţea 255.255.255.240 
    a) Să se determine adresa reţelei, adresa subreţelei, a câta gazdă este în subreţeaua respectivă, adresa de broadcast pe subreţea.   
    b) Numărul maxim de gazde din fiecare subreţea, numărul de subreţele care se pot obţine, numărul total de gazde din reţea (de pe toate subreţelele).  
    c) Adresele fiecărei subreţele, domeniul de adrese pentru gazdele din fiecare subreţea, adresele de broadcast pentru fiecare subreţea.   


### Test de evaluare 4

1. Fiecare reţea, care are o adresă din clasa A, poate avea asignate pentru unităţile ataşate ei, cel mult:   
a) 2^32-2 adrese IP posibile.   
b) 2^16-2 adrese IP posibile.  
**c) 2^24-2 adrese IP posibile.**   
d) 2^8-2 adrese IP posibile. 

2. Un mod de a recunoaşte dacă o unitate este ataşată unei adrese de tip B, este de a verifica dacă numărul memorat în primul octet este cuprins între: 128 şi 191.   
**a) 128 şi 191.**   
b) 64 şi 128.  
c) 64 şi 191.   
d) 191 şi 223.

3. În cazul adreselor IP de clasă C, care octeţi identifică numărul de reţea:   
a) ultimii trei.  
b) primii doi.  
c) ultimii doi.   
**d) primii trei.**

4. Adresele din care clasă sunt de tip multicast:   
a) A.   
b) C.  
c) B.   
**d) D.**  

5. Dacă cele trei reţele locale din figura 3.1.5 sunt de clasă A, gazdele A1, A2, B1, C1 pot avea adresele:    
a) 125.126.127.128; 125.127.128.126; 27.126.125.128; 128.125.127.126.    
**b) 125.126.127.128; 125.126.127.129; 125.127.127.130; 125.125.124.123**    
c) 129.126.127.128; 129.126.128.127; 129.127.128.126; 129.128.127.126.   
d) 129.126.127.128; 129.127.128.127; 129.127.128.126; 125.127.126.128.   

6. Numărul cel mai mare de adrese disponibile care pot fi atribuite gazdelor, se găseşte într-o reţea de:  
**a) clasă A.**   
b) clasă B.   
c) clasă C.  
d) clasă D. 

7. Pentru a se crea câmpul de subreţea se împrumută:  
**a) Un număr de cel puţin 2 biţi, care sunt cei mai din dreapta ai câmpului de gazdă.** 
b) Un număr de cel puţin 2 biţi, care sunt cei mai din stânga ai câmpului de gazdă. 
c) Un număr de cel puţin 2 biţi, care sunt cei mai din dreapta ai câmpului de reţea. 
d) Un număr de cel mult 2 biţi, care sunt cei mai din dreapta ai câmpului de reţea. 

8. Pentru determinarea sub-reţelei căreia îi aparţine o anumită gazdă, se execută:  
a) O operaţie “sau” logic între adresa IP a gazdei destinaţie şi masca de subreţea, exprimate în forma binară.  
b) O operaţie “sau exclusiv” logic între adresa IP a gazdei destinaţie şi masca de subreţea, exprimate în forma binară.  
**c) O operaţie “şi” logic între adresa IP a gazdei destinaţie şi masca de subreţea, exprimate în forma binară.**  
d) O operaţie “şi exclusiv” logic între adresa IP a gazdei destinaţie şi masca de subreţea, exprimate în forma binară.  

9. Relativ la figura 3.1.5, care dintre protocoalele de rezoluţie a adreselor va fi folosit, dacă gazda A1 doreşte să transmită un pachet gazdei A3: 
**a) ARP.**   
b) Proxy-TCP   
c) Proxy-IP.  
d) Proxy-ARP.

10. Relativ la figura 3.1.5, care dintre protocoalele de rezoluţie a adreselor va fi folosit, dacă gazda A1 doreşte să transmită un pachet gazdei C1:  
a) ARP.   
b) Proxy-TCP.   
c) Proxy-IP.  
**d) Proxy-ARP.**

11. Care dintre nivelurile OSI realizează routarea:  
a) Legătură de date.  
b) Aplicaţie.   
**c) Reţea.**  
d) Transport.  

12. În cadrul unui LAN, un pachet primit de la interfaţa routerului este transportat:  
a) în antetul LAN.   
b) în antetul TCP.   
c) în câmpul aplicaţie.  
**d) într-un cadru de date.**

13. Un sistem autonom este:   
a) O regiune dintr-o reţea locală care este administrată de o singură entitate.  
b) O regiune din reţeaua Internet care este conectată la un singur router.  
**c) O regiune din reţeaua Internet care este administrată de o singură entitate.**  
d) O regiune dintr-o reţea locală care este conectată la un singur router.  

14. În cadrul cărui protocol de routare, costul fiecărei legături este 1:  
**a) RIP.**   
b) IGRP.   
c) EIGRP.  
d) OSPF. 

15. Protocolul bazat pe vectorul distanţă RIP, efectuează routarea:   
a) în interiorul unui sistem autonom.  
b) în interiorul unei reţele locale.   
**c) într-un domeniu.**   
d) într-o arie.  

Started on	Sunday, 16 June 2024, 8:10 AM
State	Finished
Completed on	Sunday, 16 June 2024, 8:36 AM
Time taken	26 mins 21 secs
Grade	17.00 out of 20.00 (85%)
Question 1
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Care dintre urmatoarele protocoale au rolul de alocare a adreselor IP?

Question 1Answer

a.
Bootstrap Protocol si DHCP


b.
DNS si POP3


c.
TCP/IP si UDP


d.
DHCPDISCOVER, DHCPOFFER si DHCPREQUEST

Feedback
The correct answer is: Bootstrap Protocol si DHCP
Question 2
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Care dintre urmatoarele afirmatii este FALSA in raport cu ideea de Sistem Autonom (AS)?

Question 2Answer

a.
Un Sistem Autonom este impartit in arii de retele si gazde


b.
Un Sistem Autonom deserveste toate organizatiile comerciale


c.
Ariile unui Sistem Autonom comunica prin intermediul unei "coloane vertebrale - backbone"


d.
Ariile unui Sistem Autonom utilizeaza protocoale distincte de dirijare a pachetelor in interiorul AS-ului si intre AS-uri

Feedback
The correct answer is: Un Sistem Autonom deserveste toate organizatiile comerciale
Question 3
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Ce topologie de retea este deservita de protocolul Token Ring?

Question 3Answer

a.
magistrala


b.
topologie cu configuratie mixta


c.
stea


d.
inel

Feedback
The correct answer is: inel
Question 4
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Rolul protocolului SMTP este urmatorul:

Question 4Answer

a.
asigura transferul de date intre 2 gazde


b.
asigura transportul de mesaje de posta electronica de la serverul de email la gazde


c.
asigura transferul de fisiere in retea


d.
asigura transportul de mesaje de posta electronica intre 2 gazde

Feedback
The correct answer is: asigura transportul de mesaje de posta electronica intre 2 gazde
Question 5
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Care dintre urmatorii algoritmi de criptare utilizeaza trunchierea mesajului?

Question 5Answer

a.
MD4, MD5, SHA


b.
DES si RSA


c.
RSA si MD5


d.
RSA si Diffie-Hellman

Feedback
The correct answer is: MD4, MD5, SHA
Question 6
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Ce reprezinta un sistem de criptare simetric?

Question 6Answer

a.
Un sistem ce utilizeaza aceeasi cheie si pentru criptare si pentru decriptare


b.
Este acelasi cu un sistem de criptare cu cheie publica


c.
Un sistem ce utilizeaza chei diferite pentru criptare si decriptare


d.
Un sistem de criptare conventional

Feedback
The correct answer is: Un sistem ce utilizeaza aceeasi cheie si pentru criptare si pentru decriptare
Question 7
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Protocolul ARP este cel care:

Question 7Answer

a.
returneaza portul la care asculta o aplicatie


b.
returneaza adresa MAC pe baza unei adrese IP


c.
returneaza adresa IP pe baza unei adrese MAC


d.
returneaza asocierea dintre numarul de port si adresa IP

Feedback
The correct answer is: returneaza adresa MAC pe baza unei adrese IP
Question 8
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Rolul unui mesaj ACK este:

Question 8Answer

a.
de a solicita confirmarea primirii mesajului pe care o sursa il transmite unei destinatii


b.
de a marca acceptarea unei conexiuni


c.
de a marca o cerere de conexiune


d.
de a confirma primirea unui mesaj de la gazda sursa

Feedback
The correct answer is: de a confirma primirea unui mesaj de la gazda sursa
Question 9
Incorrect
Mark 0.00 out of 1.00
Remove flag
Question text
Ce afirmatie este FALSA cu privire la Autentificarea cu Chei Publice?

Question 9Answer

a.
Doua gazde care doresc sa se autentifica folosesc un server de autentificare


b.
Serverul de autentificare genereaza un interval de timp in care este valida cheia de sesiune


c.
Serverul de autentificare transmite un mesaj gazdelor prin care confirma autentificarea acestora


d.
Serverul de autentificare va genera cheia cu care vor fi criptate/decriptate mesajele transmise intre gazde, dupa autentificare

Feedback
The correct answer is: Serverul de autentificare transmite un mesaj gazdelor prin care confirma autentificarea acestora
Question 10
Incorrect
Mark 0.00 out of 1.00
Remove flag
Question text
Un URL reprezinta:

Question 10Answer

a.
referinta catre o aplicatie web


b.
referinta catre un fisier ce se poate deschide intr-un browser web


c.
calea catre un fisier HTML


d.
calea catre un fisier stocat local

Feedback
The correct answer is: referinta catre un fisier ce se poate deschide intr-un browser web
Question 11
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Care dintre urmatoarele afirmatii referitoare la adresele IPv6 este FALSA?

Question 11Answer

a.
Adresele IPv6 pot fi scrise si intr-un format comprimat


b.
Antetul unei adrese IPv6 nu contine nici numarul de fragment si nici bitul care indica daca mai urmeaza si alte datagrame in sesiune


c.
O adresa IPv6 este reprezentata pe 16 octeti


d.
O adresa IPv6 este reprezentata ca 8 grupuri de cifre hexazecimale

Feedback
The correct answer is: Antetul unei adrese IPv6 nu contine nici numarul de fragment si nici bitul care indica daca mai urmeaza si alte datagrame in sesiune
Question 12
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Semnatura digitala este:

Question 12Answer

a.
o metoda de a verifica integritatea mesajelor


b.
o metoda de generare a cheilor de criptare


c.
o metoda de detectie a erorilor de transmitere a mesajelor


d.
o metoda de criptare a mesajelor

Feedback
The correct answer is: o metoda de a verifica integritatea mesajelor
Question 13
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Din punctul de vedere al organizarii, protocolul DNS poate fi vazut ca:

Question 13Answer

a.
un spatiu de adrese IP


b.
un spatiu ierarhizat de nume


c.
o structura de domenii primare


d.
o structura formata din nume si adrese IP

Feedback
The correct answer is: un spatiu ierarhizat de nume
Question 14
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Placa de retea actioneaza ca:

Question 14Answer

a.
mecanism de codificare a cadrelor de date in siruri de biti


b.
mecanism de routare a pachetelor in retea


c.
interfata fizica intre gazda si retea


d.
interfata logica pentru incapsularea cadrelor de date in pachete IP

Feedback
The correct answer is: interfata fizica intre gazda si retea
Question 15
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Protocolul UDP este implementat in arhitectura OSI la:

Question 15Answer

a.
Nivelul Transport


b.
Nivelul Acces la Retea


c.
Nivelul Aplicatie


d.
Nivelul Sesiune

Feedback
The correct answer is: Nivelul Transport
Question 16
Incorrect
Mark 0.00 out of 1.00
Remove flag
Question text
Mecanismul NAT presupune:

Question 16Answer

a.
permiterea ca 2 calculatoare din reteaua Internet sa foloseasca aceeasi adresa IP publica


b.
transformarea unei adrese IP publica intr-una privata


c.
permiterea ca 2 calculatoare dintr-o retea locala sa foloseasca aceeasi adresa IP privata


d.
transformarea unei adrese IP privata intr-una publica

Feedback
The correct answer is: transformarea unei adrese IP privata intr-una publica
Question 17
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Domeniile primare de nume recunoscute de protocolul DNS sunt reprezentate de:

Question 17Answer

a.
numele diferitelor institutii


b.
nume de tari


c.
nume de organizatii


d.
diferite tipuri de organizatii si tari

Feedback
The correct answer is: diferite tipuri de organizatii si tari
Question 18
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Diferitele tipuri de medii de comunicatie in retea au impact direct asupra carui nivel al arhitecturii OSI?

Question 18Answer

a.
Nivelul Aplicatie


b.
Nivelul Retea


c.
Nivelul Legatura de Date


d.
Nivelul Fizic

Feedback
The correct answer is: Nivelul Fizic
Question 19
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Algoritmul Ferestrei Glisante reprezinta:

Question 19Answer

a.
un mecanism de transmitere de mesaje fara confirmarea primirii


b.
un mecanism de transmitere de mesaje intre 2 gazde, cu confirmarea primirii


c.
un mecanism de criptare a mesajelor transmise intre 2 gazde


d.
un mecanism de autentificare dinaintea unei sesiuni de comunicare intre 2 gazde

Feedback
The correct answer is: un mecanism de transmitere de mesaje intre 2 gazde, cu confirmarea primirii
Question 20
Correct
Mark 1.00 out of 1.00
Remove flag
Question text
Datagrama este denumirea pe care o poarta mesajul transmis in cazul utilizarii protocolului:

Question 20Answer

a.
TCP


b.
RPC


c.
ARP


d.
UDP

Feedback
The correct answer is: UDP