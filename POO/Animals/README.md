# Animals

Sa se creeze clase care sa poata modela animale precum cainele, pisica si rata. Fiecare dintre clase sa aiba constructori, o metoda de afisare si o metoda care reda sunetul specific al animalului.

Sa se creeze animale diferite si sa se retina toate in aceeasi structura. Sa se parcurga aceasta si sa se apeleze la parcurgere metodele de afisare si redare sunet specific().


BaseAnimal.h
```cpp
#pragma once

#include <iostream>

using std::cout;
using std::endl;
using std::string;

class BaseAnimal
{
public:
	BaseAnimal(string, string);

	string GetName();
	string GetSound();

	virtual void Speak();
	virtual void Display();
private:
	string m_Name;
	string m_Sound;
};
```

BaseAnimal.cpp
```cpp
#include "BaseAnimal.h"

BaseAnimal::BaseAnimal(string name, string sound) : m_Name(name), m_Sound(sound)
{
	// Do nothing
}

string BaseAnimal::GetName()
{
	return m_Name;
}

string BaseAnimal::GetSound()
{
	return m_Sound;
}

void BaseAnimal::Speak()
{
	cout << "BaseAnimal Speaks" << endl;
}

void BaseAnimal::Display()
{
	cout
		<< "Animal name: " << m_Name << "\n"
		<< "Animal sound: " << m_Sound << "\n";
}
```

Cat.h
```cpp
#pragma once

#include "BaseAnimal.h"

class Cat :
    public BaseAnimal
{
public:
    Cat(string, string = "meow");

    void Speak();
    void Display();

private:
    string m_Name;
};

```

Cat.cpp
```cpp
#include "Cat.h"

Cat::Cat(string name, string sound) : BaseAnimal(name, sound)
{
	// Do nothing
}

void Cat::Speak()
{
	cout << BaseAnimal::GetName() << ", the cat, " << BaseAnimal::GetSound() << "ed." << endl;
}

void Cat::Display()
{
	cout
		<< "Cat" << '\n'
		<< "\tName: " << BaseAnimal::GetName() << '\n'
		<< "\tSound: " << BaseAnimal::GetSound() << '\n';
}
```

Dog.h
```cpp
#pragma once

#include "BaseAnimal.h"

class Dog :
    public BaseAnimal
{
public:
    Dog(string, string sound = "bark");

    void Speak();
    void Display();

private:
    string m_Name;
};
```

Dog.cpp
```cpp
#include "Dog.h"

Dog::Dog(string name, string sound) : BaseAnimal(name, sound)
{
	// Do nothing
}

void Dog::Speak()
{
	cout << BaseAnimal::GetName() << ", the dog, " << BaseAnimal::GetSound() << "ed." << endl;
}

void Dog::Display()
{
	cout
		<< "Dog" << '\n'
		<< "\tName: " << BaseAnimal::GetName() << '\n'
		<< "\tSound: " << BaseAnimal::GetSound() << '\n';
}
```

Duck.h
```cpp
#pragma once

#include "BaseAnimal.h"

class Duck :
    public BaseAnimal
{
public:
    Duck(string, string = "quack");

    void Speak();
    void Display();

private:
    string m_Name;
};
```

Duck.cpp
```cpp
#include "Duck.h"

Duck::Duck(string name, string sound) : BaseAnimal(name, sound)
{
	// Do nothing
}

void Duck::Speak()
{
	cout << BaseAnimal::GetName() << ", the duck, " <<BaseAnimal::GetSound() << "ed." << endl;
}

void Duck::Display()
{
	cout
		<< "Duck" << '\n'
		<< "\tName: " << BaseAnimal::GetName() << '\n'
		<< "\tSound: " << BaseAnimal::GetSound() << '\n';
}
```

Source.cpp
```cpp
#include "Dog.h"
#include "Cat.h"
#include "Duck.h"
#include <vector>
using std::vector;

int main()
{
	Dog dog1("Beethoven");
	Dog dog2("Lassy");
	Dog dog3("Toto");

	Cat cat1("Missy");
	Cat cat2("Grumpy");
	Cat cat3("Felix");

	Duck duck1("Donald");
	Duck duck2("Daisy");
	Duck duck3("Daffy");

	vector<BaseAnimal*> animals;
	animals.emplace_back(&dog1);
	animals.emplace_back(&dog2);
	animals.emplace_back(&dog3);
	animals.emplace_back(&cat1);
	animals.emplace_back(&cat2);
	animals.emplace_back(&cat3);
	animals.emplace_back(&duck1);
	animals.emplace_back(&duck2);
	animals.emplace_back(&duck3);

	for (const auto& an : animals)
	{
		an->Speak();
		an->Display();
	}
}
```