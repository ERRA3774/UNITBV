# Tema 3 - Automate finite deterministe (AFD)

Sa se implementeze un AFD (automat finit determinist) astfel:
* Se citesc din fisier elementele componente ale automatului (Q, S, d, q0, F);
* Se citeste de la tastatura un cuvant si se verifica daca este acceptat/respins sau daca genereaza blocaj; 
* In plus, se vor afisa toate etapele prin care cuvantul va trece;
* Utilizatorul va fi intrebat daca mai doreste testarea unui cuvant si, in caz afirmativ, se reia procesul (pana cand utilizatorul raspunde negativ);

Se cere implementarea unei clase AFD in afara clasei principale. 
Aceasta clasa are ca membrii: 
* Stari 
* Sigma
* Delta 
* StareInitiala 
* StariFinale 

In plus, clasa are metodele:
* citire - care citeste elementele automatului
* validare - valideaza input-ul dat (detalii in barem)
* afisare - afiseaza frumos, pe ecran, componentele automatului
* verificare(cuvant) - verifica daca cuvantul dat ca parametru este acceptat de catre automat 

Si afisaza: 
* "acceptat" - daca este cuvant acceptat
* "neacceptat" - daca nu este acceptat
* "blocaj" - daca automatul se blocheaza pe parcurs
in functia principala main se declara un obiect de tip AFD.

Barem:
1p - Definire corecta a clasei AFD

Implementarea si apelarea metodelor specifice: 
* 1p - citire (0.5p daca NU se citeste din fisier)
* 2p - validare:
  * 0.75p - Q contine stari distincte si fiecare stare este memorata intr-un string (daca starile vor fi retinute ca si int-uri se va scadea din punctaj)
  * 0.25p - S indeplineste conditiile de vocabular
  * 0.5p - pentru fiecare tranzitie din d se verifca faptul de prima componenta este din Q, a doua este din S, iar a treia este din Q (EXCEPTIE lambda)
  * 0.25p - q0 este din Q
  * 0.25p - F este inclus in Q
* 1p - afisarea frumoasa a componentelor automatului
* 4p - algoritmul de verificare:
  * 2p - implementarea corecta a algoritmului, cu inlocuiri succesive si afisarea 
acestora
  * 1p - afisarea mesajului de acceptat, respins, respectiv blocaj in functie de cuvant
  * 1p - reluarea intregului proces pentru un nou cuvant, fara a reporni programul 
(meniu while)
Se acorda 1p din oficiu!

Sugestii de implementare:
*  Structuri de date: 
Q = string
S = vector<char>
d = clasa cu 3 membrii (parte_stanga = string, simbol = char, parte_dreapta = string)/matrice
q0 = string
F = vector<string>
*  Cuvantul initial trebuie sa contina doar simboluri din alfabet pentru a putea fi trecut 
prin automat. in caz contrar, se va afisa un mesaj corespunzator.

***

Constants.h
```cpp
#pragma once

#include <string>

class Constants
{
public:
	static const std::string FILE_PATH_DATA;
	static const std::string KEY_STATES;
	static const std::string KEY_ALPHABET;
	static const std::string KEY_TRANSITIONS;
	static const std::string KEY_INITIAL_STATE;
	static const std::string KEY_FINAL_STATES;
	static const std::string KEY_TRANSITION_LEFT_ARG;
	static const std::string KEY_TRANSITION_SYMBOL;
	static const std::string KEY_TRANSITION_RIGHT_ARG;
	static const int TRANSITION_SIZE;
	static const int TRANSITION_LEFT_ARG;
	static const int TRANSITION_SYMBOL;
	static const int TRANSITION_RIGHT_ARG;
	static const std::string RESULT_ACCEPTED;
	static const std::string RESULT_REJECTED;
	static const std::string RESULT_BLOCKED;
};
```

Constants.cpp
```cpp
#include "Constants.h"

const std::string Constants::FILE_PATH_DATA = "inputs\\data.json";
const std::string Constants::KEY_STATES = "states";
const std::string Constants::KEY_ALPHABET = "alphabet";
const std::string Constants::KEY_TRANSITIONS = "transitions";
const std::string Constants::KEY_INITIAL_STATE = "initial_state";
const std::string Constants::KEY_FINAL_STATES = "final_states";
const std::string Constants::KEY_TRANSITION_LEFT_ARG = "left_arg";
const std::string Constants::KEY_TRANSITION_SYMBOL = "symbol";
const std::string Constants::KEY_TRANSITION_RIGHT_ARG = "right_arg";
const int Constants::TRANSITION_SIZE = 3;
const int Constants::TRANSITION_LEFT_ARG = 0;
const int Constants::TRANSITION_SYMBOL = 1;
const int Constants::TRANSITION_RIGHT_ARG = 2;
const std::string Constants::RESULT_ACCEPTED = "ACCEPTED";
const std::string Constants::RESULT_REJECTED = "REJECTED"; 
const std::string Constants::RESULT_BLOCKED = "BLOCKED";
```

Transition.h
```cpp
#pragma once

#include <string>
#include <iostream>

class Transition {

public:
	Transition();
	Transition(std::string, std::string, std::string);

	std::string Arg(int index);

	friend std::ostream& operator<<(std::ostream& os, const Transition& t);

private:
	std::string m_leftArg;
	std::string m_symbol;
	std::string m_rightArg;
};
```

Transition.cpp
```cpp
#include "Transition.h"

Transition::Transition() :
	m_leftArg(std::string()), m_symbol(std::string()), m_rightArg(std::string()) {}

Transition::Transition(std::string lArg, std::string sym, std::string rArg) :
	m_leftArg(lArg), m_symbol(sym), m_rightArg(rArg) {}

std::string Transition::Arg(int index) {

	switch (index)
	{
	case 0:
		return m_leftArg;
	case 1:
		return m_symbol;
	case 2:
		return m_rightArg;
	default:
		return std::string();
	}
}

std::ostream& operator<<(std::ostream& os, const Transition& t) {

	os << "l:" << t.m_leftArg << ", s:" << t.m_symbol << ", r:" << t.m_rightArg;
	return os;
}
```

DFA.h
```cpp
#pragma once

#include <algorithm>
#include <iostream>
#include <fstream>
#include <set>
#include <vector>

#include "json.hpp"

#include "Constants.h"
#include "Transition.h"

using json = nlohmann::json;

class DFA {
public:
	DFA();

	void ReadFile(std::string);
	void PrintFileData();

	bool GoodFileData();
	bool GoodUserInput(std::string);

	std::string ValidatedResultFromUser(std::string);

	// GETTERS
	std::string GetStatesToString();
	std::string GetAlphabetToString();
	std::string GetTransitionsToString();
	std::string GetInitialState();
	std::string GetFinalStatesToString();

private:
	bool _GoodTransition(Transition);
	bool _ApplyTransitionOn(std::string&, std::string);

private:
	std::set<std::string> m_states;
	std::set<std::string> m_alphabet;
	std::vector<Transition> m_transitions;
	std::string m_initialState;
	std::set<std::string> m_finalStates;
};
```

DFA.cpp
```cpp
#include "DFA.h"

DFA::DFA() {

	m_states = std::set<std::string>();
	m_alphabet = std::set<std::string>();
	m_transitions = std::vector<Transition>();
	m_initialState = std::string();
	m_finalStates = std::set<std::string>();
}

void DFA::ReadFile(std::string path) {

	std::ifstream file(path);

	std::set<std::string> fileStates;
	std::set<std::string> fileAlphabet;
	std::vector<Transition> fileTransitions;
	std::string fileInitialState;
	std::set<std::string> fileFinalStates;

	try {
		json data = json::parse(file);

		std::set<std::string> states = static_cast<std::set<std::string>>(data[Constants::KEY_STATES]);
		std::set<std::string> alphabet = static_cast<std::set<std::string>>(data[Constants::KEY_ALPHABET]);
		std::set<std::string> finalStates = static_cast<std::set<std::string>>(data[Constants::KEY_FINAL_STATES]);
		std::string initialState = static_cast<std::string>(data[Constants::KEY_INITIAL_STATE]);

		// STATES
		for (auto& state : states) { fileStates.emplace(state); }

		// ALPHABET
		for (auto& letter : alphabet) { fileAlphabet.emplace(letter); }

		// TRANSITIONS
		for (auto& transition : data[Constants::KEY_TRANSITIONS]) {

			if (transition.size() != Constants::TRANSITION_SIZE) {
				std::cerr << "Invalid transitions size. Breaking . . ." << std::endl;
				break;
			}
			Transition trans(
				transition[Constants::KEY_TRANSITION_LEFT_ARG],
				transition[Constants::KEY_TRANSITION_SYMBOL],
				transition[Constants::KEY_TRANSITION_RIGHT_ARG]);

			fileTransitions.emplace_back(trans);
		}

		// INITIAL STATE
		fileInitialState = initialState;

		// FINAL STATES
		for (auto& finalState : finalStates) { fileFinalStates.emplace(finalState); }
	}
	catch (const json::parse_error& e) {
		std::cerr << "JSON parsing error: " << e.what() << std::endl;
	}

	m_states = fileStates;
	m_alphabet = fileAlphabet;
	m_transitions = fileTransitions;
	m_initialState = fileInitialState;
	m_finalStates = fileFinalStates;

	file.close();
} // ReadFile

void DFA::PrintFileData() {

	std::cout << "States = {" << GetStatesToString() << "}" << std::endl;

	std::cout << "Alphabet = {" << GetAlphabetToString() << "}" << std::endl;

	std::cout << "Transitions = [\n" << GetTransitionsToString() << "]" << std::endl;

	std::cout << "Initial State = " << GetInitialState() << std::endl;

	std::cout << "Final states = {" << GetFinalStatesToString() << "}" << std::endl;
}

bool DFA::GoodFileData() {

	bool flag = true;

	if (m_states.empty()) {
		std::cout << "States is empty." << std::endl;
		flag = false;
	}

	if (m_alphabet.empty()) {
		std::cout << "Alphabet is empty." << std::endl;
		flag = false;
	}

	for (auto& elem : m_alphabet) {
		if (elem.length() > 1) {
			std::cout << "Invalid symbol: " << elem << std::endl;
			flag = false;
		}
	}

	for (auto& trans : m_transitions) {
		if (!_GoodTransition(trans)) {
			std::cout << "Invalid transition: " << trans << std::endl;
			flag = false;
		}
	}

	if (m_states.find(m_initialState) == m_states.end()) {
		std::cout << "Invalid initial state: " << GetInitialState() << std::endl;
		flag = false;
	}

	for (auto& finState : m_finalStates) {
		if (m_states.find(finState) == m_states.end()) {
			std::cout << finState << " not in " << GetStatesToString();
			flag = false;
		}
	}

	return flag;
}

bool DFA::GoodUserInput(std::string input) {

	for (char ch : input) {
		if (m_alphabet.find(std::string{ ch }) == m_alphabet.end()) {
			return false;
		}
	}
	return true;
}

bool DFA::_ApplyTransitionOn(std::string& currentState, std::string beginning) {

	for (int i = 0; i < m_transitions.size(); ++i) {
		std::string currentSymbol = m_transitions[i].Arg(Constants::TRANSITION_SYMBOL);
		std::string currentLeftArg = m_transitions[i].Arg(Constants::TRANSITION_LEFT_ARG);

		if (currentSymbol == beginning && currentState == currentLeftArg) {
			currentState = m_transitions[i].Arg(Constants::TRANSITION_RIGHT_ARG);
			return true;
		}
	}

	return false;
}

std::string DFA::ValidatedResultFromUser(std::string input) {
	std::string currentState = m_initialState;

	// Erase the first letter with each iteration 
	for (std::string word = input; !word.empty(); word.erase(word.begin())) {
		std::cout << "d(" << currentState << ", " << word << ") = ";
		if (!_ApplyTransitionOn(currentState, std::string{ *word.begin() })) {
			return Constants::RESULT_BLOCKED;
		}
	}
	
	if (m_finalStates.find(currentState) == m_finalStates.end()) {
		return Constants::RESULT_REJECTED;
	}

	return Constants::RESULT_ACCEPTED;
}

std::string DFA::GetStatesToString() {

	std::string buffer;
	for (auto it = m_states.begin(); it != m_states.end();) {
		buffer += *it;
		if (++it != m_states.end()) {
			buffer += ", ";
		}
	}
	return buffer;
}

std::string DFA::GetAlphabetToString() {

	std::string buffer;
	for (auto it = m_alphabet.begin(); it != m_alphabet.end();) {
		buffer += *it;
		if (++it != m_alphabet.end()) {
			buffer += ", ";
		}
	}
	return buffer;
}

std::string DFA::GetTransitionsToString() {

	std::string buffer;
	for (auto& trans : m_transitions) {
		buffer += "    d(" +
			trans.Arg(Constants::TRANSITION_LEFT_ARG) + ", " +
			trans.Arg(Constants::TRANSITION_SYMBOL) + ") = " +
			trans.Arg(Constants::TRANSITION_RIGHT_ARG) + '\n';
	}
	return buffer;
}

std::string DFA::GetInitialState() {
	return m_initialState;
}

std::string DFA::GetFinalStatesToString() {

	std::string buffer;
	for (auto it = m_finalStates.begin(); it != m_finalStates.end();) {
		buffer += *it;
		if (++it != m_finalStates.end()) {
			buffer += ", ";
		}
	}
	return buffer;
}

bool DFA::_GoodTransition(Transition trans) {

	bool leftArgInStates = m_states.find(trans.Arg(Constants::TRANSITION_LEFT_ARG)) != m_states.end();
	bool symbolInAlphabet = m_alphabet.find(trans.Arg(Constants::TRANSITION_SYMBOL)) != m_alphabet.end();
	bool rightArgInStates = m_states.find(trans.Arg(Constants::TRANSITION_RIGHT_ARG)) != m_states.end();

	return leftArgInStates && symbolInAlphabet && rightArgInStates;
}
```

Source.cpp
```cpp
#include "DFA.h"
#include "conio.h"

void RunApp() {
    DFA dfa;
    bool isRunning = true;
    dfa.ReadFile(Constants::FILE_PATH_DATA);
    dfa.PrintFileData();
    if (!dfa.GoodFileData()) { return; }

    std::cout << "Please input a word using only: " << dfa.GetAlphabetToString() << '\n';
    do {
        std::string userInput;
        std::cout << "Input>";
        getline(std::cin, userInput);

        if (!dfa.GoodUserInput(userInput)) {
            std::cout << "Bad Input. Please try again." << std::endl;
        }
        else {
            std::cout << dfa.ValidatedResultFromUser(userInput) << std::endl;
        }

        std::cout << "Press ANY KEY to continue or Q to QUIT." << std::endl;
        char cmd = _getch();
        if (cmd == 'q') {
            isRunning = false;
            std::cout << "Goodbye!\n";
        }
    } while (isRunning);
}

int main() {

    RunApp();
    return 0;
}
```

Tested inputs

```json
{
	"states": [ "q0", "q1" ],
	"alphabet": [ "a", "b" ],
	"transitions": [
		{
			"left_arg": "q0",
			"symbol": "a",
			"right_arg": "q1"
		},
		{
			"left_arg": "q1",
			"symbol": "a",
			"right_arg": "q1"
		},
		{
			"left_arg": "q1",
			"symbol": "b",
			"right_arg": "q0"
		}
	],
	"initial_state": "q0",
	"final_states": ["q1"]
}
```