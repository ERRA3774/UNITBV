# Token Ring

```txt
Token Ring
 
Se simuleaza 6 calculatoare ('A','B','C','D','E','F') conectate ciclic printr-un "Token Ring", in aceasta ordine. (Calculatoarele pot fi hardcodate)
Se introduce de la tastatura/fisier date pe care calculatoarele vor sa le trimita pe retea. 
Se creaza un token care va circula prin retea pana cand trebuie sa transporte date. (calculatoarele ridica un flag)
Se simuleaza urmatoarele transferuri de date: C->E, F->B, A->D, E->A, B->C, D->F, unde flagurile sunt ridicate in aceasta ordine.
Se doreste afisarea mesajelor atat la transferul de date catre token cat si la sosirea acestuia la un potential destinatar.
Indicatie: OOP
```

https://github.com/ERRA3774/UNITBV/assets/93817419/3030a94e-afe6-4ee6-9b90-93b1ea43612a


Source.cpp

```cpp
#include "Headers/TokenRingWindow.h"

int main(void) {

	TokenRingWindow window;

	window.OnCreate();

	return 0;
}
```

Computer.h

```cpp
#pragma once

#include <fstream>
#include <iostream>

#include "../Headers/Token.h"

class Computer {
public:

	Computer();

	std::string GetIp() const;

	std::string GetMessage() const;

	void FetchSecretMessageFromFile(const std::string& path);

private:

	std::string GenerateRandomIp();

private:
	std::string _ip;
	std::string _message;
	bool _hasToken;

};
```

Computer.cpp

```cpp
#include "../Headers/Computer.h"

Computer::Computer() {
	_ip = GenerateRandomIp();
	_message = std::string();
	_hasToken = false;
}

std::string Computer::GetIp() const {
	return _ip;
}

std::string Computer::GetMessage() const {
	return _message;
}

void Computer::FetchSecretMessageFromFile(const std::string& path) {
	std::ifstream fin(path);

	if (!fin.is_open()) {
		std::clog << "[W] Computer at [ " << GetIp() << " ] could not open file from path: " << path << std::endl;
		return;
	}

	std::string fileMessage;
	while (fin) {
		std::string line;
		std::getline(fin, line);

		if (line.empty()) {
			continue;
		}

		line += '\n';
		fileMessage.append(line);
	}

	_message = fileMessage;
}

std::string Computer::GenerateRandomIp() {
	std::string ipAddress;

	for (int i = 0; i < 4; ++i) {
		int randomByte = rand() % 256;
		ipAddress += std::to_string(randomByte);
		if (i < 3) {
			ipAddress += ".";
		}
	}

	return ipAddress;
}
```

Token.h

```cpp

#pragma once

#include <string>

class Token {
public:
	std::string Sender;
	std::string Destination;
	std::string Message;

	Token();
	Token(std::string sender, std::string destination, std::string message);
};

```

Token.cpp

```cpp

#include "../Headers/Token.h"

Token::Token() : Sender(std::string()), Destination(std::string()), Message(std::string()) {}

Token::Token(std::string sender, std::string destination, std::string message) : Sender(sender), Destination(destination), Message(message) {}

```

TokenRing.h

```cpp

#pragma once

#include <vector>
#include <queue>
#include <unordered_map>

#include "../Headers/Token.h"
#include "../Headers/Computer.h"

class TokenRing
{
public:
	bool SenderFlag;
	bool DestinationFlag;
	Token CurrentToken;
	std::queue<Token> Tokens;
	std::vector<Computer> Computers;

	TokenRing();
	TokenRing(std::initializer_list<Computer> computers, std::initializer_list<Token> tokens);

	void NextToken();
};

```

TokenRing.cpp

```cpp

#include "../Headers/TokenRing.h"

TokenRing::TokenRing() :
	Computers(std::vector<Computer>()),
	Tokens(std::queue<Token>()),
	SenderFlag(false),
	DestinationFlag(false) {}

TokenRing::TokenRing(std::initializer_list<Computer> computers, std::initializer_list<Token> tokens) :
	Computers(computers), Tokens(tokens), SenderFlag(false), DestinationFlag(false) {
	CurrentToken = Tokens.front();
}

void TokenRing::NextToken() {
	Tokens.pop();
}

```

TokenRingWindow.h

```cpp

#pragma once

#include <iostream>
#include <vector>
#include <string>
#include <ctime>
#include <queue>
#include <fstream>

#include <raylib.h>

#include "../Utils/Constants.h"
#include "../Headers/TokenRing.h"

class TokenRingWindow
{
public:
	TokenRingWindow();

	void OnCreate();
};

```

TokenRingWindow.cpp

```cpp

#include "../Headers/TokenRingWindow.h"

TokenRingWindow::TokenRingWindow() {}

void TokenRingWindow::OnCreate() {

	// Initialization
	//--------------------------------------------------------------------------------------
	InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Token Ring Network Visualization");


	srand(static_cast<unsigned>(time(NULL)));
	bool paused = false;
	bool senderCollision = false;
	bool destinationCollision = false;

	float moonAngle = 0.0f;
	float starAngle = 0.0f;

	int textSize = MeasureText(LOG_TEXT, PRIMARY_FONT_SIZE);
	int textGuiX = GUI_RECT_X + textSize / static_cast<float>(2);

	int stateTextY = GUI_RECT_Y + 50;

	int senderLabelY = GUI_RECT_Y + 140;
	int senderTextY = senderLabelY + 50;

	int destinationLabelY = GUI_RECT_Y + 240;
	int destinationTextY = destinationLabelY + 50;

	int compALabelY = GUI_RECT_Y + 360;
	int compATextY = compALabelY + 30;

	int compBLabelY = GUI_RECT_Y + 420;
	int compBTextY = compBLabelY + 30;

	int compCLabelY = GUI_RECT_Y + 480;
	int compCTextY = compCLabelY + 30;

	int compDLabelY = GUI_RECT_Y + 540;
	int compDTextY = compDLabelY + 30;

	int compELabelY = GUI_RECT_Y + 600;
	int compETextY = compELabelY + 30;

	int compFLabelY = GUI_RECT_Y + 660;
	int compFTextY = compFLabelY + 30;

	const char* stateText = SEARCHING_STATE_TEXT;

	double previousTime = GetTime();

	std::vector<Vector2> starPositions;

	for (int i = 0; i < STARS_COUNT; i++) {
		starPositions.push_back({ static_cast<float>(rand() % 1100), static_cast<float>(rand() % 1000) });
	}

	Color currentMoon = SILVER_MOON;

	Image earth = LoadImage(EARTH_IMG);
	Texture2D earthTexture = LoadTextureFromImage(earth);
	UnloadImage(earth);
	const float earthTextureX = EARTH_X - earthTexture.width / static_cast<float>(2);
	const float earthTextureY = EARTH_Y - earthTexture.height / static_cast<float>(2);

	Image moon = LoadImage(MOON_IMG);
	Texture2D moonTexture = LoadTextureFromImage(moon);
	UnloadImage(moon);

	Image satAImage = LoadImage(SAT_A_IMG);
	Texture2D satATexture = LoadTextureFromImage(satAImage);
	UnloadImage(satAImage);
	const float satATextureX = SAT_A_X - satATexture.width / static_cast<float>(2);
	const float satATextureY = SAT_A_Y - satATexture.height / static_cast<float>(2);

	Image satBImage = LoadImage(SAT_B_IMG);
	Texture2D satBTexture = LoadTextureFromImage(satBImage);
	UnloadImage(satBImage);

	const float satBTextureX = SAT_B_X - satBTexture.width / static_cast<float>(2);
	const float satBTextureY = SAT_B_Y - satBTexture.height / static_cast<float>(2);

	Image satCImage = LoadImage(SAT_C_IMG);
	Texture2D satCTexture = LoadTextureFromImage(satCImage);
	UnloadImage(satCImage);

	const float satCTextureX = SAT_C_X - satCTexture.width / static_cast<float>(2);
	const float satCTextureY = SAT_C_Y - satCTexture.height / static_cast<float>(2);

	Image satDImage = LoadImage(SAT_D_IMG);
	Texture2D satDTexture = LoadTextureFromImage(satDImage);
	UnloadImage(satDImage);

	const float satDTextureX = SAT_D_X - satDTexture.width / static_cast<float>(2);
	const float satDTextureY = SAT_D_Y - satDTexture.height / static_cast<float>(2);

	Image satEImage = LoadImage(SAT_E_IMG);
	Texture2D satETexture = LoadTextureFromImage(satEImage);
	UnloadImage(satEImage);

	const float satETextureX = SAT_E_X - satETexture.width / static_cast<float>(2);
	const float satETextureY = SAT_E_Y - satETexture.height / static_cast<float>(2);

	Image satFImage = LoadImage(SAT_F_IMG);
	Texture2D satFTexture = LoadTextureFromImage(satFImage);
	UnloadImage(satFImage);
	const float satFTextureX = SAT_F_X - satFTexture.width / static_cast<float>(2);
	const float satFTextureY = SAT_F_Y - satFTexture.height / static_cast<float>(2);

	Rectangle netContainer = {
		NET_RECT_X,
		NET_RECT_Y,
		NET_RECT_WIDTH,
		NET_RECT_HEIGHT,
	};

	Rectangle guiContainer = {
		GUI_RECT_X,
		GUI_RECT_Y,
		GUI_RECT_WIDTH,
		GUI_RECT_HEIGHT
	};

	Rectangle satA = {
		SAT_A_X,
		SAT_A_Y,
		satATexture.width,
		satATexture.height
	};

	Rectangle satB = {
		SAT_B_X,
		SAT_B_Y,
		satBTexture.width,
		satBTexture.height
	};

	Rectangle satC = {
		SAT_C_X,
		SAT_C_Y,
		satCTexture.width,
		satCTexture.height
	};

	Rectangle satD = {
		SAT_D_X,
		SAT_D_Y,
		satDTexture.width,
		satDTexture.height
	};

	Rectangle satE = {
		SAT_E_X,
		SAT_E_Y,
		satETexture.width,
		satETexture.height
	};

	Rectangle satF = {
		SAT_F_X,
		SAT_F_Y,
		satFTexture.width,
		satFTexture.height
	};

	Rectangle currentSender = {
		0.0f,
		0.0f,
		0.0f,
		0.0f
	};

	Rectangle currentDestination = {
		0.0f,
		0.0f,
		0.0f,
		0.0f
	};



	Computer compA;
	Computer compB;
	Computer compC;
	Computer compD;
	Computer compE;
	Computer compF;

	compA.FetchSecretMessageFromFile(SAT_A_MSG);
	compB.FetchSecretMessageFromFile(SAT_B_MSG);
	compC.FetchSecretMessageFromFile(SAT_C_MSG);
	compD.FetchSecretMessageFromFile(SAT_D_MSG);
	compE.FetchSecretMessageFromFile(SAT_E_MSG);
	compF.FetchSecretMessageFromFile(SAT_F_MSG);

	Token token1(compC.GetIp(), compE.GetIp(), compC.GetMessage());
	Token token2(compF.GetIp(), compB.GetIp(), compF.GetMessage());
	Token token3(compA.GetIp(), compD.GetIp(), compA.GetMessage());
	Token token4(compE.GetIp(), compA.GetIp(), compE.GetMessage());
	Token token5(compB.GetIp(), compC.GetIp(), compB.GetMessage());
	Token token6(compD.GetIp(), compF.GetIp(), compA.GetMessage());

	std::initializer_list<Computer> computers = { compA, compB, compC, compD, compE, compF };
	std::initializer_list<Token> tokens = { token1, token2, token3, token4, token5, token6 };

	TokenRing network(computers, tokens);

	std::unordered_map<std::string, Rectangle> Satellites;

	Satellites[compA.GetIp()] = satA;
	Satellites[compB.GetIp()] = satB;
	Satellites[compC.GetIp()] = satC;
	Satellites[compD.GetIp()] = satD;
	Satellites[compE.GetIp()] = satE;
	Satellites[compF.GetIp()] = satF;

	SetTargetFPS(144);               // Run at 144 frames-per-second
	//--------------------------------------------------------------------------------------

	// Main game loop
	while (!WindowShouldClose())    // Detect window close button or ESC key
	{
		// Update
		//----------------------------------------------------------------------------------



		// Input
		switch (GetKeyPressed()) {
		case KEY_SPACE:
			paused = !paused;
			break;
		default:
			break;
		}

		// Input



		// Delta Time
		double currentTime = GetTime();
		double deltaTime = currentTime - previousTime;
		previousTime = currentTime;
		// Delta Time



		// Stars positions
		starAngle += STEP_UNIT * deltaTime;
		for (Vector2& star : starPositions) {
			star.x += 0.1f * cosf(starAngle);
			star.y += 0.1f * sinf(starAngle);
		}
		//


		// Moon orbit
		Vector2 moonPosition{};
		moonPosition.x = EARTH_X + MOON_DISTANCE * cosf(moonAngle);
		moonPosition.y = EARTH_Y + MOON_DISTANCE * sinf(moonAngle);

		if (!paused) {
			moonAngle += STEP_UNIT * deltaTime;
		}

		Rectangle moonBounds = { moonPosition.x, moonPosition.y, moonTexture.width, moonTexture.height };
		// Moon orbit


		// Token Ring
		if (network.SenderFlag == false) {
			currentSender = Satellites[network.CurrentToken.Sender];
			currentDestination = Satellites[network.CurrentToken.Destination];
		}

		if (CheckCollisionRecs(moonBounds, currentSender) && network.SenderFlag == false) {
			std::cout << "Satellite " << network.CurrentToken.Sender << " wants to send message to " << network.CurrentToken.Destination << std::endl;
			std::cout << "The message reads: " << network.CurrentToken.Message << std::endl;
			currentMoon = BLOOD_MOON;
			network.SenderFlag = true;
			stateText = SENDING_STATE_TEXT;
		}

		if (CheckCollisionRecs(moonBounds, currentDestination) && network.SenderFlag == true && network.DestinationFlag == false) {
			std::cout << "Satellite " << network.CurrentToken.Destination << " received the message from " << network.CurrentToken.Sender << std::endl;
			std::cout << "The message reads: " << network.CurrentToken.Message << std::endl;
			currentMoon = BLUE_MOON;
			network.DestinationFlag = true;
			stateText = RETURNING_STATE_TEXT;
		}

		if (CheckCollisionRecs(moonBounds, currentSender) && network.SenderFlag == true && network.DestinationFlag == true) {
			network.SenderFlag = false;
			network.DestinationFlag = false;

			std::cout << "Sattelite " << network.CurrentToken.Sender << " received the confirmation.\n" << std::endl;
			network.NextToken();
			if (network.Tokens.empty()) {
				network.Tokens = std::queue<Token>(tokens);
			}
			network.CurrentToken = network.Tokens.front();
			currentMoon = SILVER_MOON;
			stateText = SEARCHING_STATE_TEXT;
		}

		//----------------------------------------------------------------------------------


		// Draw
		//----------------------------------------------------------------------------------
		BeginDrawing();

		ClearBackground(RAYWHITE);

		// Containers
		DrawRectangleRounded(netContainer, 0.01f, NULL, SPACE_VOID);
		DrawRectangleRounded(guiContainer, 0.01f, NULL, PRIMARY_BLUE);

		for (Vector2& star : starPositions) {
			DrawPixelV(star, WHITE);
		}

		// Earth and moon
		DrawTexture(earthTexture, earthTextureX, earthTextureY, SKYBLUE);
		DrawTexture(moonTexture, moonPosition.x - moonTexture.width / static_cast<float>(2), moonPosition.y - moonTexture.height / static_cast<float>(2), currentMoon);


		// Satellites
		DrawTexture(satATexture, satATextureX, satATextureY, LIGHTGRAY);
		DrawTexture(satBTexture, satBTextureX, satBTextureY, LIGHTGRAY);
		DrawTexture(satCTexture, satCTextureX, satCTextureY, LIGHTGRAY);
		DrawTexture(satDTexture, satDTextureX, satDTextureY, LIGHTGRAY);
		DrawTexture(satETexture, satETextureX, satETextureY, LIGHTGRAY);
		DrawTexture(satFTexture, satFTextureX, satFTextureY, LIGHTGRAY);



		// GUI

		DrawText(stateText, textGuiX, stateTextY, PRIMARY_FONT_SIZE, SILVER_MOON);

		DrawText(SENDER_LABEL_TEXT, textGuiX, senderLabelY, SECONDARY_FONT_SIZE, PRIMARY_BROWN);
		DrawText(network.CurrentToken.Sender.data(), textGuiX, senderTextY, TERTIARY_FONT_SIZE, SECONDARY_BROWN);

		DrawText(DESTINATION_LABEL_TEXT, textGuiX, destinationLabelY, SECONDARY_FONT_SIZE, PRIMARY_BROWN);
		DrawText(network.CurrentToken.Destination.data(), textGuiX, destinationTextY, TERTIARY_FONT_SIZE, SECONDARY_BROWN);

		DrawText(COMP_A_LABEL_TEXT, textGuiX, compALabelY, TERTIARY_FONT_SIZE, PRIMARY_BROWN);
		DrawText(compA.GetIp().data(), textGuiX, compATextY, QUARTERNARY_FONT_SIZE, SECONDARY_BROWN);

		DrawText(COMP_B_LABEL_TEXT, textGuiX, compBLabelY, TERTIARY_FONT_SIZE, PRIMARY_BROWN);
		DrawText(compB.GetIp().data(), textGuiX, compBTextY, QUARTERNARY_FONT_SIZE, SECONDARY_BROWN);

		DrawText(COMP_C_LABEL_TEXT, textGuiX, compCLabelY, TERTIARY_FONT_SIZE, PRIMARY_BROWN);
		DrawText(compC.GetIp().data(), textGuiX, compCTextY, QUARTERNARY_FONT_SIZE, SECONDARY_BROWN);

		DrawText(COMP_D_LABEL_TEXT, textGuiX, compDLabelY, TERTIARY_FONT_SIZE, PRIMARY_BROWN);
		DrawText(compD.GetIp().data(), textGuiX, compDTextY, QUARTERNARY_FONT_SIZE, SECONDARY_BROWN);

		DrawText(COMP_E_LABEL_TEXT, textGuiX, compELabelY, TERTIARY_FONT_SIZE, PRIMARY_BROWN);
		DrawText(compE.GetIp().data(), textGuiX, compETextY, QUARTERNARY_FONT_SIZE, SECONDARY_BROWN);

		DrawText(COMP_F_LABEL_TEXT, textGuiX, compFLabelY, TERTIARY_FONT_SIZE, PRIMARY_BROWN);
		DrawText(compF.GetIp().data(), textGuiX, compFTextY, QUARTERNARY_FONT_SIZE, SECONDARY_BROWN);

		DrawFPS(5, 5);

		EndDrawing();
		//----------------------------------------------------------------------------------
	}

	// De-Initialization
	//--------------------------------------------------------------------------------------
	CloseWindow();
	//--------------------------------------------------------------------------------------

}

```

Constants.h

```cpp

#pragma once

#include <cmath>
#include <raylib.h>

extern const int SCREEN_WIDTH;
extern const int SCREEN_HEIGHT;

extern const float NET_RECT_X;
extern const float NET_RECT_Y;
extern const float NET_RECT_WIDTH;
extern const float NET_RECT_HEIGHT;

extern const float EARTH_X;
extern const float EARTH_Y;

extern const float EARTH_RADIUS;
extern const float MOON_RADIUS;
extern const float MOON_DISTANCE;

extern const float STEP_UNIT;

extern const int STARS_COUNT;

extern const float SAT_A_X;
extern const float SAT_A_Y;
extern const float SAT_B_X;
extern const float SAT_B_Y;
extern const float SAT_C_X;
extern const float SAT_C_Y;
extern const float SAT_D_X;
extern const float SAT_D_Y;
extern const float SAT_E_X;
extern const float SAT_E_Y;
extern const float SAT_F_X;
extern const float SAT_F_Y;
extern const char* EARTH_IMG;
extern const char* MOON_IMG;

extern const char* SAT_A_IMG;
extern const char* SAT_B_IMG;
extern const char* SAT_C_IMG;
extern const char* SAT_D_IMG;
extern const char* SAT_E_IMG;
extern const char* SAT_F_IMG;

extern const char* SAT_A_MSG;
extern const char* SAT_B_MSG;
extern const char* SAT_C_MSG;
extern const char* SAT_D_MSG;
extern const char* SAT_E_MSG;
extern const char* SAT_F_MSG;

extern const float GUI_RECT_X;
extern const float GUI_RECT_Y;
extern const float GUI_RECT_WIDTH;
extern const float GUI_RECT_HEIGHT;

extern const char* SENDING_STATE_TEXT;
extern const char* SEARCHING_STATE_TEXT;
extern const char* RETURNING_STATE_TEXT;

extern const char* SENDER_LABEL_TEXT;
extern const char* DESTINATION_LABEL_TEXT;

extern const char* COMP_A_LABEL_TEXT;
extern const char* COMP_B_LABEL_TEXT;
extern const char* COMP_C_LABEL_TEXT;
extern const char* COMP_D_LABEL_TEXT;
extern const char* COMP_E_LABEL_TEXT;
extern const char* COMP_F_LABEL_TEXT;

extern const int PRIMARY_FONT_SIZE;
extern const int SECONDARY_FONT_SIZE;
extern const int TERTIARY_FONT_SIZE;
extern const int QUARTERNARY_FONT_SIZE;
extern const char* LOG_TEXT;

extern const Color SPACE_VOID;

extern const Color PRIMARY_BLUE;
extern const Color SECONDARY_BLUE;
extern const Color PRIMARY_BROWN;
extern const Color SECONDARY_BROWN;

extern const Color GUI_BACKGROUND;
extern const Color BLOOD_MOON;
extern const Color SILVER_MOON;
extern const Color BLUE_MOON;

```

Constants.cpp

```cpp

#include "Constants.h"

const int SCREEN_WIDTH = 1600;
const int SCREEN_HEIGHT = 900;

const float NET_RECT_X = 30;
const float NET_RECT_Y = 30;
const float NET_RECT_WIDTH = SCREEN_WIDTH * 0.66;
const float NET_RECT_HEIGHT = SCREEN_HEIGHT - 60;

const float GUI_RECT_X = NET_RECT_WIDTH + 60;
const float GUI_RECT_Y = 30;
const float GUI_RECT_WIDTH = SCREEN_WIDTH * 0.33 - 90;
const float GUI_RECT_HEIGHT = SCREEN_HEIGHT - 60;

const float EARTH_X = NET_RECT_WIDTH / 2;
const float EARTH_Y = NET_RECT_HEIGHT / 2;

const float EARTH_RADIUS = 100.0f;
const float MOON_RADIUS = 30.0f;
const float MOON_DISTANCE = 300.0f;

const float STEP_UNIT = 1.5f;
const int STARS_COUNT = 300;

const float SAT_A_X = EARTH_X + MOON_DISTANCE * cosf(1.0f);
const float SAT_A_Y = EARTH_Y + MOON_DISTANCE * sinf(1.0f);

const float SAT_B_X = EARTH_X + MOON_DISTANCE * cosf(2.0f);
const float SAT_B_Y = EARTH_Y + MOON_DISTANCE * sinf(2.0f);

const float SAT_C_X = EARTH_X + MOON_DISTANCE * cosf(3.0f);
const float SAT_C_Y = EARTH_Y + MOON_DISTANCE * sinf(3.0f);

const float SAT_D_X = EARTH_X + MOON_DISTANCE * cosf(4.0f);
const float SAT_D_Y = EARTH_Y + MOON_DISTANCE * sinf(4.0f);

const float SAT_E_X = EARTH_X + MOON_DISTANCE * cosf(5.0f);
const float SAT_E_Y = EARTH_Y + MOON_DISTANCE * sinf(5.0f);

const float SAT_F_X = EARTH_X + MOON_DISTANCE * cosf(6.0f);
const float SAT_F_Y = EARTH_Y + MOON_DISTANCE * sinf(6.0f);

const char* EARTH_IMG = "Resources/earth.png";
const char* MOON_IMG = "Resources/moon.png";

const char* SAT_A_IMG = "Resources/sat1.png";
const char* SAT_B_IMG = "Resources/sat2.png";
const char* SAT_C_IMG = "Resources/sat3.png";
const char* SAT_D_IMG = "Resources/sat4.png";
const char* SAT_E_IMG = "Resources/sat5.png";
const char* SAT_F_IMG = "Resources/sat6.png";

const char* SAT_A_MSG = "Resources/secretsA.txt";
const char* SAT_B_MSG = "Resources/secretsB.txt";
const char* SAT_C_MSG = "Resources/secretsC.txt";
const char* SAT_D_MSG = "Resources/secretsD.txt";
const char* SAT_E_MSG = "Resources/secretsE.txt";
const char* SAT_F_MSG = "Resources/secretsF.txt";

const char* SENDING_STATE_TEXT = "Sending . . .";
const char* SEARCHING_STATE_TEXT = "Searching . . .";
const char* RETURNING_STATE_TEXT = "Returning . . .";

const char* SENDER_LABEL_TEXT = "Sender";
const char* DESTINATION_LABEL_TEXT = "Destination";

const char* COMP_A_LABEL_TEXT = "Satellite A ip:";
const char* COMP_B_LABEL_TEXT = "Satellite B ip:";
const char* COMP_C_LABEL_TEXT = "Satellite C ip:";
const char* COMP_D_LABEL_TEXT = "Satellite D ip:";
const char* COMP_E_LABEL_TEXT = "Satellite E ip:";
const char* COMP_F_LABEL_TEXT = "Satellite F ip:";

const int PRIMARY_FONT_SIZE = 50;
const int SECONDARY_FONT_SIZE = 40;
const int TERTIARY_FONT_SIZE = 30;
const int QUARTERNARY_FONT_SIZE = 20;
const char* LOG_TEXT = "Logs";

const Color SPACE_VOID = { 12, 12, 12, 255 };

const Color PRIMARY_BLUE = {21, 52, 72, 255};
const Color SECONDARY_BLUE = { 50, 111, 121, 255 };
const Color PRIMARY_BROWN = { 148, 137, 121, 255 };
const Color SECONDARY_BROWN = {223, 208, 184, 255};

const Color BLOOD_MOON = {196, 12, 12, 255};
const Color SILVER_MOON = {204, 204, 204, 255};
const Color BLUE_MOON = {7, 102, 173, 255};

```