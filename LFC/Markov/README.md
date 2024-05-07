# Tema 1 - Algoritmi normali în sens Markov

Să se implementeze un algoritm normal în sens Markov astfel:
- Se citesc din fișier componentele (vocabularul și regulile de rescriere);
- Se citește de la tastatură un cuvânt, se derivează pe baza algoritmului (se derivează până se aplică o regulă finală sau nu mai există reguli aplicabile), se afișează cuvântul obținut, apoi utilizatorul este întrebat dacă mai dorește testarea unui cuvânt și, în caz afirmativ, se reia procesul (până când utilizatorul răspunde negativ);

Se cere implementarea unei clase Markov în afara clasei principale. Această clasă are ca membrii vocabularul și mulțimea de reguli (producții) ale algoritmului, cu precizarea regulilor finale.

În plus, clasa are metodele: 
* citire - care citește elementele algoritmului 
* validare - validează input-ul dat (cuvântul conține doar caractere din vocabular)
* afișare - afișează frumos, pe ecran, datele de intrare
* derivare - derivează cuvântul conform algoritmului normal în sens Markov și afișează
rezultatul final, dar și pe cele intermediare.

În funcția principală main se declară un obiect de tip Markov prin intermediul căruia se realizează
derivarea cuvintelor.

Barem:
1p - Definirea corectă a clasei/ claselor

Implementarea și apelarea metodelor specifice:
1p - citire (0.5p dacă NU se citește din fișier)
1p - validare: metodă pentru verificarea faptului că fiecare cuvânt de intrare este format
doar din caractere ale vocabularului
1p - afișarea frumoasă a vocabularului și a producțiilor 
3.5p - derivarea corect realizată (2.5p), împreună cu afișarea rezultatelor succesive aferente 
derivării (nu doar a rezultatului final)
1p - Dacă programul permite citirea mai multor cuvinte și derivarea lor, fără a reporni aplicația 
(într-un while cu opțiune de oprire) 
0.5p - Utilizarea corectă de reguli finale 
Se acordă 1p din oficiu!
Observație: Se recomandă folosirea și a ALTOR METODE (în afara celor amintite în enunț) 
pentru rezolvarea problemei!

Sugestii de implementare:
* Se poate folosi un caracter rezervat pentru a reprezenta cuvântul vid (λ), cum ar fi *, ?, etc.
* Atenție la producțiile de forma a→λ. Caracterul λ ar trebui să nu fie scris în cuvântul obținut 
sau, dacă se scrie, el trebuie șters imediat astfel încât căutarea de producții aplicabile să nu 
fie influențată.

***

Markov.h
```cpp
#pragma once

#include <iostream>
#include <fstream>
#include <string>
#include <tuple>
#include <unordered_set>
#include <vector>

typedef std::tuple<std::string, std::string, bool> rule_t;

class Markov {
public:
    Markov();
    void ReadFile(std::string);
    void Derive(std::string);
    bool IsValid(std::string);
    void PrintFileData();
    std::string GetVocabularyToString();

private:
    std::unordered_set<char> m_vocabulary;
    std::vector<rule_t> m_rules;
    std::string m_result;
    const char DELIMITER = ' ';
    const char LAMBDA = '?';
    const char DOT = '.';
};
```

Markov.cpp
```cpp
#include "Markov.h"

Markov::Markov() :
	m_vocabulary(std::unordered_set<char>()),
	m_rules(std::vector<rule_t>()),
	m_result(std::string()) {
}

void Markov::ReadFile(std::string path) {
	std::ifstream in(path);

	if (in.is_open()) {
		int symbolsCount;
		char symbol;
		std::unordered_set<char> vocabulary;
		std::vector<rule_t> rules;
		std::string line;

		in >> symbolsCount;
		for (int i = 0; i < symbolsCount; ++i) {
			in >> symbol;
			vocabulary.emplace(symbol);
		}

		in >> symbolsCount;
		in.get();
		for (int i = 0; i < symbolsCount; ++i) {
			getline(in, line);
			std::string leftArg = line.substr(0, line.find(DELIMITER));
			std::string rightArg = line.substr(line.find(DELIMITER) + 1);
			bool isFinal = rightArg.find(DOT) != std::string::npos ? true : false;
			rules.emplace_back(std::make_tuple(leftArg, rightArg, isFinal));
		}
		m_vocabulary = vocabulary;
		m_rules = rules;
	}

	in.close();

	if (m_vocabulary.empty() || m_rules.empty()) {
		std::cout << "File might be empty. Exiting. . .";
		exit(EXIT_FAILURE);
	}
}

void Markov::Derive(std::string word) {

	int ruleIndex = 0;
	while (ruleIndex < m_rules.size()) {
		std::string leftArg = std::get<0>(m_rules[ruleIndex]);
		std::string rightArg = std::get<1>(m_rules[ruleIndex]);
		bool isFinal = std::get<2>(m_rules[ruleIndex]);

		auto pos = word.find(leftArg);

		if (pos == std::string::npos) {
			ruleIndex++;
			continue;
		}

		std::cout << word << " |" << (ruleIndex + 1) << "- ";
		word.replace(pos, leftArg.size(), rightArg);
		word.erase(std::remove(word.begin(), word.end(), LAMBDA), word.end());
		if (word.empty()) { word.push_back(LAMBDA); }
		std::cout << word << '\n';

		if (isFinal) { break; }

		ruleIndex = 0;
	}

	std::cout << "Result = {" << word << "}" << '\n';
	m_result = word;
}

bool Markov::IsValid(std::string word) {

	if (word.empty()) {
		return false;
	}

	std::unordered_set<char> charSet;

	for (auto& ch : m_vocabulary) {
		charSet.emplace(ch);
	}

	for (auto& ch : word) {
		if (charSet.find(ch) == charSet.end()) {
			return false;
		}
	}
	return true;
}

void Markov::PrintFileData() {
	std::cout << "Vocabulary = {";
	for (auto it = m_vocabulary.begin(); it != m_vocabulary.end();) {
		std::cout << *it;
		if (++it != m_vocabulary.end()) {
			std::cout << ", ";
		}
	}
	std::cout << "}\n";

	std::cout << "Rules = {" << '\n';
	for (auto& rule : m_rules) {
		std::cout <<
			std::get<0>(rule) << " -> " <<
			std::get<1>(rule) << '\n';
	}
	std::cout << "}\n";
}

std::string Markov::GetVocabularyToString()
{
	std::string builder;

	builder += "{";
	for (auto it = m_vocabulary.begin(); it != m_vocabulary.end();) {
		builder += *it;
		if (++it != m_vocabulary.end()) {
			builder += ", ";
		}
	}
	builder += "}";
	return builder;
}
```

Source.cpp
```cpp
#include "conio.h";

#include "Markov.h"

void RunApp() {
    Markov mark;
    bool isRunning = true;
    mark.ReadFile("inputs\\markov1.txt"); // replace name here
    mark.PrintFileData();

    std::cout << "Please input a word using only: " << mark.GetVocabularyToString() << '\n';
    do {
        std::string userInput;
        std::cout << "Input>";
        getline(std::cin, userInput);

        if (!mark.IsValid(userInput)) {
            std::cout << "Invalid input. Please try again." << '\n';
        }

        if (mark.IsValid(userInput)) {
            mark.Derive(userInput);
        }

        std::cout << "Press ANY KEY to continue or Q to QUIT." << '\n';
        char cmd = _getch();
        if (cmd == 'q') {
            isRunning = false;
            std::cout << "Goodbye!\n";
        }
    } while (isRunning);
}

int main() {
    RunApp();
    return EXIT_SUCCESS;
}
```

Tested inputs

```txt
2
a b 

3
a ?
b ?
? .aba
```

```txt
4
a x y #

7
ya ay
xa ayx
x ?
a# #x
#a #
# ?
y a
```

```txt
2
a #

1
# ?
```

```txt
2
a #

2
a#a #
# ?
```

```txt
5
a x y z #

7
ax xa
a#a x#
a# #y
y a
x z
z a
# ?
```