# Cyclic Redundancy Code

```cpp
/*
2. CRC (Cyclic Redundancy Code)

Se introduce un sir de caractere binare si un polinom generator (cu coeficienti 0 si 1)
Se fac urmatoarele verificari: sirurile sa fie binare si lungimea mesajului sa fie mai mare decat numarul de coeficienti ai polinomului generator.
Se extinde mesajul cu un numar de 0-uri egal cu gradul polinomului introdus.
Se efectueaza succesiv operatii de XOR intre mesajul extins si coeficientii polinomului pana cand lungimea restului obtinut este strict mai mica decat lungimea sirului de coeficienti. 
Se vor afisa rezultatele intermediare ale operatiei de XOR.
Se executa iarasi operatia de sau exclusiv intre mesajul extins si restul final obtinut, dar pozitionarea restului se va face sub finalul mesajului extins. Acest rezultat se va afisa.
*/

#include <iostream>
#include <string>

static bool IsBinaryString(const std::string& str) {
	if (str.empty()) {
		return false;
	}

	for (const char ch : str) {
		if (ch != '0' && ch != '1') {
			return false;
		}
	}

	return true;
}

static char BinaryCharXOR(const char& a, const char& b) {
	return a == b ? '0' : '1';
}

static void InitUserInput(std::string& message, std::string& polynomialCode) {
	bool valid = true;
	size_t degree = 0;

	std::cout << "Please input a binary message." << std::endl;
	do {
		std::cout << "Message: ";
		std::getline(std::cin, message);
		std::cout << "Polynomial code: ";
		std::getline(std::cin, polynomialCode);

		valid = true;
		degree = 0;

		if (message.empty()) {
			std::clog << "Message cannot be empty." << std::endl;
			valid = false;
		}

		if (polynomialCode.empty()) {
			std::clog << "Polynomial code cannot be empty." << std::endl;
			valid = false;
		}

		for (const char ch : message) {
			if (ch != '0' && ch != '1') {
				std::clog << "Message must contain only 0 and 1." << std::endl;
				valid = false;
				break;
			}
		}

		for (const char ch : polynomialCode) {
			if (ch != '0' && ch != '1') {
				std::clog << "Code must contain only 0 and 1." << std::endl;
				valid = false;
				break;
			}

			if (ch == '1') {
				degree++;
			}
		}

		if (message.length() <= polynomialCode.length()) {
			std::clog << "The length of the message must be greater than the code length." << std::endl;
			valid = false;
		}

		if (message.length() <= degree) {
			std::clog << "The lenght of the message must be greater than the number of coefficients in the code." << std::endl;
			valid = false;
		}

	} while (!valid);

	message = message.substr(message.find('1'));
	polynomialCode = polynomialCode.substr(polynomialCode.find('1'));
	message.append(degree, '0');
	std::clog << 
		"Message = " << message << '\n' << 
		"Code = " << polynomialCode << std::endl;
}

static std::string Remainder(const std::string& message, const std::string& code) {
	std::string currentMessage = message;
	std::string remainder;

	while (currentMessage.length() >= code.length()) {
		std::cout << currentMessage << " XOR\n" << code << "\n= " << std::endl;

		for (size_t i = 0; i < code.length(); ++i) {
			currentMessage.at(i) = BinaryCharXOR(currentMessage.at(i), code.at(i));
		}

		currentMessage = currentMessage.substr(currentMessage.find('1'));
		std::cout << currentMessage << std::endl;
		std::cout << "-------------------------" << std::endl;
	}

	remainder = currentMessage;
	std::clog << 
		"Message = " << message << '\n' << 
		"Remainder = " << remainder << std::endl;

	return remainder;
}

static std::string BinaryStringsXOR(const std::string& str1, const std::string& str2) {

	if (!IsBinaryString(str1) || !IsBinaryString(str2)) {
		return "";
	}

	std::string result = "";
	int maxLength = std::max(str1.length(), str2.length());

	std::string left = std::string(maxLength - str1.length(), '0') + str1;
	std::string right = std::string(maxLength - str2.length(), '0') + str2;

	for (int i = maxLength - 1; i >= 0; --i) {
		char currentBit = BinaryCharXOR(left[i], right[i]);
		result = currentBit + result;
	}

	return result;
}

static void TestCRC() {
	std::string message;
	std::string code;
	std::string remainder;
	std::string result;

	InitUserInput(message, code);
	remainder = Remainder(message, code);
	result = BinaryStringsXOR(message, remainder);
	std::cout << "Result = " << result << std::endl;
}
```