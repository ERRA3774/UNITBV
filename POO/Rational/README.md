# Rational Number

Rational.h
```cpp
#pragma once

#include <iostream>

class Rational
{
private:
	int nr, num;
	int cmmdc(int nr, int num);				// helper
public:
	Rational();
	Rational(int Nr, int Num);
	int getNr();
	int getNum();
	void setNr(int Nr);
	void setNum(int Num);
	void reductie();

	Rational operator+(Rational r);				// r1 + r2
	Rational operator-(Rational r);				// r1 - r2
	Rational operator*(Rational r);				// r1 * r2
	Rational operator/(Rational r);				// r1 / r2

	Rational operator++();					// ++r
	Rational operator--();					// --r

	Rational operator+(int myNr);				// r + c
	Rational operator-(int myNr);				// r - c
	Rational operator*(int myNr);				// r * c
	Rational operator/(int myNr);				// r / c

	friend Rational operator+(int myNr, Rational r);	// c + r
	friend Rational operator-(int myNr, Rational r);	// c - r
	friend Rational operator*(int myNr, Rational r);	// c * r
	friend Rational operator/(int myNr, Rational r);	// c / r

	friend Rational operator++(Rational& r, int);		// r++
	friend Rational operator--(Rational& r, int);		// r--

	friend std::ostream& operator<<(std::ostream& fl, Rational r);
	friend std::istream& operator>>(std::istream& fl, Rational& r);

	~Rational();
};
```

Rationa.cpp
```cpp
#include "Rational.h"

Rational::Rational()
{
	nr = 0;
	num = 1;
}

Rational::Rational(int Nr, int Num)
{
	nr = Nr;
	num = Num;
}

int Rational::getNr()
{
	return nr;
}

void Rational::setNr(int Nr)
{
	nr = Nr;
}

int Rational::getNum()
{
	return num;
}

void Rational::setNum(int Num)
{
	num = Num;
}

void Rational::reductie()
{
	int c = cmmdc(nr, num);

	if (c)
	{
		nr /= c;
		num /= c;
	}
}

Rational Rational::operator+(Rational r)
{
	return Rational(nr * r.num + r.nr * num, num * r.num);
}

Rational Rational::operator-(Rational r)
{
	return Rational(nr * r.num - r.nr * num, num * r.num);
}

Rational Rational::operator*(Rational r)
{
	return Rational(nr * r.nr, num * r.num);
}

Rational Rational::operator/(Rational r)
{
	return Rational(nr * r.num, num * r.nr);
}

Rational Rational::operator++()
{
	return Rational(nr + num, num);
}

Rational Rational::operator--()
{
	return Rational(nr - num, num);

}

Rational Rational::operator+(int myNr)
{
	return Rational(nr + myNr * num, num);
}

Rational Rational::operator-(int myNr)
{
	return Rational(nr - myNr * num, num);
}

Rational Rational::operator*(int myNr)
{
	return Rational(nr * myNr, num);
}

Rational Rational::operator/(int myNr)
{
	return Rational(num * myNr, nr);
}

int Rational::cmmdc(int nr, int num)
{
	int r;

	for (; num; r = nr % num, nr = num, num = r);

	return nr;
}

Rational operator+(int myNr, Rational r)
{
	return Rational(r.nr + myNr * r.num, r.num);
}

Rational operator-(int myNr, Rational r)
{
	return Rational(r.nr - myNr * r.num, r.num);
}

Rational operator*(int myNr, Rational r)
{
	return Rational(r.nr * myNr, r.num);
}

Rational operator/(int myNr, Rational r)
{
	return Rational(r.num * myNr, r.nr);
}

Rational operator++(Rational& r, int)
{
	Rational r0 = r;
	r.nr += r.num;
	return r0;
}

Rational operator--(Rational& r, int)
{
	Rational r0 = r;
	r.nr -= r.num;
	return r0;
}

std::ostream& operator<<(std::ostream& fl, Rational r)
{
	if (r.nr == 0)
	{
		return fl << 0 << std::endl;
	}

	if (r.num == 1)
	{
		return fl << r.nr << std::endl;
	}

	return fl << r.nr << "/" << r.num << std::endl;
}

std::istream& operator>>(std::istream& fl, Rational& r)
{
	return fl >> r.nr >> r.num;
}

Rational::~Rational()
{

}
```

Source.cpp
```cpp
#include "Rational.h"

int main()
{
	Rational r1;
	r1.setNr(7);
	r1.setNum(9);
	std::cout << "r1 = " << r1;

	Rational r2;
	r2.setNr(r1.getNr());
	r2.setNum(r1.getNr());
	std::cout << "r2 = " << r2;

	Rational r3(5, 8);
	std::cout << "r3 = " << r3;

	Rational r4(69696, 136);
	r4.reductie();
	std::cout << "r4 = " << r4;

	Rational r5(8, 9);
	Rational r6(5, 1);
	std::cout << "r5 + r6 = " << r5 + r6;
	std::cout << "r5 - r6 = " << r5 - r6;
	std::cout << "r5 * r6 = " << r5 * r6;
	std::cout << "r5 / r6 = " << r5 / r6;

	Rational r7(2, 7);
	Rational r8(1, 4);
	++r7;
	++r8;
	std::cout << "++r7 = " << r7;
	std::cout << "++r8 = " << r8;
	--r7;
	--r8;
	std::cout << "--r7 = " << r7;
	std::cout << "--r8 = " << r8;

	Rational r9;
	Rational r10;

	r9 = ++r7;
	r10 = r8++;

	std::cout << "r7 = " << r7;
	std::cout << "r8 = " << r8;
	std::cout << "r9 = ++r7 = " << r9;
	std::cout << "r10 = r8++ = " << r10;

	Rational r11(8, 7);
	std::cout << "r11 + 4 = " << r11 + 4;
	std::cout << "3 + r11 = " << 3 + r11;
	std::cout << "r11 - 1 = " << r11 - 1;
	std::cout << "9 - r11 = " << 9 - r11;
	std::cout << "r11 * 4 = " << r11 * 4;
	std::cout << "8 * r11 = " << 8 * r11;
	std::cout << "r11 / 4 = " << r11 / 4;
	std::cout << "7 / r11 = " << 7 / r11;

	Rational r0;
	std::cout << "Input: ";
	std::cin >> r0;
	std::cout << "r0 = " << r0;

	return 0;
}
```