# Dynamic Allocations

```cpp
// Problema 1
// Utilizand alocarea dinamica de memorie, sa se declare si sa se citeasca de la tastatura un vector cu n elemente (n citit de la tastatura).
// Sa se insereze in acest vector intre fiecare 2 elemente media aritmetica a acestora. Folositi realocare memorie.
// Exemplu: n = 6 si vec = {4,2,6,5,3,2} 
// Rezultat: vec = {4,3,2,4,6,5.5,5,4,3,2.5,2}

// Problema 2
// Utilizand alocarea dinamica de memorie, sa se declare si sa se construiasca o matrice triunghi cu n-linii (n citit de la tastatura) si un numar de coloane egal cu ordinea liniei
// Ex: prima linie va contine o coloana, a doua linie va contine doua coloane etc.
// Sirul este crescator, primul termen al sirului este egal cu indicele liniei
// Orice doi termeni consecutivi ai sirului sunt consecutivi ca valoare
// Afisati in consola matricea rezultat si eliberati memoria utilizata la finalul aplicatiei
/* Exemplu: n = 5
Rezultat:
0
1 2
2 3 4
3 4 5 6
4 5 6 7 8
*/

#include <iostream>

void CitesteVector(float* vec, int& n);
void AfiseazaVector(float* vec, int& n);

float* InsereazaIntreFiecareElemente(float* vecTemp, int& n);

void Problema1();
void Problema2();

int main()
{
	Problema1();
	Problema2();
}

void Problema1()
{
	int n;
	std::cout << "n = ";
	std::cin >> n;
	float* vec = new float[n];
	CitesteVector(vec, n);
	vec = InsereazaIntreFiecareElemente(vec, n);
	AfiseazaVector(vec, n);
	delete[] vec;
}

void Problema2()
{
	int n;
	std::cout << "n = ";
	std::cin >> n;
	int** mat = new int* [n];

	for (int i = 0; i < n; i++)
	{
		mat[i] = new int[n];
		for (int j = 0; j <= i; j++)
		{
			mat[i][j] = i + j;
			std::cout << mat[i][j] << " ";
		}
		std::cout << std::endl;
	}

	for (int i = 0; i < n; i++)
	{
		delete[] mat[i];
	}

	delete[] mat;
}

void CitesteVector(float* vec, int& n)
{
	for (int i = 0; i < n; i++)
	{
		std::cin >> vec[i];
	}
}

void AfiseazaVector(float* vec, int& n)
{
	for (int i = 0; i < n; i++)
	{
		std::cout << vec[i] << " ";
	}
	std::cout << std::endl;
}

float* InsereazaIntreFiecareElemente(float* vecTemp, int& n)
{
	int m = 2 * n - 1;
	float* vec = new float[m];

	for (int i = 0, j = 0; i < m && j < n; i++)
	{
		if (i % 2 == 0)
		{
			vec[i] = vecTemp[j];
			j++;
		}
		else
		{
			vec[i] = (vecTemp[j], vecTemp[j - 1]);
		}
	}
	n = m;
	delete[] vecTemp;

	return vec;
}
```