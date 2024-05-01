# Homework 3

```cpp
/*
1. Implementare tabela de dispersie - liste inlantuite
Construiti o clasa HashTable(sau HashMap) potrivita care sa includa operatiile: 
1. insertie
2. cautare
3. stergere
Elementele stocate vor fi de tip (cheie, valoare) -> folositi std::pair
Rezolvarea coliziunilor se va realiza prin liste inlantuite -> folositi std::list
Daca factorul de incarcare al tabelei depaseste 1.0 se cere 
1. redimensionarea tabelei (aproximativ dublul dimensiunii initiale)
2. redistribuirea elementelor in noua tabela (rehashing)
In functia main 
1. cititi dintr-un fisier n elemente de tip pereche (cheie-valoare) (n>20)
2. repartizati elementele in tabela, apoi
3. permiteti cautarea, adaugarea sau stergerea de elemente (meniu)
4. permiteti parcurgerea si afisarea perechilor <cheie, valoare> pentru toate elementele din tabela. (3p)
+.5p pentru implementarea unei functii de hashing pentru siruri de caractere
*/
```

```cpp
#pragma once

#include <iostream>
#include <list>
#include <vector>
#include <functional>

template<typename K, typename V>
class HashTable {

	constexpr static const size_t INITIAL_BUCKETS_SIZE = 10;
	constexpr static const float  LOAD_FACTOR_THRESHOLD = 1.0f;

	using entry_t = std::pair<K, V>;
	using bucket_t = std::list<std::pair<K, V>>;
	using table_t = std::vector<std::list<std::pair<K, V>>>;

public:

	HashTable();

	size_t Keys() const;

	size_t Buckets() const;

	float Load() const;

	bool Empty() const;

	bool Exists(const K& key) const;

	const typename bucket_t::iterator Find(const K& key);

	void Insert(const K& key, const V& value);

	void Remove(const K& key);

	void Display() const;

	V& operator[](const K& key);

private:
	const float _loadFactor();

	size_t _hash(const K& key);

	void _rehash();

private:
	table_t m_table;
	size_t m_buckets;
	size_t m_keys;
};

template<typename K, typename V>
inline HashTable<K, V>::HashTable() :
	m_table(table_t(INITIAL_BUCKETS_SIZE)),
	m_buckets(INITIAL_BUCKETS_SIZE),
	m_keys(0) {

}

template<typename K, typename V>
inline size_t HashTable<K, V>::Keys() const {
	return m_keys;
}

template<typename K, typename V>
inline size_t HashTable<K, V>::Buckets() const {
	return m_buckets;
}

template<typename K, typename V>
inline float HashTable<K, V>::Load() const {
	return static_cast<float>(m_keys) / m_buckets;
}

template<typename K, typename V>
inline const float HashTable<K, V>::_loadFactor() {
	return static_cast<float>(m_keys) / m_buckets;
}

template<typename K, typename V>
inline size_t HashTable<K, V>::_hash(const K& key) {
	return std::hash<K>()(key) % m_buckets;
}

template<typename K, typename V>
inline void HashTable<K, V>::_rehash() {
	m_buckets *= 2;
	table_t temp = table_t(m_buckets);

	for (const bucket_t& bucket : m_table) {
		for (const entry_t& entry : bucket) {
			bucket_t& cell = temp[_hash(entry.first)];
			cell.emplace_back(entry);
		}
	}

	m_table = temp;
}

template<typename K, typename V>
inline bool HashTable<K, V>::Empty() const {
	return m_keys == 0;
}

template<typename K, typename V>
inline bool HashTable<K, V>::Exists(const K& key) const {
	bucket_t& cell = m_table[_hash(key)];

	for (entry_t& entry : cell) {
		if (entry.first == key) {
			return true;
		}
	}

	return false;
}

template<typename K, typename V>
inline const typename HashTable<K,V>::bucket_t::iterator HashTable<K, V>::Find(const K& key) {
	bucket_t& cell = m_table[_hash(key)];

	for (typename bucket_t::iterator it = cell.begin(); it != cell.end(); ++it) {
		if (it->first == key) {
			return it;
		}
	}

	return cell.end();
}

template<typename K, typename V>
inline void HashTable<K, V>::Insert(const K& key, const V& value) {
	if (_loadFactor() >= LOAD_FACTOR_THRESHOLD) {
		_rehash();
	}

	bucket_t& cell = m_table[_hash(key)];
	for (entry_t& entry : cell) {
		if (entry.first == key) {
			entry.second = value;
			return;
		}
	}

	cell.emplace_back(entry_t(key, value));
	m_keys++;
}

template<typename K, typename V>
inline void HashTable<K, V>::Remove(const K& key) {
	bucket_t& cell = m_table[_hash(key)];

	for (entry_t& entry : cell) {
		if (entry.first == key) {
			cell.remove(entry);
			return;
		}
	}
}

template<typename K, typename V>
inline void HashTable<K, V>::Display() const {
	std::cout <<
		"Current load: " << Load() << '\n' <<
		"Number of keys: " << Keys() << '\n' <<
		"Number of buckets: " << Buckets() << '\n' << 
		"Hash Table data: [\n";

	size_t index = 0;
	for (const bucket_t& bucket : m_table) {
		std::cout << "Cell[" << index++ << "]: ";
		for (const entry_t& entry : bucket) {
			std::cout << "{" << entry.first << ", " << entry.second << "}";
			if (entry != bucket.back()) {
				std::cout << ", ";
			}
		}
		std::cout << '\n';
	}
	std::cout << "] " << std::endl;
}

template<typename K, typename V>
inline V& HashTable<K, V>::operator[](const K& key) {
	bucket_t& cell = m_table[_hash(key)];

	for (entry_t& entry : cell) {
		if (entry.first == key) {
			return entry.second;
		}
	}

	cell.emplace_back(entry_t(key, V()));
	m_keys++;
	return cell.back().second;
}
```

```cpp
/*
2. Se considera doua siruri de caractere citite din fisier
Sa se scrie o functie care are ca parametri cele doua siruri si care returneaza true daca al doilea este o permutare a primului si false altfel
Implementati folosind unordered_set
*/
```

```cpp
#include <iostream>
#include <unordered_set>
#include <string>
#include <fstream>
#include <list>

std::vector<std::string> GetListFromFile(const std::string& path) {
	std::ifstream fin(path);

	if (!fin.is_open())
	{
		std::cout << "[E] Could not open file" << std::endl;
		return {};
	}

	std::vector<std::string> vec;

	while (!fin.eof())
	{
		std::string line;
		std::getline(fin, line);
		vec.emplace_back(line);
	}

	return vec;
}

bool HasEqualCharSet(std::string str1, std::string str2) {

	if (str1.length() != str2.length())
	{
		return false;
	}

	std::unordered_set<char> letters;

	for (char c : str1)
	{
		letters.insert(c);
	}

	for (char c : str2)
	{
		if (letters.find(c) == letters.end())
			return false;
	}

	return true;
}

void TestProblem2()
{
	std::vector<std::string> lines = GetListFromFile("list.txt");
	std::cout << HasEqualCharSet(lines[0], lines[1]);
}
```

```cpp
/*
5. Subsiruri de suma data
Scrie un program care:
1. citeste Nr elemente numere narutare dintr-un fisier
2. le plaseaza intr-un vector Numere
Avand acest vector, se permit oricate citiri a unei valor k (intr-un do-while)
Pentru fiecare k se afisaza toate perechile de indici (start, stop (start <= stop) pentru care subsirul Numere[start] + Numere[start + 1] + ... + Numere[stop] = k;
Rezolvati problema in mod eficient, folosind unordered_map (1.5p)
*/
```

```cpp
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <unordered_map>
#include <vector>
#include "conio.h"

std::vector<int> numbersFromFile(std::string path);
std::vector<std::pair<int, int>> indexesSubarraysEqualTarget(std::vector<int> vec, int target);
std::string toString(std::vector<std::pair<int, int>> vec);

int TestProblem5()
{
	std::vector<int> vec = numbersFromFile("problem5.txt");
	std::cout << "Press ESC to exit." << std::endl;
	int target = 0;

	do 
	{
		std::string input = "";
		std::cout << "<target> ";
		std::getline(std::cin, input);
		std::istringstream(input) >> target;
		std::cout << toString(indexesSubarraysEqualTarget(vec, target)) << std::endl;
	} while (_getch() != 27);
	return 0;
}

std::vector<int> numbersFromFile(std::string path)
{
	std::ifstream fin(path);
	if (!fin.is_open())
	{
		std::cout << "Could not open file." << std::endl;
		exit(1);
	}

	std::vector<int> vec;
	while (!fin.eof())
	{
		int a;
		fin >> a;
		vec.emplace_back(a);
	}

	fin.close();

	return vec;
}

std::vector<std::pair<int,int>> indexesSubarraysEqualTarget(std::vector<int> vec, int target)
{
	if (vec.size() == 0)
	{
		std::cout << "[I] The vector is empty" << std::endl;
		return { {-1,-1} };
	}

	std::vector<std::pair<int, int>> indexes;
	std::unordered_map<int, int> map;
	int runningSum = 0;
	int start = 0;
	int stop = 0;

	for (int i = 0; i < vec.size(); i++)
	{
		runningSum += vec[i];

		if (runningSum == target)
		{
			stop = i;
			indexes.emplace_back(std::make_pair(start, stop));
		}

		if (map.find(runningSum - target) != map.end())
		{
			start = map[runningSum - target] + 1;
			stop = i;
			indexes.emplace_back(std::make_pair(start, stop));
		}

		map[runningSum] = i;
	}

	return indexes;
}

std::string toString(std::vector<std::pair<int,int>> vec)
{
	if (vec.empty())
	{
		return "[I] The vector is empty.\n";
	}

	std::string s = "[";

	for (auto& p : vec)
	{
		s += "{" + std::to_string(p.first) + "," + std::to_string(p.second) + "}";
	}
	s += "]";

	return s;
}
```

```cpp
/*
6. Suma nula:
Se considera 4 vectori de numere A, B, C, D de lungime cel mult 500 fiecare.
Sa se determine toate cvadruplurile de indici i, j, k, l pentru care:
A[i] + B[j] + C[k] + D[l] = 0.
Ce complexitate are algoritmul? -> O(n^2)
Care este cea mai buna complexitate pe care o puteti obtine? -> O(n^2)
*/
```

```cpp
#include <iostream>
#include <vector>
#include <unordered_map>
#include <tuple>

constexpr int TARGET = 0;

std::vector<std::tuple<int, int, int, int>> nullSumIndexes(std::vector<int> A, std::vector<int> B, std::vector<int> C, std::vector<int> D)
{
	if (A.size() == 0 || B.size() == 0 || C.size() == 0 || D.size() == 0)
	{
		std::cout << "[I] At least one of the vectors is empty." << std::endl;
		return {};
	}

	std::vector<std::tuple<int, int, int, int>> indexes{};
	std::unordered_map<int, std::vector<std::pair<int, int>>> map{};

	for (int i = 0; i < A.size(); i++)
	{
		for (int j = 0; j < B.size(); j++)
		{
			int sum = A[i] + B[j];
			map[sum].emplace_back(std::make_pair(i, j));
		}
	}

	for (int k = 0; k < C.size(); k++)
	{
		for (int l = 0; l < D.size(); l++)
		{
			int negativeSum = -(C[k] + D[l]);
			if (map.find(negativeSum) != map.end())
			{
				int i = map[negativeSum].data()->first;
				int j = map[negativeSum].data()->second;
				indexes.emplace_back(std::make_tuple(i, j, k, l));
			}
		}
	}

	return indexes;
}

void printIndexes(std::vector<std::tuple<int, int, int, int>> vec)
{
	if (vec.empty())
	{
		std::cout << "[I] Could not find 4 indexes in input vectors that add up to 0." << std::endl;
		return;
	}

	for (auto& el : vec)
	{
		std::cout
			<< "A[" << std::get<0>(el) << "]" << " + "
			<< "B[" << std::get<1>(el) << "]" << " + "
			<< "C[" << std::get<2>(el) << "]" << " + "
			<< "D[" << std::get<3>(el) << "]" << " = "
			<< TARGET
			<< std::endl;
	}
	return;
}

int TestProblem6()
{
	std::vector<int> A{ 87,	61,	24,	83,	32,	93,	66,	81,	72,	47,	85,	45,	70,	84,	68,	74,	57,	71,	92,	93 };
	std::vector<int> B{ 66,	20,	38,	98,	96,	32,	23,	29,	82,	23,	67,	71,	75,	95,	77,	51,	89,	97,	84,	56 };
	std::vector<int> C{ -49, -23, -36, -24, -97, -66, -27, -93, -72, -81, -48, -43, -38, -37, -85, -74, -78, -92, -59, -60 };
	std::vector<int> D{ -23, -13, -25, -18, -11, -88, -66, -82, -26, -70, -35, -52, -31, -53, -83, -30, -72, -90, -69, -26 };

	std::vector<std::tuple<int, int, int, int>> indexes = nullSumIndexes(A, B, C, D);

	printIndexes(indexes);
}
```

```cpp
/*
8. Magazine
Se considera nr_mag magazine
Fiecare are un numar de produse.
Sa se verificare care magazin are cele mai multe produse exclusive (nu apar decat in magazinul respectiv).
Cititi dintr-un fisier in cate un vector de std::string produse pentru fiecare magazin.
Afisati in final magazinul cu cele mai multe produse exclusive si care sunt aceste produse.
*/
```

```cpp
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>

#define INFO(x) std::cout << "[I] " << x << std::endl;
#define ERR(x)  std::cout << "[E] " << x << std::endl;

void mapShopItemsFromFile(std::string path, std::unordered_map<std::string, std::vector<std::string>>& shopToItems, std::unordered_map<std::string, std::unordered_set<std::string>>& itemToShops)
{
	std::ifstream fin(path);

	if (!fin.is_open())
	{
		ERR("Could not open file from path. Exiting.");
		exit(1);
	}

	while (!fin.eof())
	{
		bool isDone = false;
		std::string shop;
		std::string item;
		std::getline(fin, shop);
		while (!isDone && std::getline(fin, item))
		{
			if (item != "")
			{
				shopToItems[shop].emplace_back(item);
				itemToShops[item].insert(shop);
			}
			else
			{
				isDone = true;
			}
		}
	}

	return;
}

void printShopMaxExclusiveItems(std::unordered_map<std::string, std::vector<std::string>> shopToItems, std::unordered_map<std::string, std::unordered_set<std::string>> itemToShops)
{
	int max = 0;
	std::string shopMax;
	std::unordered_map<std::string, int> exclusiveItems;

	for (auto& kv : itemToShops)
	{
		if (kv.second.size() == 1)
		{
			std::string shop = *kv.second.begin();
			exclusiveItems[shop]++;
		}
	}

	for (auto& kv : exclusiveItems)
	{
		if (kv.second > max)
		{
			max = kv.second;
			shopMax = kv.first;
		}
	}

	INFO("Shop with most exclusive items: " + shopMax);
	INFO("List of exclusive items: ");
	for (auto& kv : shopToItems[shopMax])
	{
		if (itemToShops[kv].size() == 1)
		{
			INFO(kv);
		}
	}

	return;
}

int TestProblem8()
{
	std::unordered_map<std::string, std::vector<std::string>> shopToItems;
	std::unordered_map<std::string, std::unordered_set<std::string>> itemToShops;
	mapShopItemsFromFile("Text.txt", shopToItems, itemToShops);
	printShopMaxExclusiveItems(shopToItems, itemToShops);
	return 0;
}
```