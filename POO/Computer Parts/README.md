# Computer Parts

```cpp
// Sa se scrie o ierarhie de computer parts
// Clasa ComputerPart sa aiba doua metode: 
//	GetPrice() 
//	GetName()
// Derivat din ComputerParts sa fie: 
//	HDD
//	Display
//	Mouse
//	Keyboard
// Sa se scrie doua clase abstracte (interfete) :
// HasButtons -> cu metoda GetNoOfButtons()
// HasMemory -> cu metoda GetCapacity()
// 
// Unde este cazul, clasele derivate din ComputerPart trebuie sa implementeze si una din cele doua interfete
// Sa se creeze un vector cu ComputerPart 
//
```

ComputerPart.h
```cpp
#pragma once

#include <iostream>
#include <string>

using std::cout;
using std::endl;
using std::string;

class ComputerPart
{
public:
	ComputerPart(int price, string name);
	int GetPrice();
	string GetName();

	virtual void Display();

	virtual ~ComputerPart();
protected:
	int m_Price;
	string m_Name;
};
```

ComputerPart.cpp
```cpp
#include "ComputerPart.h"

ComputerPart::ComputerPart(int price, string name) : m_Price(price), m_Name(name)
{

}

int ComputerPart::GetPrice()
{
	return m_Price;
}

string ComputerPart::GetName()
{
	return m_Name;
}

void ComputerPart::Display()
{
	cout 
		<< "\tPrice:         " << m_Price << "\n"
		<< "\tName:          " << m_Name << "\n";
}

ComputerPart::~ComputerPart()
{
	cout << "~ComputerPart call." << endl;
}
```

HDD.h
```cpp
#pragma once

#include "ComputerPart.h"
#include "HasMemory.h"

class HDD :
    public ComputerPart, public HasMemory
{
public:
    HDD(int price, string name, int capacity);
    int GetCapacity();
    void Display();
    ~HDD();
private:
    int m_Capacity;
};
```

HDD.cpp
```cpp
#include "HDD.h"

HDD::HDD(int price, string name, int capacity) : ComputerPart(price, name), m_Capacity(capacity)
{

}

int HDD::GetCapacity()
{
	return m_Capacity;
}

void HDD::Display()
{
	cout << "HDD:\n";
	ComputerPart::Display();
	cout 
		<< "\tCapacity:      " << m_Capacity << "\n";
}

HDD::~HDD()
{
	cout << "~HDD call." << endl;
}
```

HasButtons.h
```cpp
#pragma once

class HasButtons
{
public:
	virtual int GetNoOfButtons() = 0;
	virtual void Display() = 0;
};
```

HasMemory.h
```cpp
#pragma once

class HasMemory
{
public:
	virtual int GetCapacity() = 0;
	virtual void Display() = 0;
};
```

Keyboard.h
```cpp
#pragma once

#include "ComputerPart.h"
#include "HasButtons.h"

class Keyboard :
    public ComputerPart, public HasButtons
{
public:
    Keyboard(int price, string name, int noOfButtons);
    int GetNoOfButtons();
    void Display();
    ~Keyboard();

private:
    int m_NoOfButtons;

};
```

Keyboard.cpp
```cpp
#include "Keyboard.h"

Keyboard::Keyboard(int price, string name, int noOfButtons) : ComputerPart(price, name), m_NoOfButtons(noOfButtons)
{
	
}

int Keyboard::GetNoOfButtons()
{
	return m_NoOfButtons;
}

void Keyboard::Display()
{
	cout << "Keyboard:\n";
	ComputerPart::Display();
	cout 
		<< "\tNo of buttons: " << m_NoOfButtons << "\n";
}

Keyboard::~Keyboard()
{
	cout << "~Keyboard call." << endl;
}
```

Monitor.h
```cpp
#pragma once

#include "ComputerPart.h"
#include "HasButtons.h"

class Monitor : public ComputerPart, public HasButtons
{
public:
	Monitor(int price, string name, int noOfButtons, string type);
	int GetNoOfButtons();
	void Display();
	~Monitor();
private:
	int m_NoOfButtons;
	string m_Type;
};
```

Monitor.cpp
```cpp
#include "Monitor.h"

Monitor::Monitor(int price, string name, int noOfButtons, string type) : ComputerPart(price, name), m_NoOfButtons(noOfButtons), m_Type(type)
{

}

int Monitor::GetNoOfButtons()
{
	return m_NoOfButtons;
}

void Monitor::Display()
{
	cout << "Monitor:\n";
	ComputerPart::Display();
	cout 
		<< "\tNo of buttons: " << m_NoOfButtons << "\n"
		<< "\tType:          " << m_Type << "\n";
}

Monitor::~Monitor()
{
	cout << "~Monitor call" << endl;
}
```

Mouse.h
```cpp
#pragma once

#include "ComputerPart.h"
#include "HasButtons.h"

class Mouse : public ComputerPart, public HasButtons
{
public:
	Mouse(int price, string name, int noOfButtons, string type);
	int GetNoOfButtons();
	void Display();
	~Mouse();
private:
	int m_NoOfButtons;
	string m_Type;
};
```

Mouse.cpp
```cpp
#include "Mouse.h"

Mouse::Mouse(int price, string name, int noOfButtons, string type) : ComputerPart(price, name), m_NoOfButtons(noOfButtons), m_Type(type)
{

}

int Mouse::GetNoOfButtons()
{
	return m_NoOfButtons;
}

void Mouse::Display()
{
	cout << "Mouse:\n";
	ComputerPart::Display();
	cout
		<< "\tNo of buttons: " << m_NoOfButtons << "\n"
		<< "\tType:          " << m_Type << "\n";
}

Mouse::~Mouse()
{
	cout << "~Mouse call." << endl;
}
```

Source.cpp
```cpp
#include <iostream>
#include <vector>

#include "Monitor.h"
#include "Mouse.h"
#include "HDD.h"
#include "Keyboard.h"

using std::vector;
int main()
{
	vector<ComputerPart*> components;

	Monitor monitor1(20, "DELL", 4, "LED");
	Keyboard keyboard1(50, "RAZER", 200);
	Mouse mouse1(5, "RAZER", 12, "Gaming");
	HDD hdd1(300, "Kingston", 2);

	Keyboard* keyboard2 = new Keyboard(10, "jsa", 123);
	ComputerPart* compPart = keyboard2;

	components.emplace_back(&monitor1);
	components.emplace_back(&keyboard1);
	components.emplace_back(&mouse1);
	components.emplace_back(&hdd1);


	for (auto& comp : components)
	{
		comp->Display();
	}
	cout << "-------------------------------------" << endl;

	vector<Keyboard*> keyboards;

	for (auto& comp : components)
	{
		if (dynamic_cast<HasButtons*>(comp))
		{
			keyboards.emplace_back(dynamic_cast<Keyboard*>(comp));
			comp->Display();
		}
	}

	delete compPart;

	std::cin.get();

	return EXIT_SUCCESS;
}
```