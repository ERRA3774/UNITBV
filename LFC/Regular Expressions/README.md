# Tema 4 – Expresii regulate
2p - Să se verifice dacă un string dat este sau nu este număr întreg sau număr real.

Programul va afișa, pentru string-ul introdus, unul dintre următoarele mesaje: 
* “număr întreg”,
* “număr real”,
* “string-ul introdus nu este nici întreg, nici real”.

3p - Se dă un fișier text cu diverse cuvinte peste vocabularul {a,b,c,d}:
* 1p - Să se verifice câte cuvinte au un număr par de “a”-uri la început.
* 1p - Să se înlocuiască fiecare cuvânt care începe și se temină cu “b” cu lungimea lui.
* 1p - Să se concateneze toate cuvintele invalide (nu sunt cuvinte peste vocabularul dat) din fișier, dacă există.

4p - Se dă o parolă. Să se verifice dacă aceasta este strong sau nu. O parolă este strong dacă:
- conține măcar o dată unul dintre caracterele {#, $, %}
- are măcar o literă mare în componența sa
- are lungimea de minim 10 caractere
- are minim 2 cifre una lângă alta

Se acordă 1p din oficiu!

Observație: Este obligatorie utilizarea expresiilor regulate (REGEX)

***

Source.cpp
```cpp
#include <iostream>
#include <fstream>
#include <regex>
#include <set>
#include <string>

static const std::string FILE_PATH_NUMBERS = "inputs\\numbers.txt";
static const std::string FILE_PATH_WORDS = "inputs\\words.txt";
static const std::string FILE_PATH_PASSWORDS = "inputs\\passwords.txt";

std::vector<std::string> GetDataFromFile(const std::string& path) {
	std::ifstream file(path);
	if (!file.is_open()) {
		std::cout << "Could not open file from path: " << path << std::endl;
		return {};
	}

	std::vector<std::string> fileLines;
	for (std::string line; getline(file, line); fileLines.emplace_back(line));

	if (fileLines.empty()) {
		std::cout << "File si empty. . ." << std::endl;
	}

	return fileLines;
}

std::string IntegerOrRealNumberChecking(const std::string& input) {
	std::regex realNumberPattern(R"(0|-?[0-9][0-9]*\.[0-9]*?)"); // Do not know why this matches 0.0 as real.
	std::regex integerNumberPattern(R"(0|-?\+?[1-9][0-9]*)");

	bool isReal = std::regex_match(input, realNumberPattern);
	bool isInteger = std::regex_match(input, integerNumberPattern);

	return "Input: " + input + " is " + (isInteger ? "INTEGER" : (isReal ? "REAL" : "NEITHER"));
}

int CountWordsStartingWithEvenNumberOfTargetChar(std::vector<std::string>& words, const char& target = 'a') {
	int count = 0;
	std::string rawPattern = "(" + std::string{ target } + std::string{ target } + ")+[a-z]*";
	std::regex evenNumberOfTargetCharAtBeginningPattern(rawPattern);

	for (auto& word : words) {
		if (std::regex_match(word, evenNumberOfTargetCharAtBeginningPattern)) {
			std::cout << "Matched " << word << std::endl;
			++count;
		}
	}

	return count;
}

void ReplaceWordsStartingAndEndingWithTargetCharWithLength(std::vector<std::string>& words, const char& target = 'b') {
	std::string rawPattern = std::string{ target } + "([A-Z]*[a-z]*)*" + std::string{ target };
	std::regex wordsStartingAndEndingWithTargetCharPattern(rawPattern);

	for (auto& word : words) {
		if (std::regex_match(word, wordsStartingAndEndingWithTargetCharPattern)) {
			std::cout << word << " replaced with " << word.length() << std::endl;
			word = std::regex_replace(word, wordsStartingAndEndingWithTargetCharPattern, std::to_string(word.length()));
		}
	}
}

std::string ConcatenatedInvalidWords(std::vector<std::string>& words) {
	std::string concattedInvalidWords;
	const std::set<char> alphabet = { 'a', 'b', 'c', 'd' };

	for (auto& word : words) {
		for (auto& ch : word) {
			if (alphabet.find(ch) == alphabet.end()) {
				std::cout << "Found invalid word: " << word << std::endl;
				concattedInvalidWords.append(word);
				break;
			}
		}
	}

	return concattedInvalidWords.empty() ? "N/A" : concattedInvalidWords;
}

bool PasswordIsValid(const std::string& password) {
	std::regex validPasswordPattern(R"((?=.*[a-z])(?=.*[A-Z])(?=.*([0-9][0-9])+)(?=.*[#$%])[A-Za-z0-9#$%]{10,})");

	return std::regex_match(password, validPasswordPattern);
}

// TESTS

void TestNumberChecker(const std::string& underTest) {
	std::vector<std::string> numbers = GetDataFromFile(underTest);

	for (auto& num : numbers) {
		std::cout << IntegerOrRealNumberChecking(num) << std::endl;
	}
}

void TestWordChecker(const std::string& underTest) {
	std::vector<std::string> words = GetDataFromFile(underTest);
	const char character = 'a';

	std::cout << "Count = " << CountWordsStartingWithEvenNumberOfTargetChar(words, character) << std::endl;
}

void TestWordReplacer(const std::string& underTest) {
	std::vector<std::string> words = GetDataFromFile(underTest);
	const char character = 'b';

	ReplaceWordsStartingAndEndingWithTargetCharWithLength(words, character);
}

void TestWordConcatenator(const std::string& underTest) {
	std::vector<std::string> words = GetDataFromFile(underTest);

	std::cout << "Invalid words: " << ConcatenatedInvalidWords(words) << std::endl;
}

void TestPasswordValidator(const std::string& underTest) {
	std::vector<std::string> passwords = GetDataFromFile(underTest);
	std::cout << R"(The password must:
	contain one of those characters: #, $, %
	have at least 1 capital letter
	have at least 1 capital letter
	be at least 10 characters long
	have at least 2 numbers next to eachother.)" << std::endl;

	for (auto& password : passwords) {
		if (!PasswordIsValid(password)) {
			std::cout << password << " is NOT valid." << std::endl;
		}
		else {
			std::cout << password << " is valid." << std::endl;
		}
	}
}

int main() {
	TestNumberChecker(FILE_PATH_NUMBERS);
	TestWordChecker(FILE_PATH_WORDS);
	TestWordReplacer(FILE_PATH_WORDS);
	TestWordConcatenator(FILE_PATH_WORDS);
	TestPasswordValidator(FILE_PATH_PASSWORDS);

	return EXIT_SUCCESS;
}
```

Tested inputs
```txt
0
1
-1
+1
-123.4
1.2345
0.0
0.0001
-0.999
12f
+0
-0
000000
0123456789
9876543210
```

```txt
password123
pa#ssWro23d2
BetterFasterStronger
T00$hort
G00dEnough?
Thi$shouldBeG00dEnough
```

```txt
aaaaaaaaaa
aaaaabbbbb
aaabbbbaaa
aaaccccaaa
aaaaaccccc
aaaaaddddd
aaaddddaaa
aaaaaeeeee
aaaeeeeaaa
abbbbbbbbb
accccccccc
addddddddd
aeeeeeeeee
bbbbbbbbbb
bbbbbaaaaa
bbbaaaabbb
bbbbbccccc
bbbccccbbb
bbbbbddddd
bbbddddbbb
bbbbbeeeee
bbbeeeebbb
baaaaaaaaa
bccccccccc
bddddddddd
beeeeeeeee
cccccccccc
cccccaaaaa
cccaaaaccc
cccccbbbbb
cccbbbbccc
cccccddddd
cccddddccc
ccccceeeee
ccceeeeccc
caaaaaaaaa
cbbbbbbbbb
cddddddddd
ceeeeeeeee
dddddddddd
dddddaaaaa
dddaaaaddd
dddddbbbbb
dddbbbbddd
dddddccccc
dddccccddd
dddddeeeee
dddeeeeddd
daaaaaaaaa
dbbbbbbbbb
dccccccccc
deeeeeeeee
eeeeeaaaaa
eeeeebbbbb
eeeeeccccc
eeeeeddddd
eeeeeeeeee
eaaaaaaaaa
ebbbbbbbbb
eccccccccc
eddddddddd
```