# Client Server

```cpp
/*
Sa se implementeze aplicatiile prezentate mai jos.
Limbajul de programare este la latitudinea dumneavoastra.
 
Se creaza o aplicatie de tip client si una de tip server.
Acestea vor comunica, la stabilirea conexiunii, pentru a stabili o cheie secreta "K" prin metoda Diffie-Hellman[1] pentru a fi folosita la pasii urmatori. 
Se doreste transmiterea primelor 5 paragrafe din "Lorem Ipsum"[2] de la client la server.
Acest mesaj va fi criptat de catre client inainte de transmitere prin cel putin una din urmatoarele metode:
- Caesar Cipher [3]
- Polybius Cipher (Metoda 3) [4]
- Enigma Machine [5]
- Orice alt algoritm de criptare bazat pe cheia numerica stabilita
Ulterior transmiterii, serverul va afisa pe ecran mesajul primit (criptat) iar apoi cel decriptat.
 
Note:
- Valorile generate de client/server pentru generarea cheii secrete pot fi aleatoare, dar cele publice vor fi hardcodate
- Textul lorem ipsum contine atat litere mici si litere mari. Se poate folosi o functie de "lowercase" sau "uppercase" pe intreg textul.
- Textul lorem ipsum contine de asemena semne de punctuatie si spatii. Acestea NU vor fi eliminate.
- Daca Polybius este ales, iar cheia generata este una para, adaugam sau scadem 1.
- Daca Enigma este aleasa, trebuie gasita o metoda pentru a transforma din numar in configurare.
*/
```

Client

```cpp
#include <WinSock2.h>
#include <WS2tcpip.h>

#pragma comment(lib, "ws2_32.lib")

#include "Utils.hpp"

class Client {
public:
	Client(const std::string& serverIp, int port);
	~Client();

	void ConnectToServer();
	void SendMessageToServer(const std::string& message);
	std::string GetMessageFromServer();
	void Disconnect();

private:
	int m_base;
	int m_prime;
	long long m_sharedSecret;
	int m_port;
	std::string m_serverIp;
	SOCKET m_serverSocket;
};

Client::Client(const std::string& serverIp, int port) : m_base{ 0 }, m_prime{ 0 }, m_sharedSecret{ 0 }, m_port{ port }, m_serverIp{ serverIp }, m_serverSocket{ INVALID_SOCKET } {
	WSADATA wsData;
	WORD ver = MAKEWORD(2, 2);
	int wsResult = WSAStartup(ver, &wsData);
	if (wsResult != 0) {
		throw std::runtime_error("Client :: [E] Cannot start Winsock :: ERRA" + std::to_string(wsResult));
	}
}

Client::~Client() {
	Disconnect();
	WSACleanup();
}

void Client::ConnectToServer() {
	m_serverSocket = socket(AF_INET, SOCK_STREAM, 0);
	if (m_serverSocket == INVALID_SOCKET) {
		throw std::runtime_error("Client :: [E] Cannot create socket :: ERRA" + std::to_string(WSAGetLastError()));
	}

	sockaddr_in hint;
	hint.sin_family = AF_INET;
	hint.sin_port = htons(m_port);
	inet_pton(AF_INET, m_serverIp.data(), &hint.sin_addr);

	int connectResult = connect(m_serverSocket, (sockaddr*)&hint, sizeof(hint));
	if (connectResult == SOCKET_ERROR) {
		throw std::runtime_error("Client :: [E] Cannot connect to server :: ERRA" + std::to_string(WSAGetLastError()));
	}

	recv(m_serverSocket, (char*)&m_prime, sizeof(m_prime), 0);
	std::cout << "Client :: [I] Received prime: " << m_prime << std::endl;

	recv(m_serverSocket, (char*)&m_base, sizeof(m_base), 0);
	std::cout << "Client :: [I] Received base: " << m_base << std::endl;

	long long serverPublicKey{};
	recv(m_serverSocket, (char*)&serverPublicKey, sizeof(serverPublicKey), 0);
	std::cout << "Client :: [I] Received server public key: " << serverPublicKey << std::endl;

	long long clientPrivateKey = DHUtils::GetRandom() % m_prime;
	std::cout << "Client :: [D] Private key: " << clientPrivateKey << std::endl;

	long long clientPublicKey = DHUtils::DiffieHellman(m_base, clientPrivateKey, m_prime);
	std::cout << "Client :: [D] Public key: " << clientPublicKey << std::endl;

	std::cout << "Client :: [I] Sent public key: " << clientPublicKey << std::endl;
	send(m_serverSocket, (char*)&clientPublicKey, sizeof(clientPublicKey), 0);

	m_sharedSecret = DHUtils::DiffieHellman(serverPublicKey, clientPrivateKey, m_prime);
	std::cout << "Client :: [D] Shared secret: " << m_sharedSecret << std::endl;
	std::cout << "Client :: [D] Encrypt using: " << m_sharedSecret % 26 << std::endl;
}

void Client::SendMessageToServer(const std::string& message) {
	int shift = m_sharedSecret % CCypher::LETTERS_COUNT;
	std::cout << "Client :: [D] Encrypting . . ." << std::endl;
	std::string encryptedMessage = CCypher::GetEncrypted(message, shift);

	std::cout << "Client :: [I] Sent encrypted message: " << encryptedMessage << std::endl;
	int sendResult = send(m_serverSocket, encryptedMessage.data(), encryptedMessage.size() + 1, 0);
	if (sendResult == SOCKET_ERROR) {
		throw std::runtime_error("Client :: [E] Cannot send message to server :: ERRA" + std::to_string(WSAGetLastError()));
	}
}

std::string Client::GetMessageFromServer() {
	char buffer[8 * BUFSIZ];
	ZeroMemory(buffer, 8 * BUFSIZ);
	int recvBytes = recv(m_serverSocket, buffer, 8 * BUFSIZ, 0);
	if (recvBytes > 0) {
		return std::string(buffer, 0, recvBytes);
	}
	return {};
}

void Client::Disconnect() {
	closesocket(m_serverSocket);
}
int main() {
	try {
		Client client("127.0.0.1", 54000);
		client.ConnectToServer();

		std::string userInput;
		do {
			std::cout << "~ Client> ";
			std::getline(std::cin, userInput);

			if (StringUtils::ToLowerCase(userInput) == "exit") {
				std::cout << "~ System> Are you sure you want to exit? Type 'y' to exit." << std::endl;
				std::cout << "~ Client> ";
				std::string userExit;
				std::getline(std::cin, userExit);

				if (StringUtils::ToLowerCase(userExit) == "y") {
					break;
				}
				else {
					continue;
				}
			}

			if (StringUtils::ToLowerCase(userInput) == "lorem") {
				std::string lorem = StringUtils::GetFiveLoremParagraphs();
				client.SendMessageToServer(lorem);
				std::string loremResponse = client.GetMessageFromServer();
				std::cout << "~ Sever> " << loremResponse << std::endl;
				continue;
			}

			if (!userInput.empty()) {

				client.SendMessageToServer(userInput);
				std::string response = client.GetMessageFromServer();

				if (!response.empty()) {
					std::cout << "~ Sever> " << response << std::endl;
				}
			}

		} while (!userInput.empty());

	}
	catch (const std::exception& e) {
		std::cerr << "Client :: [EX] Main thread " << e.what() << std::endl;
	}

	return EXIT_SUCCESS;
}
```

Server

```cpp
#include <WinSock2.h>
#include <WS2tcpip.h>

#pragma comment(lib, "ws2_32.lib")

#include "../ClientGL/Utils.hpp"

#include <thread>

class Server {
public:
	Server(const int port);
	~Server();

	void Start();

	void Stop();

private:
	void _handleClient(SOCKET client);
	void _clientHandler(SOCKET client);

private:
	int m_base;
	int m_prime;
	int m_port;
	bool m_running;
	SOCKET m_listening;
	std::vector<std::thread> m_clientThreads;
};

Server::Server(const int port) : m_base{ 0 }, m_prime{ 0 }, m_port{ port }, m_running{ false }, m_listening{ INVALID_SOCKET }, m_clientThreads{ std::vector<std::thread>() } {
	WSADATA wsData;
	WORD ver = MAKEWORD(2, 2);
	int wsResult = WSAStartup(ver, &wsData);
	if (wsResult != 0) {
		throw std::runtime_error("Server :: [E] Cannot start Winsock :: ERRA" + std::to_string(wsResult));
	}

	m_base = DHUtils::GetRandomPrime();
	m_prime = DHUtils::GetRandomPrime();
	std::cout << "Server :: [I] Initialized variables { base : " << m_base << " }, { prime : " << m_prime << " }" << std::endl;
}

Server::~Server() {
	Stop();
	WSACleanup();
}

void Server::Start() {
	m_listening = socket(AF_INET, SOCK_STREAM, 0);
	if (m_listening == INVALID_SOCKET) {
		throw std::runtime_error("Server :: [E] Cannot create socker :: ERRA" + std::to_string(WSAGetLastError()));
	}

	sockaddr_in hint{};
	hint.sin_family = AF_INET;
	hint.sin_port = htons(m_port);
	hint.sin_addr.S_un.S_addr = INADDR_ANY;

	if (bind(m_listening, (sockaddr*)&hint, sizeof(hint)) == SOCKET_ERROR) {
		throw std::runtime_error("Server :: [E] Failed bind step :: ERRA" + std::to_string(WSAGetLastError()));
	}

	if (listen(m_listening, SOMAXCONN) == SOCKET_ERROR) {
		throw std::runtime_error("Server :: [E] Failed listen step :: ERRA" + std::to_string(WSAGetLastError()));
	}

	m_running = true;

	while (m_running) {
		sockaddr_in client{};
		int clientSize = sizeof(client);
		SOCKET clientSock = accept(m_listening, (sockaddr*)&client, &clientSize);

		if (clientSock != INVALID_SOCKET) {
			m_clientThreads.emplace_back(std::thread(&Server::_clientHandler, this, clientSock));
		}
	}
}

void Server::Stop() {
	m_running = false;
	closesocket(m_listening);
	for (std::thread& th : m_clientThreads) {
		if (th.joinable()) {
			th.join();
		}
	}
	std::cout << "Server :: [I] Stopping server" << std::endl;
}

void Server::_handleClient(SOCKET clientSocket) {
	std::cout << "Server :: [I] New client connected" << std::endl;

	int serverPrivateKey = DHUtils::GetRandom() % m_prime;
	std::cout << "Server :: [D] Private key: " << serverPrivateKey << std::endl;

	long long serverPublicKey = DHUtils::DiffieHellman(m_base, serverPrivateKey, m_prime);
	std::cout << "Server :: [D] Public key: " << serverPublicKey << std::endl;

	std::cout << "Server :: [I] Sent prime: " << m_prime << std::endl;
	send(clientSocket, (char*)&m_prime, sizeof(m_prime), 0);

	std::cout << "Server :: [I] Sent base: " << m_base << std::endl;
	send(clientSocket, (char*)&m_base, sizeof(m_base), 0);
	
	std::cout << "Server :: [I] Sent public key: " << serverPublicKey << std::endl;
	send(clientSocket, (char*)&serverPublicKey, sizeof(serverPublicKey), 0);

	long long clientPublicKey{};
	recv(clientSocket, (char*)&clientPublicKey, sizeof(clientPublicKey), 0);
	std::cout << "Server :: [I] Received client public key: " << clientPublicKey << std::endl;

	long long sharedSecret = DHUtils::DiffieHellman(clientPublicKey, serverPrivateKey, m_prime);
	std::cout << "Server :: [D] Shared secret: " << sharedSecret << std::endl;

	int shift = sharedSecret % CCypher::LETTERS_COUNT;
	std::cout << "Server :: [D] Decrypt using " << shift << std::endl;

	char buff[8 * BUFSIZ];
	while (true) {
		ZeroMemory(buff, 8 * BUFSIZ);
		int bytesRecv = recv(clientSocket, buff, 8 * BUFSIZ, 0);
		std::cout << "Server :: [I] Received encrypted message: " << std::string(buff, 0, bytesRecv) << std::endl;

		if (bytesRecv == SOCKET_ERROR || bytesRecv == 0) {
			std::cout << "Server :: [I] Client[" << clientPublicKey << "] disconnected" << std::endl;
			break;
		}

		std::cout << "Server :: [D] Decrypting . . ." << std::endl;
		std::string decryptedMessage = CCypher::GetDecrypted(std::string(buff, 0, bytesRecv), shift);

		std::cout << "Server :: [I] Decrypted Client[" << clientPublicKey << "] message: " << decryptedMessage << std::endl;
		send(clientSocket, buff, bytesRecv + 1, 0);
	}

	closesocket(clientSocket);
}

void Server::_clientHandler(SOCKET clientSocket) {
	_handleClient(clientSocket);
}


int main() {
	try {
		Server server(54000);
		server.Start();
	}
	catch (const std::exception& e) {
		std::cerr << "Server :: [EX] Main thread " << e.what() << std::endl;
	}
}

```

Utils

```cpp
#pragma once

#include <iostream>
#include <string>
#include <cmath>
#include <random>



#pragma region StringUtils

class StringUtils {
public:
	static std::string ToLowerCase(const std::string& str);

	static std::string GetFiveLoremParagraphs() {
		return R"(
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae elementum curabitur vitae nunc. Ac felis donec et odio pellentesque. Consectetur adipiscing elit ut aliquam purus sit amet luctus venenatis. Tincidunt tortor aliquam nulla facilisi cras fermentum odio eu feugiat. Eget duis at tellus at urna condimentum. Pulvinar elementum integer enim neque volutpat ac tincidunt. Vitae congue mauris rhoncus aenean. Quam lacus suspendisse faucibus interdum posuere lorem. Nulla facilisi nullam vehicula ipsum a arcu cursus. Aenean et tortor at risus viverra adipiscing at. Ut aliquam purus sit amet luctus venenatis lectus magna. Turpis egestas pretium aenean pharetra magna ac placerat vestibulum. Varius vel pharetra vel turpis nunc eget lorem. Id neque aliquam vestibulum morbi blandit cursus risus. Sit amet facilisis magna etiam tempor orci eu.

Dolor magna eget est lorem ipsum dolor sit. Non diam phasellus vestibulum lorem sed. Nulla pellentesque dignissim enim sit amet venenatis urna. Augue mauris augue neque gravida. Euismod elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Bibendum arcu vitae elementum curabitur vitae nunc sed velit dignissim. Magna etiam tempor orci eu lobortis elementum nibh tellus molestie. In ornare quam viverra orci sagittis eu. Eu non diam phasellus vestibulum lorem sed risus. Turpis tincidunt id aliquet risus.

Dolor sit amet consectetur adipiscing elit ut. Auctor neque vitae tempus quam pellentesque nec nam aliquam. Tempor nec feugiat nisl pretium fusce id. Nisi lacus sed viverra tellus in hac habitasse. Turpis egestas maecenas pharetra convallis posuere. Orci sagittis eu volutpat odio facilisis mauris sit amet. Orci nulla pellentesque dignissim enim sit amet venenatis. Viverra aliquet eget sit amet tellus cras adipiscing. Massa tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada. Arcu risus quis varius quam. Risus ultricies tristique nulla aliquet enim tortor at auctor urna.

Arcu dictum varius duis at. Morbi tristique senectus et netus et malesuada fames ac turpis. Aliquet enim tortor at auctor urna nunc id cursus metus. Sem fringilla ut morbi tincidunt augue interdum velit. Venenatis urna cursus eget nunc scelerisque viverra mauris in aliquam. Urna condimentum mattis pellentesque id nibh tortor id aliquet. Ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Gravida dictum fusce ut placerat orci nulla. Urna condimentum mattis pellentesque id nibh tortor. Aenean euismod elementum nisi quis eleifend quam adipiscing vitae proin. Urna et pharetra pharetra massa massa ultricies mi quis. Felis imperdiet proin fermentum leo. Nam libero justo laoreet sit amet cursus sit amet.

Consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Sollicitudin tempor id eu nisl. Amet facilisis magna etiam tempor. Tincidunt vitae semper quis lectus. Faucibus interdum posuere lorem ipsum dolor sit amet consectetur adipiscing. Id cursus metus aliquam eleifend mi in. In mollis nunc sed id semper risus in hendrerit. Tristique senectus et netus et malesuada fames. Volutpat est velit egestas dui id ornare arcu. Urna et pharetra pharetra massa massa. In cursus turpis massa tincidunt dui.)";
	}

};

std::string StringUtils::ToLowerCase(const std::string& str) {
	std::string lowerStr = str;
	std::transform(lowerStr.begin(), lowerStr.end(), lowerStr.begin(),
		[](unsigned char ch) {
			return std::tolower(ch);
		}
	);
	return lowerStr;
}

#pragma endregion



#pragma region DHUtils

class DHUtils {
public:
	static bool IsPrime(int number);
	static int GetRandom();
	static int GetRandomPrime();
	static long long int DiffieHellman(long long int a, long long int b, long long int p);
};

bool DHUtils::IsPrime(int number) {
	if (number <= 1) {
		return false;
	}

	if (number == 2) {
		return true;
	}

	if (number % 2 == 0) {
		return false;
	}

	for (int i = 3; i * i <= number; i += 2) {
		if (number % i == 0) {
			return false;
		}
	}
	return true;
}

int DHUtils::GetRandom() {
	std::random_device rd;
	std::mt19937 gen(rd());
	std::uniform_int_distribution<> dis(2, INT_MAX);
	return dis(gen);
}

int DHUtils::GetRandomPrime() {
	int randomNumber = GetRandom();
	while (!(IsPrime(randomNumber))) {
		++randomNumber;
	}
	return randomNumber;
}

long long int DHUtils::DiffieHellman(long long int base, long long int expo, long long int mod) {
	long long result = 1;
	base = base % mod;
	while (expo > 0) {
		if (expo % 2 == 1) {
			result = (result * base) % mod;
		}
		expo = expo >> 1;
		base = (base * base) % mod;
	}
	return result;
}

#pragma endregion 



#pragma region CCypher

class CCypher {
public:
	constexpr static const int LETTERS_COUNT = 26;

public:
	static std::string GetEncrypted(const std::string& message, int shift);
	static std::string GetDecrypted(const std::string& message, int shift);
};

std::string CCypher::GetEncrypted(const std::string& message, int shift) {
	std::string encryptedMessage = message;

	for (char& ch : encryptedMessage) {
		if (isalpha(ch)) {
			char base = islower(ch) ? 'a' : 'A';
			ch = (ch - base + shift) % LETTERS_COUNT + base;
		}
	}

	return encryptedMessage;
}

std::string CCypher::GetDecrypted(const std::string& message, int shift) {
	std::string decryptedMessage = message;

	for (char& ch : decryptedMessage) {
		if (isalpha(ch)) {
			char base = islower(ch) ? 'a' : 'A';
			ch = (ch - base - shift + LETTERS_COUNT) % LETTERS_COUNT + base;
		}
	}

	return decryptedMessage;
}


#pragma endregion

```