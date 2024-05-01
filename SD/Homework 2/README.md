# Homework 2

```cpp
/*
1. Sa se simuleze o stiva utilizand doua cozi. Se va crea structura stiva cu functiile
de push(), pop(), isEmpty() si clear(), iar cele 2 cozi vor fi campuri ale structurii. Puteti folosi implementare proprie de coada sau queue din C++. (2p)
*/
```

```cpp
#include <queue>
#include <iostream>

struct Qx2Stack {

	void Push(int val) {
		std::cout << "Pushed " << val << std::endl;
		_q2.push(val);

		while (_q1.empty() == false) {
			_q2.push(_q1.front());
			_q1.pop();
		}

		std::swap(_q1, _q2);
	}

	void Pop() {
		if (_q1.empty()) {
			std::cout << "Qx2Stack is empty." << std::endl;
			return;
		}
		std::cout << "Popped " << _q1.front() << std::endl;
		_q1.pop();
	}

	bool Empty() {
		std::cout << "Qx2Stack is ";
		_q1.empty() == true ? std::cout << "empty" : std::cout << "NOT empty.";
		std::cout << std::endl;
		return _q1.empty();
	}

	void Clear() {
		while (_q1.empty() == false) {
			std::cout << "Popped " << _q1.front() << std::endl;
			_q1.pop();
		}
	}

private:
	std::queue<int> _q1;
	std::queue<int> _q2;
};

void TestProblem1() {
	Qx2Stack stack;

	stack.Empty();
	stack.Push(1);
	stack.Push(2);
	stack.Push(3);
	stack.Push(4);
	stack.Push(5);
	stack.Push(6);
	stack.Empty();

	stack.Pop();
	stack.Pop();
	stack.Pop();
	stack.Empty();

	stack.Push(4);
	stack.Push(5);
	stack.Push(6);
	stack.Empty();

	stack.Clear();
	stack.Empty();
}
```
```cpp
/*
2. Sa se implementeze o lista dublu inlantuita cu functionalitatile descris in
continuare. Se cere utilizarea unei structuri node care are trei campuri: un
camp pentru informatie (de tip int) si doua campuri de tip pointer la node
pentru legaturile catre elementele precedent si urmator. Se cere utilizarea unei
structuri List care are ca membri doua variabile de tip Node* reprezentand
primul respectiv ultimul element din lista, o variabila de tip int reprezentand
numarul de elemente din lista si functiile:
> push_front(key) - adauga cheia key in capul listei
> push_back(key) - adauga cheia key la finalul listei
> pop_front() - sterge primul element din lista
> pop_back() - sterge ultimul element din lista
> find(key) - cauta o cheie key in lista - returneaza pointer la nodul cu
cheia key sau NULL
> clear() - sterge toate elementele listei
> print() - afiseaza elementele listei
> remove(int key) - sterge toate aparitiile cheii key (implica cautare)
> erase(Node* nod) - sterge un element nod din lista (Nu implica cautare)
> size() - returneaza numarul de elemente din lista

In functia main creati un scurt context de testare si apelati functiile implementate. (2p)
*/
```

```cpp
struct Node {
	int Data;
	Node* Prev;
	Node* Next;


	Node(const int& data) : Data(data), Prev(nullptr), Next(nullptr) {}
};

struct List {

	List() : _head(nullptr), _tail(nullptr), _size(0) {}


	void PushFront(const int& key) {
		Node* node = new Node(key);

		if (_head == nullptr) {
			_head = _tail = node;
		}
		else {
			node->Next = _head;
			_head->Prev = node;
			_head = node;
		}

		_size++;
	}

	void PushBack(const int& key) {
		Node* node = new Node(key);

		if (_head == nullptr) {
			_head = _tail = node;
		}
		else {
			node->Prev = _tail;
			_tail->Next = node;
			_tail = node;
		}

		_size++;
	}

	void PopFront() {
		if (_head == nullptr) {
			return;
		}

		if (_head->Next == nullptr) {
			_head = _tail = nullptr;
		}
		else {
			Node* front = _head;
			_head = _head->Next;
			_head->Prev = nullptr;
			delete front;
		}

		_size--;
	}

	void PopBack() {
		if (_head == nullptr) {
			return;
		}

		if (_head->Next == nullptr) {
			_head = _tail = nullptr;
		}
		else {
			Node* back = _tail;
			_tail = _tail->Prev;
			_tail->Next = nullptr;
			delete back;
		}
		_size--;
	}

	Node* Find(const int& key) {
		Node* target = _head;

		while (target != nullptr) {
			if (target->Data == key) {
				return target;
			}
			target = target->Next;
		}

		std::cerr << "[W] Could not find element with key " << key << ". Return value is nullptr." << std::endl;
		return nullptr;
	}

	void Clear() {
		while (_head != nullptr) {
			Node* curr = _head;
			_head = _head->Next;
			delete curr;
		}

		_size = 0;
	}

	void Print() const {
		std::cout << "List: [ ";
		Node* curr = _head;
		while (curr != nullptr) {
			std::cout << curr->Data;
			if (curr != _tail) {
				std::cout << ", ";
			}
			curr = curr->Next;
		}
		std::cout << " ]" << std::endl;
	}

	void Remove(const int& key) {

		Node* curr = _head;
		Node* next = nullptr;

		while (curr != nullptr) {

			if (curr->Data == key) {
				next = curr->Next;
				Erase(curr);
				curr = next;
			}
			else {
				curr = curr->Next;
			}
		}
	}

	void Erase(const Node* node) {

		if (_head == nullptr || node == nullptr) {
			return;
		}

		if (_head == node) {
			_head = node->Next;
		}

		if (node->Next != nullptr) {
			node->Next->Prev = node->Prev;
		}

		if (node->Prev != nullptr) {
			node->Prev->Next = node->Next;
		}

		delete node;
		_size--;
	}

	int Size() const {
		return _size;
	}

	bool Empty() const {
		return _size == 0;
	}

private:
	Node* _head;
	Node* _tail;
	int _size;
};

void TestProblem2() {
	List list;

	std::cout << "List is empty. Expected: True; Actual: " << (list.Empty() ? "True" : "False") << std::endl;

	list.PushFront(1);
	list.PushFront(2);
	list.PushFront(3);
	list.PushFront(4);
	list.PushFront(5);
	list.PushFront(6);
	list.PushFront(7);
	list.Print();

	std::cout << "List size. Expected: 7; Actual: " << list.Size() << std::endl;

	list.PushBack(1);
	list.PushBack(2);
	list.PushBack(3);
	list.PushBack(4);
	list.PushBack(5);
	list.PushBack(6);
	list.PushBack(7);
	std::cout << "List is empty. Expected: False; Actual: " << (list.Empty() ? "True" : "False") << std::endl;

	list.PopFront();
	list.PopBack();


	std::cout << "Expected to have removed the '7' from the beginning and '7' from the back of the list." << std::endl;
	list.Print();

	list.Remove(1);

	std::cout << "Expected to have removed all occurances of '1' from the list" << std::endl;

	list.Print();

	list.Erase(list.Find(6));

	std::cout << "Expected to have removed the first '6' from the list" << std::endl;

	list.Print();

	list.Clear();

	std::cout << "List is empty. Expected: True; Actual: " << (list.Empty() ? "True" : "False") << std::endl;
}
```

```cpp
/*
3. Sa se implementeze o lista dublu inlantuita cu functionalitatile descris in
continuare. Se cere utilizarea unei structuri node care are trei campuri: un
camp pentru informatie (de tip int) si doua campuri de tip pointer la node
pentru legaturile catre elementele precedent si urmator. Se cere utilizarea unei
structuri List care are ca membri doua variabile de tip Node* reprezentand
primul respectiv ultimul element din lista, o variabila de tip int reprezentand
numarul de elemente din lista si functiile:

> push_back(key)
> insert(node* Nod, int val) - insereaza un element cu cheia val inainte de
nodul indicat Nod
> size() - returneaza numarul de elemente din lista
> merge(Lista L) - concateneaza lista curenta cu lista L. Dupa apel lista
curenta contine elementele celor doua liste concatenate, iar L devine vida.
> print()
> palindrom(Lista L)
> compare(Lista L1, Lista L2) - returneaza 1 daca L1 si L2 sunt indentice si 0 altfel

In functia main creati un scurt context de testare si apelasi functiile implementate
*/
```

```cpp
struct DNode {
	int Data;
	DNode* Next;
	DNode* Prev;


	DNode(const int& data) : Data(data), Next(nullptr), Prev(nullptr) {}
};

struct DLList {

	DLList() : _head(nullptr), _tail(nullptr), _size(0) {}


	DNode* Begin() const {
		return _head;
	}

	DNode* End() const {
		return _tail;
	}

	int Size() const {
		return _size;
	}

	bool Empty() const {
		return _size == 0;
	}


	void PushBack(const int& key) {
		DNode* node = new DNode(key);

		if (_head == nullptr) {
			_head = _tail = node;
		}
		else {
			node->Prev = _tail;
			_tail->Next = node;
			_tail = node;
		}

		_size++;
	}


	void PopFront() {
		if (_head == nullptr) {
			return;
		}

		if (_head->Next == nullptr) {
			_head = _tail = nullptr;
		}
		else {
			DNode* front = _head;
			_head = _head->Next;
			_head->Prev = nullptr;
			delete front;
		}

		_size--;
	}

	DNode* Find(const int& key) {
		DNode* target = _head;

		while (target != nullptr) {
			if (target->Data == key) {
				return target;
			}
			target = target->Next;
		}

		std::cerr << "[W] Could not find element with key " << key << ". Return value is nullptr." << std::endl;
		return nullptr;
	}


	void Insert(DNode* node, const int& val) {
		if (node == nullptr) {
			std::cout << "[I] Input parameter node is nullptr. Not inserting value." << std::endl;
			return;
		}

		DNode* newNode = new DNode(val);

		if (node == _head) {
			newNode->Next = _head;
			_head->Prev = newNode;
			_head = newNode;
			_size++;
			return;
		}

		if (node == _tail) {
			newNode->Next = _tail;
			newNode->Prev = _tail->Prev;
			_tail->Prev = newNode;
			newNode->Prev->Next = newNode;
			_size++;
			return;
		}

		DNode* curr = _head;
		while (curr->Next != node) {
			curr = curr->Next;
		}

		newNode->Prev = curr;
		newNode->Next = curr->Next;
		curr->Next = newNode;
		newNode->Next->Prev = newNode;
		_size++;
	}


	// This will empty all elements from the input parameter
	void Merge(DLList& list) {
		while (list.Empty() == false) {
			int value = list.Begin()->Data;
			list.PopFront();
			PushBack(value);
		}
	}


	void Print(const std::string& name = "DLList") const {
		std::cout << name << ": [ ";
		DNode* curr = _head;
		while (curr != nullptr) {
			std::cout << curr->Data;
			if (curr != _tail) {
				std::cout << ", ";
			}
			curr = curr->Next;
		}
		std::cout << " ]" << std::endl;
	}


private:
	DNode* _head;
	DNode* _tail;
	int _size;
};

bool Palindrome(const DLList& list) {
	DNode* head = list.Begin();

	if (head == nullptr) {
		return false;
	}

	DNode* tail = list.End();

	while (head != tail) {
		if (head->Data != tail->Data) {
			return false;
		}

		head = head->Next;
		tail = tail->Prev;
	}

	return true;
}


bool Compare(DLList& current, DLList& other) {
	DNode* headCurrent = current.Begin();
	DNode* headOther = other.Begin();

	if (current.Size() != other.Size()) {
		return false;
	}

	if (headCurrent == nullptr && headOther == nullptr) {
		return true;
	}

	while (headCurrent != nullptr) {

		if (headCurrent->Data != headOther->Data) {
			return false;
		}

		headCurrent = headCurrent->Next;
		headOther = headOther->Next;
	}

	return true;
}


void TestProblem3() {
	DLList list;

	list.PushBack(1);
	list.PushBack(2);
	list.PushBack(3);
	list.PushBack(4);
	list.PushBack(5);

	std::cout << "L1 is palindrome? Expected: False; Actual: " << (Palindrome(list) ? "True" : "False") << std::endl;

	std::cout << "L1 size. Expected: 5; Actual: " << list.Size() << std::endl;

	list.Print("First List");

	list.Insert(list.Find(1), 1);
	list.Insert(list.Find(1), 2);
	list.Insert(list.Find(2), 3);
	list.Insert(list.Find(3), 4);
	list.Insert(list.Find(4), 5);

	list.Print("L1");

	std::cout << "L1 size. Expected: 10; Actual: " << list.Size() << std::endl;

	std::cout << "L1 is palindrome? Expected: True; Actual: " << (Palindrome(list) ? "True" : "False") << std::endl;

	DLList other;
	other.PushBack(5);
	other.PushBack(4);
	other.PushBack(3);
	other.PushBack(2);
	other.PushBack(1);
	other.PushBack(1);
	other.PushBack(2);
	other.PushBack(3);
	other.PushBack(4);

	list.Print("L1");
	other.Print("L2");
	std::cout << "Compare L1 to L2. Expected: False; Actual: " << (Compare(list, other) ? "True" : "False") << std::endl;
	other.PushBack(5);
	list.Print();
	other.Print();
	std::cout << "Compare L1 to L2. Expected: True; Actual: " << (Compare(list, other) ? "True" : "False") << std::endl;

	list.Merge(other);
	list.Print("L1");

	std::cout << "L1 is empty. Expected: False; Actual: " << (list.Empty() ? "True" : "False") << std::endl;
	std::cout << "L2 is empty. Expected: True; Actual: " << (other.Empty() ? "True" : "False") << std::endl;
}
```

```cpp
/*
4. Inversare elemente vector. Sa se inverseze elementele unui vector utilizand
o stiva. Primul element se va intershimba cu ultimul, al doilea cu penultimul, etc. (2p)
*/
```

```cpp
#include <vector>
#include <stack>

void Reverse(std::vector<int>& vec) {
	std::stack<int> st;

	for (const int& el : vec) {
		st.push(el);
	}

	for (int& el : vec) {
		el = st.top();
		st.pop();
	}
}

void Display(const std::vector<int>& vec) {
	std::cout << "Vector: [ ";
	for (const int& el : vec) {
		std::cout << el;
		if (el != vec.back()) {
			std::cout << ", ";
		}
	}
	std::cout << " ]" << std::endl;
}

void TestProblem4() {

	std::vector<int> vec = { 1,2,3,4,5,6,7,8,9 };

	Reverse(vec);
	Display(vec);
}
```

```cpp
/*
5. Parantezare corecta. Se da un sir de paranteze deschise si inchise de tip (, ), [, ], {, }.
Sa se verifice daca sirul este corect. Folositi o stiva (std::stack) pentru rezolvare.
Exemplu: sirul [()()] este corect,
		 sirul ([]) nu este corect,
		 sirul ()]( nu este corect. (3p)
*/
```

```cpp
bool GoodParanthesis(const std::string& para) {
	if (para.empty() || para.length() % 2 == 1) {
		return false;
	}

	std::stack<char> stack;

	for (const char& curr : para) {
		if (stack.empty() == true) {
			stack.push(curr);
		}
		else if ((stack.top() == '(' && (curr == '[' || curr == '{')) || (stack.top() == '[' && curr == '{') || (stack.top() == '{' && curr == '(')) {
			return false;
		}
		else if ((stack.top() == '(' && curr == ')') || (stack.top() == '[' && curr == ']') || (stack.top() == '{' && curr == '}')) {
			stack.pop();
		}
		else {
			stack.push(curr);
		}
	}

	return stack.empty();
}

void TestProblem5() {
	std::cout << "Test 1. " << (GoodParanthesis("{{[[()()]]}}{}") == true ? "Pass" : "Fail") << std::endl;

	std::cout << "Test 2. " << (GoodParanthesis("([{}])") == false ? "Pass" : "Fail") << std::endl;

	std::cout << "Test 3. " << (GoodParanthesis("()]") == false ? "Pass" : "Fail") << std::endl;

	std::cout << "Test 4. " << (GoodParanthesis("[()]{}{[()()][()]}") == true ? "Pass" : "Fail") << std::endl;

	std::cout << "Test 5. " << (GoodParanthesis("[()]{}{[({})([])]()}") == false ? "Pass" : "Fail") << std::endl;
}
```

```cpp
/*
6. Implementare coada. Sa se implementeze o coada utilizand liste inlantuite. Va trebuie
> o structura node cu doua campuri - un camp pentru informatie (de tipul cerut de problema curenta) si un camp de tip pointer la node pentru legatura la elementul urmator
> o structura Queue cu
  >> doua campuri de tip pointer la nod, pentru primul si ultimul element initializate cu NULL (nullptr)
  >> un camp nr_elem de tip int - numarul de elemente din coada.
  >> functia push(elem) - pune elem la sfarsitul cozii
  >> functia pop() - elimina elementul de la inceputul cozii
  >> functiile front() si back() returneaza primul respectiv ultimul element din coada
  >> functia empty() - verifica daca coada este vida.
  >> functia clear() - goleste coada
  >> functia size() - returneaza numarul de elemente din coada

Aceasta coada va fi utilizata in urmatoarea problema:

La un examen se pot prezenta candidati pe durata a doua zile. In fiecare zi
timpul alocat pentru examinare este de t ore (t <= 5). La examen se inscriu
n candidati. Se citesc din fisier t, n precum si candidatii cu numele (de tip std::string).
Ei vor fi introdusi intr-o coada, de unde vor fi extrasi pe rand
pentru examinare. Pentru fiecare candidat care este la rand, se genereaza o
durata aleatorie cu o valoare intre 15 minute si 25 minute. In momentul in
care timpul t s-a terminat, deci se incheie prima zi de evaluare, candidatii care
au ramas in coada vor fi extrasi pe rand si trecuti intr-un fisier de iesire, care
va reprezenta lista candidatilor pentru ziua a doua de examinare. (4p)
*/
```

```cpp
#include <fstream>
#include <sstream>

struct QNode {
	std::string Data;
	QNode* Next;

	QNode(std::string data) : Data(data), Next(nullptr) {}
};

struct Queue {

	Queue() : _head(nullptr), _tail(nullptr), _size(0) {}


	QNode* Front() const {
		return _head;
	}

	QNode* Back() const {
		return _tail;
	}

	int Size() const {
		return _size;
	}

	bool Empty() const {
		return _size == 0;
	}


	void Push(std::string value) {
		QNode* node = new QNode(value);

		if (_head == nullptr) {
			_head = _tail = node;
		}
		else {
			_tail->Next = node;
			_tail = node;
		}

		_size++;
	}

	void Pop() {
		if (_head == nullptr) {
			return;
		}

		if (_head->Next == nullptr) {
			_head = _tail = nullptr;
		}
		else {
			QNode* front = _head;
			_head = _head->Next;
			delete front;
		}

		_size--;
	}

	void Clear() {
		while (_head != nullptr) {
			QNode* curr = _head;
			_head = _head->Next;
			delete curr;
		}
		_size = 0;
	}

	void Print() const {
		std::cout << "Queue: [ ";
		QNode* curr = _head;
		while (curr != nullptr) {
			std::cout << curr->Data;
			if (curr != _tail) {
				std::cout << ", ";
			}
			curr = curr->Next;
		}
		std::cout << " ]" << std::endl;
	}

private:
	QNode* _head;
	QNode* _tail;
	int _size;
};

void InitializeExaminationDataFromFile(const std::string& path, Queue& candidates, int& candidatesCount, int& allocatedHours) {
	std::ifstream fin(path);

	if (fin.is_open() == false) {
		std::cout << "[E] Could not open file from path " << path << std::endl;
		return;
	}

	int count;
	int hours;
	fin >> hours >> count;

	if (fin) {
		allocatedHours = hours;
		candidatesCount = count;
	}
	else {
		std::cout << "Failed to read candidates count and examination time." << std::endl;
	}

	while (fin) {
		std::string line;
		std::getline(fin, line);

		if (line.empty() == true) {
			continue;
		}

		candidates.Push(line);
	}
}

void ExamineCandidates(Queue& initialCandidates, Queue& remainingCandidates, const int& candidatesCount, const int& allocatedHours) {

	srand(time(NULL));

	int allocatedMinutes = allocatedHours * 60;

	while (initialCandidates.Empty() == false && allocatedMinutes > 0) {
		int minutesForCurrentCandidate = rand() % 11 + 15;
		std::string currentCandidateName = initialCandidates.Front()->Data;
		initialCandidates.Pop();

		if (minutesForCurrentCandidate <= allocatedMinutes) {
			allocatedMinutes -= minutesForCurrentCandidate;
			std::cout << "Candidate " << currentCandidateName << " was evaluated successfully." << std::endl;
			std::cout << "Time taken: " << minutesForCurrentCandidate << " minutes." << std::endl;
			std::cout << "Time left: " << allocatedMinutes << " minutes." << std::endl;
		}
		else {
			std::cout << "Candidate " << currentCandidateName << " could not be evaluated today." << std::endl;
			remainingCandidates.Push(currentCandidateName);
		}
	}
}

void GenerateFileWithRemainingCandidates(const std::string& path, Queue remainingCandidates) {
	std::ofstream out(path);

	if (remainingCandidates.Empty()) {
		out << "This file is empty.";
		return;
	}

	for (int i = 0; i < remainingCandidates.Size(); i++) {
		std::string name = remainingCandidates.Front()->Data;
		out << name << '\n';
		remainingCandidates.Pop();
	}
}

void TestProblem6() {
	int candidatesCount;
	int allocatedHours;
	Queue initialCandidates;
	Queue remainingCandidates;

	InitializeExaminationDataFromFile("candidates_day1.txt", initialCandidates, candidatesCount, allocatedHours);
	ExamineCandidates(initialCandidates, remainingCandidates, candidatesCount, allocatedHours);
	GenerateFileWithRemainingCandidates("candidates_day2.txt", remainingCandidates);
}
```

```cpp
/*
7. Coada circulara. Pentru aceasta se cere crearea unei 
structuri COADA care sa continua:

> un camp de tip vector de int numit DATA, care stocheaza elementele din
coada
> un camp SIZE_MAX de tip int, care reprezinta capacitatea maxima a 
cozii
> doua campuri de tip int BEGIN = pozitia primului element si END =
pozitia de dupa ultimul element din coada.
> functia PUSH(elem) - pune elem in coada
> functia POP() - elimina un elem din coada
> functia FRONT() - returneaza valoarea aflata la inceputul cozii
> functia EMPTY() - verifica daca este vida sau nu coada
> functia CLEAR() - goleste coada

In functia main se declara o variabila de tip COADA, se insereaza pe rand n
elemente, cu n citit de la tastatura, apoi se extrag aceste elemente pe rand si
se afiseaza in ordinea extragerii. (4p)
*/
```

```cpp
struct CircularQueue {

	CircularQueue() : _data(std::vector<int>()), _capacity(0), _begin(-1), _end(-1) {}
	CircularQueue(int cap) : _data(std::vector<int>()), _capacity(cap), _begin(-1), _end(-1) {}


	void Push(const int& value) {

	}

	void Pop() {

	}

	int Front() {
        return 0;
	}

    bool Empty() {
        return false;
    }

	void Clear() {

	}

private:
	std::vector<int> _data;
	int _capacity;
	int _begin;
	int _end;
};

void TestProblem7() {

}

```

```cpp
/*
8. Arbore sintactic.
Se citeste dintr-un fisier o expresie aritmetica formata din:
1. numere
2. variabile
3. operatori de baza (+, -, *, /) si paranteze
Exemplu: (3+1)*7
Exemplu: 4+x*((5-1+2)*3+2*(y-1))
a) Sa se construiasca un arbore sintactic corespunzator expreisei. (2p)
b) Sa se afiseze Arborele pe niveluri. (0.5p)
c) Sa se evalueze expresia. Pentru variabile sa se ceara in mod repetat vari de tip double. (2p)

*/
```

```cpp
#include <fstream>
#include <string>
#include <stack>
#include <unordered_map>

static bool IsDigit(const char& ch) {
	return ch >= '0' && ch <= '9';
}

static bool IsVariable(const char& ch) {
	return (ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z');
}

static bool IsOperator(const char& ch) {
	return ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '^';
}

static bool IsBracket(const char& ch) {
	return ch == '(' || ch == ')' || ch == '[' || ch == ']' || ch == '{' || ch == '}';
}

static int OperatorPrecedence(const char& op) {
	switch (op) {

	case '^':
		return 3;

	case '*':
	case '/':
		return 2;

	case '+':
	case '-':
		return 1;

	default:
		return 0;
	}
}

struct Expression {

	std::string Infix;
	std::string Postfix;


	Expression() : _data(std::string()), _good(true) {}


	// Reads only 1 line
	void InitFromFile(const std::string& path) {
		std::ifstream fin(path);

		if (fin.is_open() == false) {
			std::cout << "Could not open file." << std::endl;
			return;
		}

		std::string line;
		std::getline(fin, line);

		for (char& ch : line) {

			if (ch == ' ') {
				continue;
			}

			if (IsDigit(ch) == false &&
				IsVariable(ch) == false &&
				IsOperator(ch) == false &&
				IsBracket(ch) == false) {
				std::cout << "Bad: " << ch << ' ' << static_cast<int>(ch) << std::endl;
				_good = false;
			}

			_data += ch;
		}

		if (_data.length() < 3) {
			_good = false;
		}

		Infix = _infixForm();
		Postfix = _postfixForm();
	}

	void Print() {
		std::cout <<
			"Data: " << _data << '\n' <<
			"Valid: " << (_good == true ? "True" : "False") << std::endl;
	}

private:

	std::string _infixForm() {

		if (_good == false) {
			std::cout << "Expression is invalid. Return value is \"\".";
			return "";
		}

		return _data;
	}

	std::string _postfixForm() {

		if (_good == false) {
			std::cout << "Expression is invalid. Return value is \"\".";
			return "";
		}

		std::string postfix;
		std::stack<char> ops;

		for (char& ch : _data) {

			if (IsDigit(ch) || IsVariable(ch)) {
				postfix += ch;
			}
			else if (IsBracket(ch) && ch == '(') {
				ops.push(ch);
			}
			else if (IsBracket(ch) && ch == ')') {
				while (ops.empty() == false && ops.top() != '(') {
					postfix += ops.top();
					ops.pop();
				}
				ops.pop();
			}
			else {
				while (ops.empty() == false && ops.top() != '(' && OperatorPrecedence(ch) <= OperatorPrecedence(ops.top())) {
					postfix += ops.top();
					ops.pop();
				}
				ops.push(ch);
			}
		}

		while (ops.empty() == false) {
			postfix += ops.top();
			ops.pop();
		}

		return postfix;
	}


private:
	std::string _data;
	std::string _postfix;
	std::string _infix;
	bool _good;
};


struct STNode {
	char Data;
	STNode* Left;
	STNode* Right;

	STNode(const char& c) : Data(c), Left(nullptr), Right(nullptr) {}
};

struct SyntaxTree {

	SyntaxTree() : _root(nullptr), _size(0), _height(0), _operands(std::unordered_map<char, double>()) {}

	SyntaxTree(const Expression& e) : _root(nullptr), _size(0), _height(0), _operands(std::unordered_map<char, double>()) {
		std::stack<STNode*> nodes;
		std::string postfix = e.Postfix;

		for (char& ch : postfix) {
			if (IsDigit(ch) || IsVariable(ch)) {

				if (IsVariable(ch)) {
					_operands[ch] = 1.0;
				}

				STNode* var = new STNode(ch);
				nodes.push(var);
				_size++;
			}
			else {
				STNode* right = nodes.top();
				nodes.pop();
				STNode* left = nodes.top();
				nodes.pop();

				STNode* parent = new STNode(ch);
				parent->Left = left;
				parent->Right = right;
				nodes.push(parent);
			}
		}

		_root = nodes.top();
		_height = _HeightFromNode(_root);
	}

	void Print() {
		_printNode(_root, "", false);
	}

private:

	void _printNode(STNode* curr, std::string format, bool last) {
		if (curr == nullptr) return;

		std::cout << format;

		if (curr == _root) {
			std::cout << "Root: ";
			format += "     ";
		}
		else if (last) {
			std::cout << " +-- ";
			format += "     ";
		}
		else {
			std::cout << " +-- ";
			format += " |    ";
		}

		std::cout << '\'' << curr->Data << '\'' << std::endl;

		_printNode(curr->Right, format, curr->Left == nullptr);
		_printNode(curr->Left, format, true);
	}

	int _HeightFromNode(STNode* target) {
		if (target == nullptr) {
			return -1;
		}

		std::stack<STNode*> nodes;
		nodes.push(target);
		int height = 0;
		int level = 0;

		while (nodes.empty() == false) {
			STNode* curr = nodes.top();
			nodes.pop();

			if (level > height) {
				height = level;
			}

			if (curr->Right != nullptr) {
				nodes.push(curr->Right);
				level++;
			}

			if (curr->Left != nullptr) {
				nodes.push(curr->Left);
				level++;
			}
		}

		return height;
	}


private:
	STNode* _root;
	int _size;
	int _height;
	std::unordered_map<char, double> _operands;
};

void TestProblem8() {

	Expression expr;

	expr.InitFromFile("expression.txt");

	SyntaxTree tree(expr);

	tree.Print();
}
```