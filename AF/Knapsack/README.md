# Knapsack

Avem un rucsac cu care putem transporta o anumita greutate maxim G.
Avem n obiecte de transportat si pentru fiecare obiect se cunoaste 
greutatea sa si beneficiul obtinut de pe urma transportului.
Se cere sa se determine ce obiecte pot fi transportate odata,
astfel incat castigul sa fie maxim. Pentru rezolvarea problemei se
va folosi structura (type struct).

a. Problema continua: Ultimu obiect adaugat se poate taia, prin asta intelegem
ca verificam daca putem adauga obiectul in intregime, adica daa prin adaugare 
nu se depaseste greutatea propua, in caz contrar, se tai obiectul pastrand greutatea admisa.

b. Problema discreta: Obiectele nu se pot taia, prin asta intelegem ca verificam
daca putem adauga obiectul, adica daca prin adaugare nu se depaseste greutatea propusa.

```cpp
#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>

struct Object
{
	float weight = 0.0f;
	float value = 0.0f;
	float percentage = 100.0f; // Objects are whole
};

std::vector<Object> ReadObjects(std::string path)
{
	std::ifstream file(path);

	if (!file.is_open()) {
		return {};
	}

	int n;
	file >> n;
	std::vector<Object> objects;
	objects.resize(n);

	for (int i = 0; i < n; i++)
	{
		file >> objects[i].weight >> objects[i].value; 
	}

	file.close();

	return objects;
}

bool ComparatorValuePerUnit(const Object& o1, const Object& o2)
{
	if (o1.value / o1.weight > o2.value / o2.weight)
	{
		return true;
	}

	if (o1.value / o1.weight == o2.value / o2.weight)
	{
		return o1.weight > o2.weight;
	}

	return false;
}

std::vector<Object> FillKnapsackDiscrete(std::vector<Object> objects, float knapsackWeight)
{
	std::sort(objects.begin(), objects.end(), ComparatorValuePerUnit);

	std::vector<Object> solution;

	int i = 0;
	float profit = 0.0f;
	while (knapsackWeight && i < objects.size())
	{
		if (objects[i].weight <= knapsackWeight) 
		{
			solution.emplace_back(objects[i]); 
			knapsackWeight -= objects[i].weight;
			profit += objects[i].value;
		}
		i++;
	}
	std::cout << "Profit: " << profit << std::endl;
	return solution;
}

std::vector<Object> FillKnapsackContinuous(std::vector<Object> objects, float knapsackWeight)
{
	std::sort(objects.begin(), objects.end(), ComparatorValuePerUnit);

	std::vector<Object> solution;

	int i = 0;
	float profit = 0;
	while (knapsackWeight && i < objects.size())
	{
		if (objects[i].weight <= knapsackWeight) 
		{
			solution.emplace_back(objects[i]); 
			knapsackWeight -= objects[i].weight;
			profit += objects[i].value;
		}
		else
		{
			float procent = knapsackWeight * 100 / objects[i].weight;
			profit += procent / 100 * objects[i].value;
			objects[i].percentage = procent;
			solution.emplace_back(objects[i]);
			knapsackWeight -= (procent / 100) * objects[i].weight; 
		}
		i++;
	}
	std::cout << "Profit: " << profit << std::endl;
	return solution;
}

void PrintSolution()
{
	std::vector<Object> objects = ReadObjects("objects.txt");
	float knapsackWeight;
	std::cout << "Introduceti greutatea.\ngreutate = ";
	std::cin >> knapsackWeight;

	std::cout << std::endl;
	std::cout << "Metoda dicreta:" << std::endl;

	std::vector<Object> solutionDiscrete = FillKnapsackDiscrete(objects, knapsackWeight);

	for (int i = 0; i < solutionDiscrete.size(); i++)
	{
		std::cout << solutionDiscrete[i].weight << " " << solutionDiscrete[i].value << "\n";
	}

	std::cout << std::endl;
	std::cout << "Metoda continua:" << std::endl;

	std::vector<Object> solutionContinuous = FillKnapsackContinuous(objects, knapsackWeight);

	for (int i = 0; i < solutionContinuous.size(); i++)
	{
		std::cout << solutionContinuous[i].weight << " " << solutionContinuous[i].value << " " << solutionContinuous[i].percentage << "%\n";
	}
}
```

Objects file:

```txt
5
10 250
15 300
20 400
25 750
7 170
```
