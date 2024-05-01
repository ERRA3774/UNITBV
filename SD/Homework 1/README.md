# Homework 1


```cpp
#include <iostream>         // Pentru std::cin, std::cout, std::endl
#include <vector>           // Pentru std::vector
#include <string>           // Pentru std::string
#include <sstream>          // Pentru std::istringstream
#include <fstream>          // Pentru std::ifstream, std::ofstream
#include <unordered_map>    // Pentru std::unordered_map
#include <algorithm>		// Pentru std::sort, std::unique
```

```cpp
/*
1. Numim perechea (x,y) pereche ordonata daca x<y.
 (a) Sa se verifice daca un vector contine doar perechi ordonate (care satisfac conditia de mai sus). (1p)
 (b) Sa se verifice daca oricare x din prima jumatate a vectorul formeaza opereche ordonata cu oricare y din cea de-a doua jumatate. (2p)
*/
```

```cpp
std::vector<std::pair<int, int>> GetPairsFromFile(const std::string& path) { // Asta citeste linie cu linie. Pe fiecare linie sa fie o pereche de 2 numere
	std::vector<std::pair<int, int>> pairs;
	std::ifstream fin(path);

	if (!fin.is_open()) {
		std::clog << "[E] Could not open file from path: " << path << std::endl;
		return {}; // Asta inseamna ca returnez un vector gol
	}

	while (fin) {
		std::string line;
		std::pair<int, int> tempPair;
		std::getline(fin, line);
		std::istringstream iss(line);
		iss >> tempPair.first >> tempPair.second;

		if (iss) {
			pairs.emplace_back(tempPair);
		}
		else {
			std::cout << "[W] Discarded " << iss.str() << std::endl;
		}
	}

	return pairs;
}

std::vector<std::pair<int, int>> GetPairsFromConsole() {
	std::vector<std::pair<int, int>> pairs;
	int size = 0;

	while (size == 0) {
		int tempSize = 0;
		std::string input;

		std::cout << "input = ";
		std::getline(std::cin, input);

		std::istringstream iss(input); // Asta e folosita ca sa scape de litere in cazul in care sunt.
		iss >> tempSize; // Scoate din stream un token care e int pentru ca tempSize e int. Scrii "abc" -> 0, "1abc" -> 1, "1 2 3 4 5" -> 1 (2 3 4 5 raman in stream dar sunt folosite si se pierd)

		if (iss && tempSize > 0) {
			size = tempSize;
		}
		else {
			std::cout << "The size must be a positive number." << std::endl;
		}
		std::cout << std::endl;
	}

	for (int i = 0; i < size;) { // i++ e folosit mai jos
		std::string input;
		std::pair<int, int> tempPair;

		std::cout << "Enter " << size << " number of pairs." << std::endl;
		std::cout << "pair " << (i + 1) << ": ";
		std::getline(std::cin, input);
		std::istringstream iss(input);

		iss >> tempPair.first >> tempPair.second;

		if (iss) {
			pairs.emplace_back(tempPair);
			i++; // Il incrementez doar daca am pereche valida
		}
		else {
			std::cout << "Each pair must have integer numbers separated by spaces." << std::endl;
		}
		std::cout << std::endl;
	}

	return pairs;
}

// (a) Sa se verifice daca un vector contine doar perechi ordonate (care satisfac conditia de mai sus). (1p)

bool AllOrderedPairs(const std::vector<std::pair<int, int>>& pairs) {
	for (const std::pair<int, int>& pair : pairs) { // Trece prin fiecare pereche
		if (pair.first > pair.second) { // Daca o p
			std::cout << "[D] Found unordered pair." << std::endl;
			return false;
		}
	}

	return true;
}


// (b) Sa se verifice daca oricare x din prima jumatate a vectorul formeaza opereche ordonata cu oricare y din cea de-a doua jumatate. (2p)

bool AllOrderedPairsComparingHalves(const std::vector<std::pair<int, int>>& pairs) { // Ex: {1,2}, {3,4}, {5,6}, {7,8}, {9,0}

	int mid = pairs.size() / 2; // 5 / 2 = 2

	for (int i = 0; i < mid; i++) { // i: 0, 1
		for (int j = mid; j < pairs.size(); j++) { // 2, 3, 4
			if (pairs[i].first > pairs[j].second) { // 1 > 6, 1 > 8, 1 > 0, 2 > 6, 2 > 8, 2 > 0 . . . 
				return false;
			}
		}
	}

	return true;
}

void Display(const std::vector<std::pair<int, int>>& pairs) {
	std::cout << "Pairs: ";
	for (const std::pair<int, int>& pair : pairs) {
		std::cout << "{ " << pair.first << ", " << pair.second << " }";
		if (pair != pairs.back()) { // Daca nu e ultima, nu pune virgula
			std::cout << ", ";
		}
	}
	std::cout << std::endl;
}

void TestProblem1() {
	std::vector<std::pair<int, int>> filePairs = GetPairsFromFile("pairs.txt");
	Display(filePairs);
	AllOrderedPairs(filePairs);
	AllOrderedPairsComparingHalves(filePairs);
}
```

```cpp
/*
2. Sa se verifice si sa se afiseze daca un vector este superior sau inferior.
 Un vector este superior daca acesta contine mai multe elemente cu valoarea mai
 mare decat media aritmetica a intregului vector si inferior altfel. (2p)
*/
```

```cpp
std::vector<int> GetNumbersFromFile(const std::string& path) { // Asta citeste toate numerele existente separate prin spatiu sau enter.
	std::vector<int> numbers;
	std::ifstream fin(path);

	if (!fin.is_open()) {
		std::clog << "[E] Could not open file from path: " << path << std::endl;
		return {};
	}

	int token;
	while (fin >> token) {
		numbers.emplace_back(token);
	}

	return numbers;
}

std::vector<int> GetNumbersFromConsole() { // Asta citeste toate numerele de pe o singura linie pana cand un caracter nu e numar. 
	std::vector<int> numbers;

	std::string input;
	std::cout << "input = ";
	std::getline(std::cin, input);
	std::cout << std::endl;
	std::istringstream iss(input);

	int token;
	while (iss >> token) {
		numbers.emplace_back(token);
	}

	return numbers;
}

bool IsSuperior(const std::vector<int>& numbers) {
	int sum = 0;
	int count = 0;
	float average = 0.0f;

	for (const int& number : numbers) { // Faci media tuturor numerelor
		sum += number;
	}

	average = sum / numbers.size();

	for (const int& number : numbers) { // Numeri cate numere sunt mai mari ca media
		if (number > average) {
			count++;
		}
	}

	return count > average;
}

void Display(const std::vector<int>& numbers) {
	std::cout << "Numbers: ";
	for (const int& number : numbers) {
		std::cout << number << " ";
	}
	std::cout << std::endl;
}

void TestProblem2() {
	std::vector<int> numbersFromConsole = GetNumbersFromConsole();
	Display(numbersFromConsole);

	if (IsSuperior(numbersFromConsole)) {
		std::cout << "True" << std::endl;
	}
	else {
		std::cout << "False" << std::endl;
	}
}
```

```cpp
/*
3. Se considera un vector cu nr elemente numere naturate din intervalul [30,80],
 Sa se determine si sa se afiseze elementul care apare de cele mai multe ori. (2p)
*/
```

```cpp
std::vector<int> GetNumbersFromConsoleInInterval(int lower = 30, int upper = 80) {
	std::vector<int> numbers;

	int size;
	std::cout << "size = ";
	std::string input;
	std::getline(std::cin, input);
	std::istringstream iss(input);
	iss >> size;

	bool done = false;
	while (!done) {
		std::cout << "Enter " << (size - numbers.size()) << " numbers in this interval: [" << lower << ", " << upper << "]." << std::endl;
		std::string input;
		std::getline(std::cin, input);
		std::istringstream iss(input);

		int token;
		while (iss >> token) {
			if (token >= lower && token <= upper) {
				numbers.emplace_back(token);
			}

			if (numbers.size() == size) {
				done = true;
				break;
			}
		}
	}

	return numbers;
}

int MostFrequentNumber(const std::vector<int>& numbers) {
	int max = INT_MIN;
	std::unordered_map<int, int> numberToFrequency;

	for (const int& number : numbers) {
		numberToFrequency[number]++;

		if (numberToFrequency[number] > max) {
			max = number;
		}
	}

	return max;
}

void TestProblem3() {
	std::vector<int> numbersInInterval = GetNumbersFromConsoleInInterval();
	Display(numbersInInterval);
	int mostFrequentNumber = MostFrequentNumber(numbersInInterval);
	std::cout << "Most frequent number is: " << mostFrequentNumber << std::endl;
}
```

```cpp
/*
 4. Se considera un vector V cu nr elemente numere naturate.
  Sa se construiasca un al doilea vector W, care contine fiecare element din V, care are in componenta doar cifre impare, dublicandu-le. (2p)
  Exemplu: V = [1,2,5,13,27,3,57] -> W = [1,1,5,5,13,13,3,3,57,57]
*/
```

```cpp
bool AllOddDigitsIn(int number) {
	while (number) {
		int digit = number % 10;

		if (digit % 2 == 0) {
			return false;
		}

		number /= 10;
	}

	return true;
}

std::vector<int> DuplicateAllOddDigitNumbersFrom(const std::vector<int>& numbers) {
	std::vector<int> allOddDigits;

	for (const int& number : numbers) {
		if (AllOddDigitsIn(number)) {
			allOddDigits.emplace_back(number);
			allOddDigits.emplace_back(number);
		}
	}

	return allOddDigits;
}

void TestProblem4() {
	std::vector<int> naturalNumbers = GetNumbersFromConsole();
	Display(naturalNumbers);

	std::vector<int> allOddDigitsNumbers = DuplicateAllOddDigitNumbersFrom(naturalNumbers);
	Display(allOddDigitsNumbers);
}
```

```cpp
/*
5. Un numar de baza b este retinut intr-un std:pair<int, int> ce contine valoarea si baza de numeratie in care acesta este reprezentat.
  Se citesc mai multe astfel de numere reprezentate in baze diferite.
  Sa se determine perechile de valori egale. (3p)
*/
```

```cpp
bool IsValidNumberBasePair(std::pair<int, int> pair) {
	if (pair.second <= 0 || pair.second > 10) {
		return false;
	}

	while (pair.first) {
		if (pair.first % 10 >= pair.second) {
			return false;
		}
		pair.first /= 10;
	}

	return true;
}

std::vector<std::pair<int, int>> GetBasePairNumbersFromConsole() {
	std::vector<std::pair<int, int>> pairs;
	int size = 0;

	while (size == 0) {
		int tempSize = 0;
		std::string input;

		std::cout << "input = ";
		std::getline(std::cin, input);

		std::istringstream iss(input);
		iss >> tempSize;

		if (iss && tempSize > 0) {
			size = tempSize;
		}
		else {
			std::cout << "The size must be a positive number." << std::endl;
		}
		std::cout << std::endl;
	}

	for (int i = 0; i < size;) {
		std::string input;
		std::pair<int, int> tempPair;

		std::cout << "Enter " << size << " number of pairs." << std::endl;
		std::cout << "pair " << (i + 1) << ": ";
		std::getline(std::cin, input);
		std::istringstream iss(input);

		iss >> tempPair.first >> tempPair.second;

		if (iss && IsValidNumberBasePair(tempPair)) {
			pairs.emplace_back(tempPair);
			i++;
		}
		else {
			std::cout << "Each number-base pair must have integer numbers separated by spaces. Base value must be between [1, 10]." << std::endl;
		}
		std::cout << std::endl;
	}

	return pairs;
}

int Base10(std::pair<int, int> pair) {

	if (pair.second == 10) {
		return pair.first;
	}

	int value = 0;
	int exp = 0;

	while (pair.first) {
		value += pair.first % 10 * std::pow(pair.second, exp);
		pair.first /= 10;
		exp++;
	}

	return value;
}

std::unordered_map<int, std::vector<std::pair<int, int>>> EqualValueNumbersFrom(const std::vector<std::pair<int, int>>& basePairNumbers) {
	std::unordered_map<int, std::vector<std::pair<int, int>>> baseToEqualValues;

	for (const std::pair<int, int>& pair : basePairNumbers) {

		baseToEqualValues[Base10(pair)].emplace_back(pair);
	}

	return baseToEqualValues;
}

void Display(std::unordered_map<int, std::vector<std::pair<int, int>>> dictionary) {
	std::cout << "Dictionary: " << std::endl;
	for (const std::pair<int, std::vector<std::pair<int, int>>>& kv : dictionary) {
		std::cout << kv.first << " = [ ";
		for (const std::pair<int, int>& pair : kv.second) {
			std::cout << '{' << pair.first << ", " << pair.second << '}';
		}
		std::cout << " ]" << std::endl;
	}
}

void TestProblem5() {
	std::vector<std::pair<int, int>> numberBasePairs = GetBasePairNumbersFromConsole();
	std::unordered_map<int, std::vector<std::pair<int, int>>> equalValues = EqualValueNumbersFrom(numberBasePairs);
	Display(equalValues);
}

```

```cpp

/*
6. Se considera un vector de n puncte. Fiecare punct este un element de tipul
unei structuri cu doua câmpuri, reprezentand coordonatele spatiale (x, y). Sa
se afişeze perechile de 4 puncte care pot forma un dreptunghi. Daca nu exista
astfel de pereche se va afisa un mesaj corespunzator. (3p)
*/
```

```cpp
struct Point {
	int X;
	int Y;

	Point() : X(0), Y(0) {}

	Point(int x, int y) : X(x), Y(y) {}

	friend bool operator<(const Point& lhs, const Point& rhs) {
		return lhs.X == rhs.X ? lhs.Y < rhs.Y : lhs.X < rhs.X;
	}

	friend bool operator>(const Point& lhs, const Point& rhs) {
		return lhs.X == rhs.X ? lhs.Y > rhs.Y : lhs.X > rhs.X;
	}

	friend bool operator==(const Point& lhs, const Point& rhs) {
		return lhs.X == rhs.X && lhs.Y == rhs.Y;
	}

	friend bool operator!=(const Point& lhs, const Point& rhs) {
		return !(lhs == rhs);
	}

	friend std::ostream& operator<<(std::ostream& lhs, const Point& rhs) {
		return lhs << "{ " << rhs.X << ", " << rhs.Y << " }";
	}
};

struct Side {
	Point A;
	Point B;
	double Slope;
	double Length;

	Side(Point a0, Point b0) : A(a0), B(b0) {
		int dy = A.Y - B.Y;
		int dx = A.X - B.X;

		if (A == B || dx == 0) {
			Slope = -INFINITY;
			Length = dy;
			return;
		}

		Slope = static_cast<double>(dy) / dx;
		Length = sqrt(dx * dx + dy * dy);
	}

	friend bool operator==(const Side& lhs, const Side& rhs) {
		return (lhs.A == rhs.A && lhs.B == rhs.B) || (lhs.A == rhs.B && lhs.B == rhs.A);
	}

	friend bool operator!=(const Side& lhs, const Side& rhs) {
		return !(lhs == rhs);
	}

};

struct Rectangle {
	Point A;
	Point B;
	Point C;
	Point D;

	Rectangle(const Point& a, const Point& b, const Point& c, const Point& d) {
		std::vector<Point> verts = { a, b, c, d };
		std::sort(verts.begin(), verts.end());
		A = verts[0];
		B = verts[1];
		C = verts[2];
		D = verts[3];
	}

	friend bool operator==(const Rectangle& lhs, const Rectangle& rhs) {
		return lhs.A == rhs.A && lhs.B == rhs.B && lhs.C == rhs.C && lhs.D == rhs.D;
	}
};

std::vector<Point> GetPointsFromFile(std::string path) {
	std::vector<Point> points;

	std::ifstream fin(path);
	if (!fin.is_open()) {
		std::clog << "[W] Could not open file from path " << path << std::endl;
		return {};
	}

	while (fin) {
		int x;
		int y;
		std::string line;
		std::getline(fin, line);
		std::istringstream iss(line);
		iss >> x >> y;

		if (iss) {
			Point point(x, y);
			points.emplace_back(point);
		}
	}

	return points;
}

void Display(const std::vector<Rectangle>& rects) {
	std::cout << "Rectangles: {\n";
	for (const Rectangle& rect : rects) {
		std::cout << "  " << rect.A << ", " << rect.B << ", " << rect.D << ", " << rect.C << '\n';
	}
	std::cout << "}" << std::endl;
}

bool ExistsInVector(const Rectangle& rect, const std::vector<Rectangle>& rectangles) {
	for (const Rectangle& r : rectangles) {
		if (r == rect) {
			return true;
		}
	}

	return false;
}

std::vector<Rectangle> RectanglesFromPoints(const std::vector<Point>& points) {

	std::vector<Side> sides;
	for (int i = 0; i < points.size() - 1; i++) {
		for (int j = 1; j < points.size(); j++) {

			if (points[i] == points[j] || (points[i].X - points[j].X) == 0) {
				continue;
			}

			Side side(points[i], points[j]);
			sides.emplace_back(side);
		}
	}

	std::vector<Rectangle> rectangles;

	for (int i = 0, j = i + 1; i < sides.size() - 1; i++) {
		for (int j = 0; j < sides.size(); j++) {
			if (sides[i] == sides[j]) {
				continue;
			}

			if (sides[i].Slope != sides[j].Slope || sides[i].Length != sides[j].Length) {
				continue;
			}

			Rectangle rect(sides[i].A, sides[i].B, sides[j].A, sides[j].B);

			auto pos = std::find(rectangles.begin(), rectangles.end(), rect);

			if (pos != rectangles.end()) {
				continue;
			}

			rectangles.emplace_back(rect);
		}
	}

	return rectangles;
}

void TestProblem6() {
	std::vector<Point> points = GetPointsFromFile("points.txt");
	std::vector<Rectangle> rectangles = RectanglesFromPoints(points);
	Display(rectangles);
}
```

```cpp
/*
7. Se considera o structura fractie, cu campurile de tip int numarator si numitor.
Aceasta structura dispune de o metoda reductie, care reduce fractia (ex: 12/30
devine 2/5), de functii pentru operatii aritmetice, de functii de comparare. De
asemenea o functie de transformare in numar zecimal (ex: 2/5 = 0.4). Sa se se
citeasca un vector de fractii. Fiecare dintre acestea sa se reduca. Sa se sorteze
vectorul cat mai eficient si sa se calculeze suma elementelor sale. Scrieti functii
de citire/ afisare pentru fractii. Punctajul maxim se acorda pentru rezolvarea
completa, eleganta si eficienta. (4p)

*/
```

```cpp
struct Fraction {
	int nr;
	int denum;

	Fraction() : nr(0), denum(1) {}

	Fraction(int n, int d) : nr(n), denum(d) {}

	void Reduce() {
		int div = _gcd(nr, denum);

		if (div) {
			nr /= div;
			denum /= div;
		}
	}

	float ToDecimal() const {
		return static_cast<float>(nr) / denum;
	}

	Fraction operator++() {
		nr = nr + denum;
		return *this;
	}

	Fraction operator--() {
		nr = nr - denum;
		return *this;
	}

	Fraction operator+(const Fraction& rhs) {
		nr = nr * rhs.denum + rhs.nr * denum;
		denum = denum * rhs.denum;
		return *this;
	}

	Fraction operator-(const Fraction& rhs) {
		nr = nr * rhs.denum - rhs.nr * denum;
		denum = denum * rhs.denum;
		return *this;
	}

	Fraction operator*(const Fraction& rhs) {
		nr = nr * rhs.denum;
		denum = denum * rhs.denum;
		return *this;
	}

	Fraction operator/(const Fraction& rhs) {
		nr = nr * rhs.denum;
		denum = denum * nr;
		return *this;
	}

	Fraction operator+(int x) {
		nr = nr + denum * x;
		return *this;
	}

	Fraction operator-(int x) {
		nr = nr - denum * x;
		return *this;
	}

	Fraction operator*(int x) {
		nr = nr * x;
		return *this;
	}

	Fraction operator/(int x) {
		nr = denum * x;
		denum = nr * x;
		return *this;
	}

	bool operator==(const Fraction& rhs) const {
		return nr * rhs.denum == denum * rhs.nr;
	}

	bool operator!=(const Fraction& rhs) const {
		return !(nr * rhs.denum == denum * rhs.nr);
	}

	bool operator<(const Fraction& rhs) const {
		Fraction frac(nr, denum);
		frac = frac - rhs;
		return frac.nr * frac.denum < 0;
	}

	bool operator >(const Fraction& rhs) const {
		Fraction frac(nr, denum);
		frac = frac - rhs;
		return frac.nr * frac.denum > 0;
	}

	bool operator<=(const Fraction& rhs) const {
		Fraction frac(nr, denum);
		frac = frac - rhs;
		return frac.nr * frac.denum <= 0;
	}

	bool operator>=(const Fraction& rhs) const {
		Fraction frac(nr, denum);
		frac = frac - rhs;
		return frac.nr * frac.denum >= 0;
	}

	friend Fraction operator+(int x, const Fraction& rhs) {
		Fraction frac;
		frac.nr = rhs.nr + rhs.denum * x;
		frac.denum = rhs.denum;
		return frac;
	}

	friend Fraction operator-(int x, const Fraction& rhs) {
		Fraction frac;
		frac.nr = rhs.nr - rhs.denum * x;
		frac.denum = rhs.denum;
		return frac;
	}

	friend Fraction operator*(int x, const Fraction& rhs) {
		Fraction frac;
		frac.nr = rhs.nr * x;
		frac.denum = rhs.denum;
		return frac;
	}

	friend Fraction operator/(int x, const Fraction& rhs) {
		Fraction frac;
		frac.nr = rhs.denum * x;
		frac.denum = rhs.nr * x;
		return frac;
	}

	friend std::ostream& operator <<(std::ostream& fl, const Fraction& rhs) {
		if (rhs.nr == 0) {
			return fl << 0;
		}

		if (rhs.denum == 1) {
			return fl << rhs.nr;
		}

		return fl << rhs.nr << "/" << rhs.denum;
	}

	friend std::istream& operator>>(std::istream& is, Fraction& rhs) {
		return is >> rhs.nr >> rhs.denum;
	}


private:
	int _gcd(int nr, int num) {
		int rest;

		for (; num; rest = nr % num, nr = num, num = rest);

		return nr;
	}
}; // Fraction

void ReduceAll(std::vector<Fraction> fractions) {
	for (Fraction frac : fractions) {
		frac.Reduce();
	}
}

float SumAll(const std::vector<Fraction>& fractions) {
	float sum = 0.0f;

	for (const Fraction& frac : fractions) {
		sum += frac.ToDecimal();
	}

	return sum;
}

void TestProblem7() {
	std::vector<Fraction> fractions{ {7,9}, {21,27}, {14,18}, {69696, 136}, {8,9},{5,1},{2,7}, {1,4},{1,5},{1,6},{8,7},{10,1},{5,1},{64,72},{8,9} };

	ReduceAll(fractions);

	std::sort(fractions.begin(), fractions.end(), [](const Fraction& f1, const Fraction& f2) {
		return f1.ToDecimal() < f2.ToDecimal();
		});

	std::cout << "Sum: " << SumAll(fractions) << std::endl;
}
```

```cpp
/*
8. Se considera o matrice matr cu nrows linii si ncols coloane, cu ncols < 10, ale
carei elemente sunt numere naturale formate dintr-o singura cifra. Se considera
ca fiecare coloana col reprezinta un numar in baza col+2. Sa se scrie o functie
care plaseaza numerele transformate in baza zece intr-un vector numbers si
returneaza true, daca matricea a fost valid si false altfel. In cazul in care
matricea a fost valida sa se afiseze acest vector de numere. Matricea este valid
daca toate elementele de pe coloana col sunt numere naturale din intervalul
[0, col + 1).
Exemplu: Se considera matricea

1 1 1
1 2 0
0 0 3
1 2 0
0 0 1

Atunci numbers = {26, 141, 305}.
*/
```

```cpp
class MatrixNxM {
	const int MIN_BASE = 2;

public:
	MatrixNxM();

	MatrixNxM(std::vector<std::vector<int>> vec);

	bool IsValid();

	void Print();

	void PrintBase10Values();

private:
	void InitializeBase10Values();

private:
	int _rows;
	int _cols;
	std::vector<std::vector<int>> _data;
	std::vector<int> _base10Values;

};

MatrixNxM::MatrixNxM() : _rows(0), _cols(0), _data(std::vector<std::vector<int>>()), _base10Values(std::vector<int>()) {}

MatrixNxM::MatrixNxM(std::vector<std::vector<int>> v) : _rows(v.size()), _cols(v[0].size()), _data(v) {
	InitializeBase10Values();
}

bool MatrixNxM::IsValid() {
	for (int j = 0; j < _cols; j++) {
		for (int i = 0; i < _rows; i++) {
			if (_data[i][j] >= j + MIN_BASE) {
				return false;
			}
		}
	}
	return true;
}

void MatrixNxM::Print() {
	for (const std::vector<int>& row : _data) {
		for (const int& val : row) {
			std::cout << val << ' ';
		}
		std::cout << std::endl;
	}
}

void MatrixNxM::PrintBase10Values() {
	for (const int& val : _base10Values) {
		std::cout << val << ' ';
	}
	std::cout << std::endl;
}

void MatrixNxM::InitializeBase10Values() {
	for (int col = 0; col < _cols; col++) {
		int base10Val = 0;
		int targetBase = col + MIN_BASE;
		for (int row = 0, exp = _rows - 1; row < _rows; row++, exp--) {
			if (_data[row][col] >= targetBase) {
				base10Val = 0;
				break;
			}
			base10Val += _data[row][col] * static_cast<int>(pow(targetBase, exp));
		}
		_base10Values.emplace_back(base10Val);
	}
}

MatrixNxM GetMatrixFromFile(std::string path) {
	std::ifstream fin(path);

	if (fin.is_open() == false) {
		return {};
	}

	std::vector<std::vector<int>> matrix;

	while (fin) {
		std::vector<int> row;

		std::string line;
		std::getline(fin, line);
		std::istringstream iss(line);

		int x;
		while (iss >> x) {
			row.emplace_back(x);
		}

		if (!row.empty()) {
			matrix.emplace_back(row);
		}
	}

	return MatrixNxM(matrix);
}

void TestProblem8() {
	MatrixNxM mat = GetMatrixFromFile("matrix.txt");

	mat.Print();
	mat.IsValid();
	mat.PrintBase10Values();
}

int main() {
	
}
```

```cpp
/*
9. Se citesc dintr-un fisier un numar de elevi
Fiecare elev are:
1. nume -> string
2. prenume -> string
3. 3 note (numere naturale) -> int

Se va folosi pentru un elev un tuple cu campurile nume, prenume de tip string si 3 campuri de note de tip int
Elevii vor fi memorati intr-un obiect de tip std::vector<std::tuple<std::string, std::string, int, int, int>>
Sa se sorteze vectorul de elevi descrescator dupa medie
Se vor afisa punand in evidenta elevii cu note mai mici decat 5. (2p)
*/
```

```cpp
#include <iostream>
#include <tuple>
#include <vector>
#include <fstream>

typedef std::tuple<std::string, std::string, int, int, int> student_t;

int AverageGrade(const student_t& s) {
	return (std::get<2>(s) + std::get<3>(s) + std::get<4>(s)) / 3;
}

std::ostream& operator<<(std::ostream& fl, const student_t& s) {
	return fl << "|First & last name: " << std::get<0>(s) << ", " << std::get<1>(s) << '\n'
		<< "|Grades: " << std::get<2>(s) << ' ' << std::get<3>(s) << ' ' << std::get<4>(s) << '\n'
		<< "|Average grade: " << AverageGrade(s) << std::endl;
}

std::istream& operator >> (std::istream& fl, student_t& s) {
	return fl >> std::get<0>(s)
		>> std::get<1>(s)
		>> std::get<2>(s)
		>> std::get<3>(s)
		>> std::get<4>(s);
}

std::vector<student_t> GetStudentsFromFile(std::string path) {

	std::ifstream fin(path);

	if (fin.is_open()) {
		return {};
	}

	std::vector<student_t> students;

	while (fin)
	{
		student_t s{};
		fin >> s;
		students.push_back(s);
	}

	return students;
}

void SwapThem(student_t& a, student_t& b) {
	student_t temp = a;
	a = b;
	b = temp;
}

int Partition(std::vector<student_t>& students, int st, int end) {
	student_t piv = students[end];
	int pos = st - 1;

	for (int i = st; i < end; i++)
	{
		student_t curr = students[i];

		if (AverageGrade(piv) <= AverageGrade(curr))
		{
			SwapThem(students[++pos], students[i]);
		}
	}
	SwapThem(students[pos + 1], students[end]);

	return pos + 1;
}

void QuickSort(std::vector<student_t>& students, int st, int end) {
	if (st < end)
	{
		int piv = Partition(students, st, end);
		QuickSort(students, st, piv - 1);
		QuickSort(students, piv + 1, end);
	}
}

void PrintStudentsByAverageGrade(std::vector<student_t>& students) {
	QuickSort(students, 0, students.size() - 1);

	bool showedBelow5 = false;
	bool showedAbove5 = false;

	for (const student_t& student : students) {

		if (AverageGrade(student) < 5 && showedBelow5 == false) {
			std::cout << "+-------------------------------------------+" << std::endl;
			std::cout << "+--------------- Medii sub 5 ---------------+" << std::endl;
			showedBelow5 = true;
		}

		if (AverageGrade(student) > 5 && showedAbove5 == false) {
			std::cout << "+-------------------------------------------+" << std::endl;
			std::cout << "+-------------- Medii peste 5 --------------+" << std::endl;
			showedAbove5 = true;
		}

		std::cout << student << std::endl;
	}
}

int TestProblem9()
{
	std::vector<student_t> students = GetStudentsFromFile("Students.txt");
	PrintStudentsByAverageGrade(students);
}
```