# Products

```cpp
/*
BaseProdus
-denumire
-producator
-pret

	ProdusAlimentar
	-dataExpirare
	-unitateMasura
	-cantitate

	ProdusCosmetic
	-dataEpirare
	-tip

	ProducElectronic
	-model
	-consum
*/
```

BaseProdus.h
```cpp
#pragma once

#include <iostream>
using std::string;
using std::cout;
using std::endl;

class BaseProdus
{
public:
	BaseProdus(string = "-", string = "-", double = 0);

	string GetDenumire();
	virtual void Afisare();

	~BaseProdus();
protected:
	string m_Producator;
	string m_Denumire;
	double m_Pret;
	
private:
};
```

BaseProdus.cpp
```cpp
#include "BaseProdus.h"

BaseProdus::BaseProdus(string denu, string prod, double pret) : m_Denumire(denu), m_Producator(prod), m_Pret(pret)
{
	// Do Nothing
}

BaseProdus::~BaseProdus()
{
	cout << "Apel al destructorului clasei Produs." << endl;
}

void BaseProdus::Afisare()
{
	cout
		<< "Denumire: " << m_Denumire << '\n'
		<< "Producator: " << m_Producator << '\n'
		<< "Pret: " << m_Pret << '\n';
}
```

ProdusAlimentar.h
```cpp
#pragma once

#include "BaseProdus.h"

class ProdusAlimentar : public BaseProdus
{
public:
	ProdusAlimentar(string = "-", string = "-", double = 0, string = "-", string = "-", double = 0);
	
	void Afisare();

	~ProdusAlimentar();
private:
	string m_DataExpirare;
	string m_UnitMasura;
	double m_Cantitate;
};
```

ProdusAlimentar.cpp
```cpp
#include "ProdusAlimentar.h"

ProdusAlimentar::ProdusAlimentar(string denu, string prod, double pret, string data, string unit, double cant) : 
	BaseProdus(denu, prod, pret), m_DataExpirare(data), m_UnitMasura(unit), m_Cantitate(cant)
{
	// Do Nothing
}

ProdusAlimentar::~ProdusAlimentar()
{
	cout << "Apel al destructorului clasei ProdusAlimentar." << endl;
}

void ProdusAlimentar::Afisare()
{
	BaseProdus::Afisare();
	cout
		<< "Data expirare: " << m_DataExpirare << '\n'
		<< "Unitate masura: " << m_UnitMasura << '\n'
		<< "Cantitate: " << m_Cantitate << '\n';
}
```

ProdusCosmetic.h
```cpp
#pragma once

#include "BaseProdus.h"

class ProdusCosmetic : public BaseProdus
{
public:
	ProdusCosmetic(string = "-", string = "-", double = 0, string = "-", string = "-");

	void Afisare();

private:
	string m_DataExpirare;
	string m_Tip;
};
```

ProdusCosmetic.cpp
```cpp
#include "ProdusCosmetic.h"

ProdusCosmetic::ProdusCosmetic(string denu, string prod, double pret, string data, string tip) : 
	BaseProdus(denu, prod, pret), m_DataExpirare(data), m_Tip(tip)
{
	// Do Nothing
}

void ProdusCosmetic::Afisare()
{
	BaseProdus::Afisare();
	cout
		<< "DataExpirare: " << m_DataExpirare << '\n'
		<< "Tip: " << m_Tip << '\n';
}
```

ProdusElectronic.h
```cpp
#pragma once

#include "BaseProdus.h"

class ProdusElectronic : public BaseProdus
{
public:
	ProdusElectronic(string = "-", string = "-", double = 0, string = "-", int = 0);
	void Afisare();

private:
	string m_Model;
	int m_Consum;
};
```

ProdusElectronic.cpp
```cpp
#include "ProdusElectronic.h"

ProdusElectronic::ProdusElectronic(string denu, string prod, double pret, string mode, int cons) :
	BaseProdus(denu, prod, pret), m_Model(mode), m_Consum(cons)
{
	// Do Nothing
}

void ProdusElectronic::Afisare()
{
	BaseProdus::Afisare();
	cout
		<< "Model: " << m_Model << '\n'
		<< "Consum: " << m_Consum << '\n';
}
```

Source.cpp
```cpp
#include "ProdusAlimentar.h"
#include "ProdusCosmetic.h"
#include "ProdusElectronic.h"
#include <vector> 
using std::vector;

void TestProduse()
{
	ProdusAlimentar pa1("Lapte", "Dorna", 8.5, "25/5/2023", "litru", 1);
	ProdusAlimentar pa2("Paine", "Vel Pitar", 16.5, "10/5/2023", "gram", 500);
	ProdusCosmetic pc1("Sampon", "L'Oreal", 14, "31/12/2023", "Par Vopsit");
	ProdusElectronic pe1("Telefon", "Samsung", 950, "S15", 1);
	pa1.Afisare();
	pc1.Afisare();
	pe1.Afisare();

	cout << "---------------------------------------------" << endl;
	BaseProdus bp1;

	bp1 = pa1;

	bp1.Afisare();
	cout << "---------------------------------------------" << endl;
	ProdusAlimentar* ppa1 = &pa1, * ppa2 = &pa2;
	ProdusCosmetic* ppc1 = &pc1;
	ProdusElectronic* ppe1 = &pe1;

	BaseProdus* pbp1 = &bp1;
	pbp1 = ppe1;
	pbp1->Afisare();
	cout << "---------------------------------------------" << endl;
	vector<BaseProdus> produse;
	produse.push_back(pa1);
	produse.push_back(pc1);
	produse.push_back(pe1);

	for (int i = 0; i < produse.size(); i++)
	{
		produse[i].Afisare();
	}
	cout << "---------------------------------------------" << endl;
	vector<BaseProdus*> pProduse;
	pProduse.push_back(ppa1);
	pProduse.push_back(ppc1);
	pProduse.push_back(ppe1);
	for (int i = 0; i < pProduse.size(); i++)
	{
		pProduse[i]->Afisare();
	}
	cout << "---------------------------------------------" << endl;
}
```


