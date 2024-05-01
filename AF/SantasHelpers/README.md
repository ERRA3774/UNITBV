# Santa's Helpers

Intr-un sat se afla mai multe case. Fiecare casa are urmatoarele caracteristici:   
1. id
2. culoare
3. numar de membri
4. cu/fara etaj

a. Sa se afiseze diferenta dintre numarul caselor de culoare verde si numarul caselor de culoare rosie  
b. Sa se afiseze id-ul caselor in ordinea crescatoare a membrilor (se cere implementarea eficienta, fara folosirea de functii predefinite in C++)  
c. Sa se afiseze cat % din case sunt cu etaj  
d. Mos Craciun isi propune sa lase in noapte de Ajun cate un cadou fiecarui membru din sat

   El are mai multe ajutoare, fiecare putand sa care un anumit numar de cadouri.  
   Sa se determine numarul minim de ajutoare pe care le va lua mosul cu el in seara de Ajun.  
   Sa se justifice metoda de programare alease pentru rezolvare.  
   Sa se precizeze complexitatea obtinuta(a se explica maniera de obtinere).  
   Observatie! Se presupune ca numarul de ajutoare este suficient pentru numarul de membri din sat.  
   Un exemplu este invalid daca numarul de ajutoare este mai mic decat numarul de membri din sat.  

   INVALID: Daca in sat sunt casele: 10 20 15 13 12
                Iar ajutoarele sunt: 5 2 10 3
   Atunci exemplul este invalid deoarece numarul de ajutoare este mai mic decat numarul total de membri din sat

   
   VALID: Daca in sat sunt casele: 10 7 2 5
                Iar ajutoare sunt: 5 10 3 10 2 4 1
          Se vor alege: 
          10 -> reuseste sa ofere cadouri complet pentru prima casa
          10 -> va oferi cadouri pentru a doua si a treia casa, respectiv unui membru din a patra casa
           5 -> va oferi restul de cadouri pentru ultima casa

  VALID: Daca in sat sunt casele: 30 10 5
                Iar ajutoare sunt: 35 9 14
          Se vor alege: 
          35 -> va oferi cadouri pentru prima casa, si urmatorii 5 membri din a doua casa
          14 -> va oferi cadouri pentru a restul din a doua casa, si ultima casa complet

  VALID: Daca in sat sunt casele: 12 14 10
                Iar ajutoare sunt: 20 10 14
          Se vor alege: 
          20 -> va oferi cadouri pentru prima casa, si urmatorii 8 membri din a doua casa
          14 -> va oferi cadouri pentru a restul din a doua casa, si urmatorii 8 membri din a treia casa
          10 -> va oferi cadouri celor 2 membri ramasi din ultima casa


```cpp
#include <algorithm>
#include <fstream>
#include <iostream>
#include <vector>

struct House
{
	int id = -1;
	int membersCount = -1;
	std::string color = "";
	bool hasMoreLevels = false;
};

std::vector<House>	ReadHouses(std::string path);
void PrintHouses(std::vector<House>& houses);
void Swap(House& a, House& b);
void QuickSort(std::vector<House>& houses, int left, int right);
void PrintIds(std::vector<House>& houses);
int	CountOfHousesDifferentByColor(std::vector<House>& houses, std::string color1, std::string color2);
void PrintCountOfHousesDifferentByColor(std::vector<House>& houses, std::string color1, std::string color2);
void PrintPercentageOfHousesWithMoreLevels(std::vector<House>& houses);
std::vector<int> MinNumberOfHelpers(std::vector<House>& houses, std::vector<int>& helpers);
void PrintMinHelpers(std::vector<House>& houses, std::vector<int>& helpers);
void TestMinHelpers(std::vector<int>& houses, std::vector<int>& helpers);
void RunTests();

int PrintSolution()
{
	std::vector<House> houses = ReadHouses("houses.txt");
	PrintHouses(houses);
	PrintCountOfHousesDifferentByColor(houses, "VERDE", "ROSU");
	std::cout << "ID dupa sortare: " << std::endl;
	QuickSort(houses, 0, houses.size() - 1);
	PrintIds(houses);
	PrintPercentageOfHousesWithMoreLevels(houses);
	std::vector<int> helpers = { 5, 10, 3, 10, 2, 4, 1, 35, 9, 14, 20, 10, 14 };
	PrintMinHelpers(houses, helpers);

	RunTests();
}

std::vector<House> ReadHouses(std::string path)
{
	std::ifstream file(path);

	if (!file.is_open()) {
		return {};
	}

	int n;
	file >> n;
	std::vector<House> houses;

	for (int i = 0; i < n; i++)
	{
		House fileHouse;
		
		file
			>> fileHouse.id
			>> fileHouse.membersCount
			>> fileHouse.color
			>> fileHouse.hasMoreLevels;
		
		houses.emplace_back(fileHouse);
	}

	return houses;
}

void PrintHouses(std::vector<House>& houses)
{
	int k = 0;
	for (auto& house : houses)
	{
		std::cout
			<< "House: " << ++k
			<< " Id: " << house.id
			<< " Membri: " << house.membersCount
			<< " Culoare: " << house.color
			<< " Are etaj: " << ((house.hasMoreLevels != 0) ? "YES" : "NO")
			<< std::endl;
	}

	std::cout << std::endl;
}

void Swap(House& a, House& b)
{
	House temp = a;
	a = b;
	b = temp;
}

void QuickSort(std::vector<House>& houses, int left, int right)
{
	int i = left;
	int j = right;
	int mid = (right - left) / 2 + left;

	int pivot = houses[mid].membersCount;

	while (i <= j)
	{
		while (houses[i].membersCount < pivot)
		{
			i++;
		}

		while (houses[j].membersCount > pivot)
		{
			j--;
		}

		if (i <= j)
		{
			Swap(houses[i++], houses[j--]);
		}
	}

	if (left < j)
	{
		QuickSort(houses, left, j);
	}

	if (i < right)
	{
		QuickSort(houses, i, right);
	}
}

void PrintIds(std::vector<House>& houses)
{
	for (auto& House : houses)
	{
		std::cout << House.id << " ";
	}

	std::cout << std::endl;
}

// Functie ajutatoare pentru calcularea diferentei numarului de case de o anumita culoare
int CountOfHousesDifferentByColor(std::vector<House>& houses, std::string color1, std::string color2)
{
	int colorCounter1 = 0;
	int colorCounter2 = 0;

	for (int i = 0; i < houses.size(); i++)
	{
		if (houses[i].color == color1)
		{
			colorCounter1++;
		}

		if (houses[i].color == color2)
		{
			colorCounter2++;
		}
	}

	std::cout << "Sunt " << colorCounter2 << " case de culoare " << color2 << std::endl;
	std::cout << "Sunt " << colorCounter1 << " case de culoare " << color1 << std::endl;

	if (colorCounter2 == colorCounter1)
	{
		return 0;
	}

	return (colorCounter2 > colorCounter1) ? (colorCounter2 - colorCounter1) : (colorCounter1 - colorCounter2);
}

void PrintCountOfHousesDifferentByColor(std::vector<House>& houses, std::string color1, std::string color2)
{
	int diferenta_culori = CountOfHousesDifferentByColor(houses, color1, color2);

	if (diferenta_culori == 0)
	{
		std::cout
			<< "Numarul caselor de culoare "
			<< color1 << " si " << color2
			<< " este egal."
			<< std::endl;
	}
	else
	{
		std::cout
			<< "Diferenta caselor de culoare "
			<< color1 << " si cea a caselor de culoare " << color2
			<< " este de " << diferenta_culori
			<< std::endl;
	}
}

void PrintPercentageOfHousesWithMoreLevels(std::vector<House>& houses)
{
	float counter = 0;

	for (auto& house : houses)
	{
		if (house.hasMoreLevels)
		{
			counter++;
		}
	}

	std::cout << (counter / static_cast<float>(houses.size())) * 100 << "% din case au etaj" << std::endl;
}

std::vector<int> MinNumberOfHelpers(std::vector<House>& houses, std::vector<int>& helpers)
{
	std::vector<int> minHelpers;
	int count = 0;

	for (int i = 0; i < houses.size(); i++)
	{
		count += houses[i].membersCount;
	}

	sort(helpers.begin(), helpers.end(), std::greater<int>());

	int i = 0;
	while (count >= 0 && i < helpers.size())
	{
		minHelpers.emplace_back(helpers[i]);
		count -= helpers[i];
		i++;
	}

	if (count > 0)
	{
		std::cout << "Mos Craciun nu are suficiente ajutoare." << std::endl;
		return {};
	}

	return minHelpers;
}

void PrintMinHelpers(std::vector<House>& houses, std::vector<int>& helpers)
{
	std::vector<int> minHelpers = MinNumberOfHelpers(houses, helpers);

	std::cout << "Minimul de ajutoare de care are nevoie Mos Craciun:" << std::endl;

	for (int i = 0; i < minHelpers.size(); i++)
	{
		std::cout << minHelpers[i] << " ";
	}

	std::cout << std::endl;
}

//--------------------------------------------------------------------------------- TESTS
void TestMinHelpers(std::vector<int>& houses, std::vector<int>& helpers)
{
	std::vector<int> minHelpers;
	int dwellersCount = 0;
	for (int i = 0; i < houses.size(); i++)
	{
		dwellersCount += houses[i];
	}

	sort(helpers.begin(), helpers.end(), std::greater<int>());

	int i = 0;
	while (dwellersCount >= 0 && i < helpers.size())
	{
		minHelpers.emplace_back(helpers[i]);
		dwellersCount -= helpers[i];
		i++;
	}
	if (dwellersCount > 0)
	{
		std::cout << "Mos Craciun nu are suficiente ajutoare.";
		return;
	}

	for (int i = 0; i < minHelpers.size(); i++)
	{
		std::cout << minHelpers[i] << " ";
	}

	std::cout<<std::endl;
}

void RunTests()
{
	std::cout << std::endl;
	std::cout << "Test 1: \n10, 7, 2, 5\n5, 10, 3, 10, 2, 4, 1" << std::endl;
	std::vector<int> house0{ 10, 7, 2, 5 };
	std::vector<int> help0{ 5, 10, 3, 10, 2, 4, 1 };
	TestMinHelpers(house0, help0);
	std::cout << std::endl;
	
	std::cout << "Test 2: \n30, 10, 5\n35, 9, 14" << std::endl;
	std::vector<int> house1{ 30, 10, 5 };
	std::vector<int> help1{ 35, 9, 14 };
	TestMinHelpers(house1, help1);
	std::cout << std::endl;

	std::cout << "Test 3: \n12, 14, 10\n20, 10, 14" << std::endl;
	std::vector<int> house2{ 12, 14, 10 };
	std::vector<int> help2{ 20, 10, 14 };
	TestMinHelpers(house2, help2);
	std::cout << std::endl;

	std::cout << "Test 3: \n10, 20, 15, 13, 12\n5, 2, 10, 3" << std::endl;
	std::vector<int> house3{ 10, 20, 15, 13, 12 };
	std::vector<int> help3{ 5, 2, 10, 3 };
	TestMinHelpers(house3, help3);
}
```

Houses file:

```txt
10
0
10
ROSU
1
1
7
ORANGE
0
2
2
GALBEN
1
3
5
VERDE
0
4
30
ALBASTRU
1
5
10
INDIGO
0
6
5
VIOLET
1
7
12
MAGENTA
0
8
14
ROSU
1
9
10
ROSU
1
```