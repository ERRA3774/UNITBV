# Template Data Structures

Stack

```cpp
#pragma once

#include <iostream>

template <class T>
class Stack {

	template<class T>
	struct Node {
		T data;
		Node<T>* next;

		Node(const T& d) : data(d), next(nullptr) {}
	};

public:
	Stack<T>();

	bool Empty() const;

	void Push(const T& value);

	const T Pop();

	void Display() const;

private:
	Node<T>* m_top;
};

template<class T>
inline Stack<T>::Stack() : m_top(nullptr) {}

template<class T>
inline bool Stack<T>::Empty() const {
	return m_top == nullptr;
}

template<class T>
inline void Stack<T>::Push(const T& value) {
	Node<T>* node = new Node<T>(value);

	if (Empty()) {
		m_top = node;
		return;
	}

	node->next = m_top;
	m_top = node;
}

template<class T>
inline const T Stack<T>::Pop() {

	if (Empty()) {
		std::clog << "Stack is empty." << std::endl;
		return T();
	}

	Node<T>* curr = m_top;
	T val = m_top->data;
	m_top = m_top->next;
	delete curr;
	std::clog << "Popped " << val << std::endl;
	return val;
}

template<class T>
inline void Stack<T>::Display() const {
	Node<T>* curr = m_top;

	std::clog << "top --> ";
	while (curr) {
		std::clog << curr->data;
		if (curr->next) {
			std::clog << ", ";
		}
		curr = curr->next;
	}
	std::clog << std::endl;
}
```

Queue

```cpp
#pragma once

#include <iostream>

template<class T>
class Queue {

	template<class T>
	struct Node {
		T data;
		Node<T>* next;

		Node(const T& d) : data(d), next(nullptr) {}
	};

public:
	Queue<T>();

	bool Empty() const;

	void Enqueue(const T& value);

	const T Dequeue();

	void Display() const;

private:
	Node<T>* m_head;
	Node<T>* m_tail;
};

template<class T>
inline Queue<T>::Queue() : m_head(nullptr), m_tail(nullptr) {}

template<class T>
inline bool Queue<T>::Empty() const {
	return m_tail == nullptr;
}

template<class T>
inline void Queue<T>::Enqueue(const T& value) {
	Node<T>* node = new Node<T>(value);

	if (Empty()) {
		m_head = m_tail = node;
		return;
	}

	m_tail->next = node;
	m_tail = node;
}

template<class T>
inline const T Queue<T>::Dequeue() {
	if (Empty()) {
		std::clog << "Queue is empty." << std::endl;
		return T();
	}

	T value = m_head->data;
	Node<T>* node = m_head;
	m_head = m_head->next;
	if (m_head == nullptr) {
		m_tail = nullptr;
	}

	delete node;
	std::clog << "Dequeued " << value << std::endl;
	return value;
}

template<class T>
inline void Queue<T>::Display() const {
	Node<T>* curr = m_head;

	std::clog << "head --> ";
	while (curr) {
		std::clog << curr->data;
		if (curr->next) {
			std::clog << ", ";
		}
		curr = curr->next;
	}
	std::clog << " <-- tail" <<std::endl;
}
```

List

```cpp
#pragma once

#include <iostream>

template<class T>
class List {

	template<class T>
	struct Node {
		T data;
		Node<T>* next;

		Node(const T& d) : data(d), next(nullptr) {}
	};

public:
	List<T>();

	void ZeroInit(const size_t& size);

	bool Empty() const;

	size_t Size() const;

	T& operator[](const size_t index);

	void PushBack(const T& value);

	void PushFront(const T& value);

	void Insert(const T& value, const size_t index);

	void Remove(const size_t index);

	void Remove(const size_t left, const size_t right);

	void Clear();

	void Display() const;

private:
	Node<T>* m_begin;
	Node<T>* m_end;
	Node<T>* m_last;
	size_t m_size;
};

template<class T>
inline List<T>::List() : m_begin(nullptr), m_end(nullptr), m_size(size_t()) {
	m_last = new Node<T>(T());
}

template<class T>
inline void List<T>::ZeroInit(const size_t& size) {
	if (size == 0) {
		return;
	}

	if (!Empty()) {
		Clear();
	}

	m_begin = m_end = new Node<T>(T());
	m_size = size;

	for (size_t i = 0; i < size - 1; i++) {
		Node<T>* node = new Node<T>(T());
		m_end->next = node;
		m_end = node;
	}
}

template<class T>
inline bool List<T>::Empty() const {
	return m_size == 0;
}

template<class T>
inline size_t List<T>::Size() const {
	return m_size;
}

template<class T>
inline T& List<T>::operator[](const size_t index) {

	if (index >= m_size) {
		std::clog << "LIST::[] >>> Index out of bounds." << std::endl;
		return m_last->data;
	}

	Node<T>* curr = m_begin;

	for (size_t i = 0; i < index; i++) {
		curr = curr->next;
	}

	return curr->data;
}

template<class T>
inline void List<T>::PushBack(const T& value) {
	Node<T>* node = new Node<T>(value);

	if (Empty()) {
		m_begin = m_end = node;
	}
	else {
		m_end->next = node;
		m_end = node;
	}

	m_size++;
}

template<class T>
inline void List<T>::PushFront(const T& value) {
	Node<T>* node = new Node<T>(value);

	if (Empty()) {
		m_begin = m_end = node;
	}
	else {
		node->next = m_begin;
		m_begin = node;
	}

	m_size++;
}

template<class T>
inline void List<T>::Insert(const T& value, const size_t index) {

	if (index > m_size) {
		std::clog << "LIST::INSERT >>> Index out of bounds." << std::endl;
		return;
	}

	Node<T>* node = new Node<T>(value);

	if (index == 0) {
		node->next = m_begin;
		m_begin = node;
	}
	else {
		Node<T>* curr = m_begin;

		for (size_t i = 0; i < index - 1; i++) {
			curr = curr->next;
		}

		node->next = curr->next;
		curr->next = node;
	}

	m_size++;
}

template<class T>
inline void List<T>::Remove(const size_t index) {

	if (index >= m_size) {
		std::clog << "LIST::REMOVE >>> Index out of bounds." << std::endl;
		return;
	}

	if (index == 0) {
		Node<T>* node = m_begin;
		m_begin = m_begin->next;
		delete node;
	}
	else {
		Node<T>* curr = m_begin;

		for (size_t i = 0; i < index - 1; i++) {
			curr = curr->next;
		}

		Node<T>* node = curr->next;
		curr->next = node->next;
		delete node;
	}

	m_size--;
}

template<class T>
inline void List<T>::Remove(const size_t left, const size_t right) {

	bool validBounds = true;

	if (left >= m_size) {
		std::clog << "LIST::REMOVE >>> Left out of bounds." << std::endl;
		validBounds = false;
	}

	if (right >= m_size) {
		std::clog << "LIST::REMOVE >>> Right out of bounds." << std::endl;
		validBounds = false;
	}

	if (right < left) {
		std::clog << "LIST::REMOVE >>> Right must be greater than Left." << std::endl;
		validBounds = false;
	}

	if (!validBounds) {
		return;
	}

	Node<T>* curr = m_begin;
	Node<T>* prev = nullptr;

	if (left > 0) {
		for (size_t i = 0; i < left - 1; i++) {
			curr = curr->next;
		}
		prev = curr;
		curr = curr->next;
	}

	std::clog << "Removed [ ";
	for (size_t i = 0; i < right - left + 1; i++) {
		std::clog << curr->data;
		if (i < right - left) {
			std::clog << ", ";
		}
		Node<T>* node = curr;
		curr = curr->next;
		delete node;
		m_size--;
	}
	std::clog << " ]" << std::endl;

	if (prev) {
		prev->next = curr;
	}
}

template<class T>
inline void List<T>::Clear() {

	if (Empty()) {
		std::clog << "List is already empty." << std::endl;
		return;
	}

	Node<T>* curr = m_begin;

	std::clog << "Cleared [ ";
	while (curr) {
		Node<T>* node = curr;
		std::clog << node->data;
		if (curr->next) {
			std::clog << ", ";
		}
		curr = curr->next;
		delete node;
	}
	std::clog << " ]" << std::endl;
	m_size = 0;
}

template<class T>
inline void List<T>::Display() const {

	if (Empty()) {
		std::clog << "LIST::DISPLAY >>> List is empty." << std::endl;
		return;
	}

	Node<T>* curr = m_begin;

	std::clog << "List = [ ";
	while (curr) {
		std::clog << curr->data;
		if (curr->next) {
			std::clog << ", ";
		}
		curr = curr->next;
	}
	std::clog << " ]" << std::endl;
}
```


Hash Table

```cpp
#pragma once

#include <iostream>
#include <vector>
#include <list>
#include <functional>

template<typename K, typename V>
class HashTable {

	constexpr static size_t INIT_CAPACITY = 10;
	constexpr static float LOAD_FACTOR_THRESHOLD = 1.0f;

public:
	HashTable();

	size_t Size() const;

	size_t Buckets() const;

	void Insert(const K& key, const V& value);

	void Remove(const K& key);

	bool Exists(const K& key);

	void Display() const;

	V& operator[](const K& key);

private:
	size_t _hashFunction(const K& key);

	float _loadFactor();

	void _rehash();

private:
	std::vector<std::list<std::pair<K, V>>> m_table;
	size_t m_buckets;
	size_t m_size;
};

template<typename K, typename V>
inline HashTable<K, V>::HashTable() :
	m_table(std::vector<std::list<std::pair<K, V>>>(INIT_CAPACITY)),
	m_buckets(INIT_CAPACITY),
	m_size(NULL) {

}

template<typename K, typename V>
inline size_t HashTable<K, V>::_hashFunction(const K& key) {
	return std::hash<K>()(key) % m_buckets;
}

template<typename K, typename V>
inline float HashTable<K, V>::_loadFactor() {
	return static_cast<float>(m_size) / m_buckets;
}

template<typename K, typename V>
inline void HashTable<K, V>::_rehash() {
	m_buckets *= 2;
	std::vector<std::list<std::pair<K, V>>> tempTable(m_buckets);

	for (const std::list<std::pair<K, V>>& bucket : m_table) {
		for (const std::pair<K, V>& kv : bucket) {
			tempTable[_hashFunction(kv.first)].emplace_back(kv.first, kv.second);
		}
	}

	m_table = tempTable;
}

template<typename K, typename V>
inline size_t HashTable<K, V>::Size() const {
	return m_size;
}

template<typename K, typename V>
inline size_t HashTable<K, V>::Buckets() const {
	return m_buckets;
}

template<typename K, typename V>
inline void HashTable<K, V>::Insert(const K& key, const V& value) {

	if (_loadFactor() >= LOAD_FACTOR_THRESHOLD) {
		_rehash();
	}

	size_t hashValue = _hashFunction(key);
	std::list<std::pair<K, V>>& cell = m_table[hashValue];

	for (std::pair<K, V>& kv : cell) {
		if (kv.first == key) {
			kv.second = value;
			return;
		}
	}

	cell.emplace_back(std::pair<K, V>(key, value));
	m_size++;
}

template<typename K, typename V>
inline void HashTable<K, V>::Remove(const K& key) {
	size_t hashValue = _hashFunction(key);
	std::list<std::pair<K, V>>& cell = m_table[hashValue];

	for (std::pair<K, V>& kv : cell) {
		if (kv.first == key) {
			cell.remove(kv);
			m_size--;
			return;
		}
	}

	std::cout << "Key " << key << " not found " << std::endl;
}

template<typename K, typename V>
inline bool HashTable<K, V>::Exists(const K& key) {
	size_t hashValue = _hashFunction(key);
	std::list<std::pair<K, V>>& cell = m_table[hashValue];

	for (std::pair<K, V>& kv : cell) {
		if (kv.first == key) {
			return true;
		}
	}

	return false;
}

template<typename K, typename V>
inline void HashTable<K, V>::Display() const {
	std::cout << "Hash Table: [" << std::endl;
	for (size_t index = 0; index < m_table.size(); ++index) {
		std::cout << "Cell[" << index << "]: ";
		for (const std::pair<K, V>& kv : m_table.at(index)) {
			std::cout << "{" << kv.first << ", " << kv.second << "}";
			if (kv != m_table.at(index).back()) {
				std::cout << ", ";
			}
		}
		std::cout << std::endl;
	}
	std::cout << "]" << std::endl;
	std::cout << "Buckets: " << m_buckets << std::endl;
	std::cout << "Size: " << m_size << std::endl;
	std::cout << "Current load " << static_cast<float>(m_size) / m_buckets << std::endl;
}

template<typename K, typename V>
inline V& HashTable<K, V>::operator[](const K& key) {
	if (_loadFactor() >= LOAD_FACTOR_THRESHOLD) {
		_rehash();
	}

	size_t hashValue = _hashFunction(key);
	std::list<std::pair<K, V>>& cell = m_table[hashValue];

	for (std::pair<K, V>& kv : cell) {
		if (kv.first == key) {
			return kv.second;
		}
	}

	cell.emplace_back(std::pair<K, V>(key, V()));
	m_size++;

	return cell.back().second;
}

void HashTableTests() {
	HashTable<std::string, std::string> hashTable;

	hashTable.Insert("A", "Zero");
	hashTable.Insert("B", "One");
	hashTable.Insert("C", "Two");
	hashTable.Insert("D", "Three");
	hashTable.Insert("E", "Four");
	hashTable.Insert("F", "Five");
	hashTable.Insert("G", "Six");
	hashTable.Insert("H", "Seven");
	hashTable.Insert("I", "Eight");
	hashTable.Insert("J", "Nine");

	hashTable.Display();
	hashTable.Remove("F");
	std::cout << "Can we get an F? " << hashTable.Exists("F") << std::endl;
}
```