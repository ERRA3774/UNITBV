# Banknotes

Avem un numar nelimitat de bancnote de diferite sume fiecare {1, 5, 10, 20, 50, 100, 200, 500}
Dormin sa aflam care este numarul minim de bancnote utilizate pentru a obtine o suma X citita de la tastatura
Suma = 70 -> result: 50, 20

```cpp
#include <algorithm>
#include <iostream>
#include <vector>

struct Banknote {
	int value = 0;
	int usageCount = 0;
};

std::vector<Banknote> ReadBanknotes() {
    int numOfBanknotes;
    std::vector<Banknote> banknotes;

    std::cout << "Cate tipuri de bancnote folositi?" << std::endl;
    std::cin >> numOfBanknotes;

    banknotes.resize(numOfBanknotes);
    std::cout << "Introduceti valorile bancnotelor:" << std::endl;
    for (int i = 0; i < numOfBanknotes; i++)
    {
        std::cin >> banknotes[i].value;
    }

    return banknotes;
}

std::vector<Banknote> MinNumberOfBanknotes(std::vector<Banknote>& banknotes, int sum) {

    std::sort(banknotes.begin(), banknotes.end(), [](const Banknote& lhs, const Banknote& rhs) {
        return lhs.value > rhs.value;
        });

    int i = 0;
    std::vector<Banknote> solution;
    while (sum > 0 && i < banknotes.size())
    {
        if (banknotes[i].value <= sum) 
        {
            Banknote temp;
            temp.value = banknotes[i].value;
            temp.usageCount = sum / banknotes[i].value;
            solution.emplace_back(temp);
            sum -= banknotes[i].value * (sum / banknotes[i].value);
        }
        i++;
    }

    if (sum != 0) 
    {
        std::cout << "Error: Plata nu poate fi facuta." << std::endl;
    }

    return solution;
}

void PrintSolution() {
    int sum;
    std::vector<Banknote> banknotes = ReadBanknotes();

    std::cout << "Introduceti valoarea sumei:\nsuma = ";
    std::cin >> sum;

    std::vector<Banknote> minNumberOfBanknotes = MinNumberOfBanknotes(banknotes, sum);

    if (minNumberOfBanknotes.empty())
    {
        std::cout << "Nu exista solutie." << std::endl;
    }
    else
    {
        for (int i = 0; i < minNumberOfBanknotes.size(); i++)
        {
            std::cout << "S-a folosit bancnota cu valoarea: " << minNumberOfBanknotes[i].value << " de " << minNumberOfBanknotes[i].usageCount << " ori." << std::endl;
        }
    }
}
```