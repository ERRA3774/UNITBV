# Tema 2 - Gramatici generative

Să se implementeze o gramatică generativă astfel:
- Se citesc din fișier elementele componente: VN , VT, simbolul de start și producțiile;
- Se citește de la tastatură un număr n, iar apoi se generează n cuvinte DISTINCTE în gramatică. Generarea are loc în modul următor: se pornește de fiecare dată de la simbolul de start, iar cât timp există producții aplicabile, se aplică random una dintre acestea;
- Se cere crearea unei clase Gramatica, în afara clasei principale. Membrii clasei vor fi: VN, VT, S, producțiile.

În plus, clasa are metodele:
* citire - citirea elementelor gramaticii
* verificare:
  1. VN $\cap$ VT = $\emptyset$
  2. S $\in$ VN
  3. pentru fiecare regulă, membrul stâng conține cel puțin un neterminal
  4. există cel puțin o producție care are în stânga doar S
  5. fiecare producție conține doar elemente din VN și VT
* afișare - afișarea frumoasă a elementelor gramaticii
* generare - generarea de cuvinte pornind de la simbolul de start, cu afișarea fiecărui
 pas (nu doar a cuvintelor finale)

În funcția principală main se declară un obiect de tip Gramatica.

Barem:
1p - Definire corecta a clasei/ claselor

Implementare și apelarea metodelor specifice: 
* 1p - citire (0.5p dacă NU se citește din fișier)
* 2p - verificare: verificarea corectitudinii gramaticii, conform definiției unei gramatici
generative (cele 5 reguli descrise mai sus)
* 1p - afișarea frumoasă a gramaticii 
* 4p - generare:
  * 2p - generarea unui cuvânt în gramatică folosind o producție aleasă random 
dintre producțiile aplicabile la momentul curent, cu aplicare pe o poziție 
random (în cazul în care respectiva producție se poate aplica în mai multe 
locuri în cuvânt)
  * 1p - atunci când nu mai sunt aplicabile producții, se verifică faptul că avem un 
cuvânt format doar din terminale, este cuvânt final
  * 1p – afișarea producțiilor intermediare

Se acordă 1p din oficiu!

Sugestii de implementare:
* Pentru afișare, o producție poate fi afișată sub forma S -> abS
* Se poate folosi un caracter rezervat pentru a reprezenta cuvântul vid (λ), cum ar fi *, ?, etc.
* Atenție la producțiile de forma X→λ. Caracterul λ ar trebui să nu fie scris în cuvântul obținut 
sau, dacă se scrie, el trebuie șters imediat astfel încât căutarea de producții aplicabile să nu 
fie influențată.
* Se aplică random una dintre producțiile aplicabile. Dacă producția aleasă anterior poate 
fi aplicată în mai multe locuri în cuvânt, atunci locul în care se va aplica va fi și el ales tot 
random (exemplul de mai jos detaliază acest scenariu).

Exemplu:
Fie gramatica: G = ({S}, {a,b}, S, P), P conținând următoarele producții:
(1) S → abS
(2) S → aSAb
(3) S → aA
(4) A → aAb
(5) A → a
Etape:
- Pornim generearea unui cuvânt (presupunând că n = 1) de la simbolul de start S
- În acest moment sunt aplicabile producțiile (1), (2) și (3). Se alege random una dintre ele și se 
aplică. Spre exemplu, dacă funcția random o alege pe a doua, se obține:
S => aSAb.
- În acest moment sunt aplicabile toate producțiile. Presupunem că funcția random o va alege 
din nou pe a doua:
S => aSAb => aaSAbAb
- Din nou sunt aplicabile toate producțiile. Să presupunem că funcția random va alege producția 
(4). În acest moment producția este aplicabilă în două locuri. Locul în care se va aplica producția 
se va alege din nou random. Spre exemplu, se poate alege înlocuirea primului caracter A.
S => aSAb => aaSAbAb => aaSaAbbAb
- Se continuă în același mod până se obține un cuvânt alcătuit doar din terminale.
Exemplu: 
S => aSAb => aaSAbAb => aaSaAbbAb => aaaaAaAbbAb => aaaaaaAbbAb => aaaaaaAbbab 
=> aaaaaaabbab

***

Grammar.h
```cpp
#pragma once

#include <iostream>
#include <vector>
#include <unordered_set>
#include <sstream>
#include <string>
#include <fstream>

typedef std::pair<std::string, std::string> rule_t;

class Grammar {
public:
	Grammar();
	void ReadFile(std::string);
	void PrintFileData();
	void Derive(int userInput);
	bool IsValid();
	void GetGeneratedWordsToString();

private:
	bool _IsWord(std::string);
	bool _SetsAreDisjoint();
	bool _StartExistsInNonTerminals();
	bool _NonTerminalExistsInEachRule();
	bool _StartExistsInRules();
	bool _RulesAreValid();

private:
	std::unordered_set<char> m_nonTerminals;
	std::unordered_set<char> m_terminals;
	char m_start;
	std::vector<rule_t> m_rules;

	const char DELIMITER = ' ';
	std::unordered_set<std::string> m_generatedWords;
};
```

Grammar.cpp
```cpp
#include "Grammar.h"

Grammar::Grammar() :
	m_nonTerminals(std::unordered_set<char>()),
	m_terminals(std::unordered_set<char>()),
	m_start(char()),
	m_rules(std::vector<rule_t>()) {
}

void Grammar::ReadFile(std::string path) {
	std::ifstream in(path);

	if (in.is_open()) {
		int symbolsCount;
		char symbol;
		std::string line;
		std::unordered_set<char> nonTerminals;
		std::unordered_set<char> terminals;
		char start;
		std::vector<rule_t> rules;

		in >> symbolsCount;
		for (int i = 0; i < symbolsCount; ++i) {
			in >> symbol;
			nonTerminals.emplace(symbol);
		}

		in >> symbolsCount;
		for (int i = 0; i < symbolsCount; ++i) {
			in >> symbol;
			terminals.emplace(symbol);
		}

		in >> start;

		in >> symbolsCount;
		in.get();
		for (int i = 0; i < symbolsCount; ++i) {
			getline(in, line);
			std::string leftArg = line.substr(0, line.find(DELIMITER));
			std::string rightArg = line.substr(line.find(DELIMITER) + 1);
			rules.emplace_back(std::make_pair(leftArg, rightArg));
		}

		m_nonTerminals = nonTerminals;
		m_terminals = terminals;
		m_start = start;
		m_rules = rules;
	} // if

	in.close();
} // Grammar::ReadFile

void Grammar::PrintFileData() {
	std::cout << "Non-Terminal: ";
	for (auto& nonTerminal : m_nonTerminals) {
		std::cout << nonTerminal << ' ';
	}
	std::cout << '\n';

	std::cout << "Terminal: ";
	for (auto& terminal : m_terminals) {
		std::cout << terminal << ' ';
	}
	std::cout << '\n';

	std::cout << "Start: " << m_start << '\n';

	std::cout << "Rules:\n";
	for (auto& rule : m_rules) {
		std::cout << rule.first << " -> " << rule.second << '\n';
	}
	std::cout << '\n';
}

void Grammar::Derive(int userInput) {

	srand(time(0));

	for (int i = 0; i < userInput; ++i) {
		std::string word; 
		word = m_start;

		while (!_IsWord(word)) {
			int randRuleIndex = rand() % m_rules.size();

			std::string leftArg = m_rules[randRuleIndex].first;
			std::string rightArg = m_rules[randRuleIndex].second;

			// Gets all occurances of the left argument in the given word 
			std::vector<size_t> possiblePositions;
			for (size_t pos = word.find(leftArg); pos != std::string::npos; pos = word.find(leftArg, ++pos)) {
				possiblePositions.push_back(pos);
			}

			if (!possiblePositions.empty()) {
				std::cout << word << " -> ";
				int randPossitionIndex = rand() % possiblePositions.size();
				word.replace(possiblePositions[randPossitionIndex], leftArg.size(), rightArg);
				std::cout << word << '\n';
			}
		}

		if (m_generatedWords.find(word) == m_generatedWords.end()) {
			std::cout << "Found word no. " << i + 1 << ": " << word << '\n';
			m_generatedWords.emplace(word);
		}
		else {
			std::cout << "Word " << word << " was previously generated. Retrying. . ." << '\n';
			--i;
		}

		std::cout << '\n';
	} // for

} // Grammar::Derive

bool Grammar::IsValid() {

	bool flag = true;

	if (!_SetsAreDisjoint()) {
		std::cout << "Sets are not disjoing." << '\n';
		flag = false;
	}

	if (!_StartExistsInNonTerminals()) {
		std::cout << "Start not contained in Non-Terminals." << '\n';
		flag = false;
	}

	if (!_NonTerminalExistsInEachRule()) {
		std::cout << "Rule does not contain Non-Terminal." << '\n';
		flag = false;
	}

	if (!_StartExistsInRules()) {
		std::cout << "Start does not exist in Rules." << '\n';
		flag = false;
	}

	if (!_RulesAreValid()) {
		std::cout << "Rules contain elements outside of sets." << '\n';
		flag = false;
	}

	return flag;
}

void Grammar::GetGeneratedWordsToString() {
	std::cout << "Generated words:\n";
	for (auto& word : m_generatedWords) {
		std::cout << word << ' ';
	}
	std::cout << '\n';
}

bool Grammar::_IsWord(std::string word) {

	for (char ch : word) {
		if (!islower(ch)) {
			return false;
		}
	}

	return true;
}

bool Grammar::_SetsAreDisjoint() {

	for (auto& nonTerminal : m_nonTerminals) {
		for (auto& terminal : m_terminals) {
			if (nonTerminal == terminal) {
				return false;
			}
		}
	}

	return true;
}

bool Grammar::_StartExistsInNonTerminals() {
	return m_nonTerminals.find(m_start) != m_nonTerminals.end();
}

bool Grammar::_NonTerminalExistsInEachRule() {

	for (auto& rule : m_rules) {
		for (auto& nonTerminal : m_nonTerminals) {
			if (!rule.first.find(nonTerminal) && !rule.second.find(nonTerminal)) {
				return false;
			}
		}
	}

	return true;
}

bool Grammar::_StartExistsInRules() {

	for (auto& rule : m_rules) {
		if (rule.first.find(m_start)) {
			return true;
		}
	}

	return false;
}

bool Grammar::_RulesAreValid() {

	std::unordered_set<char> unionSet = m_nonTerminals;

	for (auto& terminal : m_terminals) {
		unionSet.emplace(terminal);
	}

	for (auto& rule : m_rules) {
		for (auto& el : unionSet) {
			if (!rule.first.find(el) && !rule.second.find(el)) {
				return false;
			}
		}
	}

	return true;
}
```

Source.cpp
```cpp
#include "Grammar.h"
#include "conio.h"

void RunApp() {
    Grammar gram;
    bool isRunning = true;
    gram.ReadFile("grammar.txt");
    gram.PrintFileData();
    
    if (!gram.IsValid()) {
        exit(EXIT_FAILURE);
    }

    do {
        std::cout << "Please input a number: ";
        std::string userInput;
        int wordsCount = 0;
        getline(std::cin, userInput);
        std::istringstream iss(userInput);
        iss >> wordsCount;

        std::cout << "Generated " << wordsCount << " words." << '\n';
        gram.Derive(wordsCount);
        gram.GetGeneratedWordsToString();

        std::cout << "Press ANY KEY to continue. . .\nPress Q to QUIT. . ." << '\n';
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
S A

2
a b

S

5
S abS
S aSAb
S aA
A aAb
A a
```
