# Vector Operations

1.  Se citeste un numar natural n si cele n elemente ale vectorului
 Sa se inlocuiasca elementele de pe pozitii pare cu cea mai mica cifra din numar
 iar cele de pe pozitii impare 
 cu 0 daca numarul e prim
 cu 1 altfel


```cpp
void ReadVector(std::vector<int>& vec)
{
    int n;
    std::cout << "Please input a natural number.\nn = ";
    std::cin >> n;

    vec.resize(n);

    for (int i = 0; i < vec.size(); i++)
    {
        std::cin >> vec[i];
    }
}

void PrintVector(std::vector<int>& vec)
{
    for (int i = 0; i < vec.size(); i++)
    {
        std::cout << vec[i] << " ";
    }

    std::cout << std::endl;
}

bool IsPrime(int x)
{
	if (x < 0 || x % 2 == 0) 
    {
		return false;
	}

	if (x >= 1 && x <= 3) 
    {
		return true;
	}

	for (int i = 3; i * i <= x; i += 2) 
    {
		if (x % i == 0) 
        {
			return false;
		}
	}

	return true;
}

int MinDigit(int x)
{
    int min = x % 10;
    x /= 10;
    while (x != 0)
    {
        if (min > x % 10)
        {
            min = x % 10;
        }
        x /= 10;
    }
    return min;
}

void ReplaceElements(std::vector<int>& vec)
{
    for (int i = 0; i < vec.size(); i++)
    {
        if (i % 2 == 0)
        {
            vec[i] = MinDigit(vec[i]);
        }
        else
        {
            IsPrime(vec[i]) ? vec[i] = 0 : vec[i] = 1;
        }
    }
}
```

2. Se citeste un numar natural n si cele n elemente ale unui vector
Sa se stearga din vector acele elemente care sunt egale cu suma vecinilor sai.

```cpp
bool TargetEqualsNeighborsSum(std::vector<int>& vec, int target, int start)
{
    return target == (vec[start - 1] + vec[start + 1]);
}

void EraseElements(std::vector<int>& vec)
{
    int start = 1;

    while (start != vec.size() - 1 )
    {
        int target = vec[start];
        if (TargetEqualsNeighborsSum(vec, target, start))
        {
            vec.erase(vec.begin() + start);
            PrintVector(vec);
            start--;
        }
        else
        {
            start++;
        }

        if (start == 0)
        {
            start = 1;
        }
    }
}
```

3. Se citeste un numar natural n si cele n elemente alea unui vector.
 Sa se insereze in vector intre oricare doua valori vecine suma si produsul acestora
 Obs: Determinarea sumei si a produsului a doua numere se va realiza in cadrul unei singure functii

```cpp
std::pair<int, int> SumAndProduct(int a, int b)
{
	std::pair<int, int> p;
	p.first = a + b;
	p.second = a * b;
	return p;
}

int ValidPosition(std::vector<int>& vec)
{
	int poz;

	do {
		std::cout << "Introduceti un numar natural mai mic ca " << vec.size() - 1 << ".\npoz = ";
		std::cin >> poz;

		if (poz < 0 || poz >= vec.size() - 1)
		{
			std::cout << "Error: Index invalid." << std::endl;
		}
	} while (poz < 0 || poz >= vec.size() - 1);

	return poz;
}

void InsertPair(std::vector<int>& vec)
{
	int poz = ValidPosition(vec);
	int sum = SumAndProduct(vec[poz], vec[poz + 1]).first;
	int prod = SumAndProduct(vec[poz], vec[poz + 1]).second;

	std::cout << "Am inserat intre " << vec[poz] << " si " << vec[poz + 1] << ", suma = " << sum << " si produsul = " << prod << std::endl;

	vec.insert(vec.begin() + poz + 1, { sum, prod });
}
```

4.  Se citesc doua numere naturale n si k, si cele n elemente ale unui vector
Sa se deplaseze spre dreapta elementele vectorilor cu k-pozitii
Primele k elemente ale vectorului vor fi zero-izate iar dimensiunea vectorului va creste cu k elemente
EX: v = [1,2,3,4,5,6,7], k = 3, afisare: [0,0,0,1,2,3,4,5,6,7] inlocuieste cu ultimele k elemente din vector astfel dimensiunea vectorului nu va suferi modificari
EX: v = [1,2,3,4,5,6,7], k = 3, afisare: [5,6,7,1,2,3,4]

```cpp
int ReadPosition()
{
	int k;

	std::cout << "Introduceti un numar natural.\nk = ";
	std::cin >> k;

	return k;
}

void ShiftRight(std::vector<int>& vec)
{
	int k = ReadPosition();

	vec.resize(vec.size() + k);

	for (int i = 0; i < k; i++)
	{
		vec.insert(vec.begin(), 0);
		vec.pop_back();
	}
}

void CycleRight(std::vector<int>& vec)
{
	int k = ReadPosition();
	int poz = vec.size() - 1;

	if (k >= vec.size())
	{
		k = k % vec.size();
	}

	for (int i = 0; i < k; i++)
	{
		vec.insert(vec.begin(), vec[poz]);
		vec.pop_back();
	}
}
```

5. Se da un vector v cu n elemente.
 Sa se elimine din vector elementul cu indicele de pozitie p (citit de la tastatura)
 iar p sa se insereze la inceputul vectorului
 Sa se afiseze noul vector
 Ex: v = 2, 51, 2, 91, 3; p = 3, afiseaza: 3, 2, 51, 2, 3

```cpp
void EraseThenInsert(std::vector<int>& vec)
{
    int p = ReadPosition();
    vec.erase(vec.begin() + p);
    vec.insert(vec.begin(), p);
}
```

6. Se citesc doua numere naturale n si m si doi vectori crescatori de lungime n, respectiv m
 Sa se creeze si sa se afiseze vectorul ordonat crescator obtinut prin reuniunea celor doi vectori
 Ex: v1 = 1,2,5,10,13,20
     v2 = 1,6,7,9,15,25
 Afisare: 1,1,2,5,6,7,9,10,13,15,20,25

```cpp
void SortedMergedVectors(std::vector<int>& vec1, std::vector<int>& vec2)
{
    vec1.insert(vec1.end(), vec2.begin(), vec2.end());
    sort(vec1.begin(), vec1.end());
}
```

7. Se citeste un numar natural n si n medii numere reale cu doua zecimale cu valori cuprinse intre 1 si 10
 Sa se afiseze o statistica a mediilor astfel:
 - numarul de medii cuprinse intre intervalul [1,2]
 - numarul de medii cuprinse intre intervalul [2,3]
 - ...
 - numarul de medii cuprinse intre intervalul [9,10]

```cpp
void PrintMedianStatistics(std::vector<float>& vec)
{
	for (int i = 1; i < 10; i++)
	{
		int count = 0;
		for (float number : vec)
		{
			if (number > i && number <= i + 1)
			{
				count++;
			}
		}
		std::cout << "In intervalul [" << i << ", " << i + 1 << "] sunt " << count << " medii." << std::endl;
	}
}
```

8. Un numar natural se retine intr-un vector (numar mare)
 astfel incat fiecare componenta a vectorului contine cate o cifra a numarului
 Sa se inmulteasca numarul cu un numar intre 1 si 9 (generat random).

```cpp
#include <ctime> 

std::vector<int> RandomElements()
{
    std::srand(std::time(0));
    int nr_random = std::rand();
    std::vector<int> vec;

    while (nr_random > 0)
    {
        vec.push_back(nr_random % 10);
        nr_random /= 10;
    }

    return vec;
}

void MultiplyElementsByRandomNumber(std::vector<int>& vec)
{
    for (int i = 0; i < vec.size(); i++)
    {
        int nr_random = (std::rand() % 9) + 1;
        std::cout << vec[i] << " * " << nr_random << " = " << vec[i] * nr_random << std::endl;
        vec[i] *= nr_random;
    }
}
```