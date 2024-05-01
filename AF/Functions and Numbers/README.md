# Functions and Numbers

1. Se citeste un numar natural n.
Afisati toate perechile de numere de la 1 la n care au proprietatea ca au aceeasi suma a cifrelor

```cpp
int DigitsSum(int num) {
	int sum{};

	while (num) {
		sum += num % 10;
		num /= 10;
	}

	return sum;
}

void PrintDigitsSumPair(int n = 100) {
	for (int i = n; i >= 0; i--) {
		std::cout << DigitsSum(i) << ' ' << i << '\n';
	}
}
```

2. Se citeste un numar natural n si apoi n numere naturale
Afisati cate dintre numerele citite au rasturnatul egal cu primul numar citit
Exemplu: n = 7
213 78 132 30 132 8 132 -> se va afisa 3

```cpp
int Reversed(int num) {
	int reversed{};

	while (num) {
		reversed *= 10 + num % 10;
		num /= 10;
	}

	return reversed;
}

void PrintCountOfNumsEqualToFirstReversed(int n = 7, std::vector<int> vec = { 213, 78, 132, 30, 132, 8, 132 }) {
	int count{};

	if (vec.empty()) {
		std::cout << "0\n";
		return;
	}

	int reversed = Reversed(vec[0]);

	for (int i = 1; i < vec.size(); i++) {
		if (vec[i] == reversed) {
			count++;
		}
	}

	std::cout << count << '\n';
}
```

3. Se citesc 2 numere naturale a si b
Calculati cate numere palindrom sunt din intervalul [a,b]
Palindrom: 12321, 111
Exemplu: a = 100, b = 200
Se va afisa 101, 111, 121, 131, 141, 151, 161, 171, 181, 191

```cpp
bool IsPalindrome(int num) {

	if (num < 0) {
		return false;
	}

	if (num >= 0 && num <= 9) {
		return true;
	}

	int reversed{};
	int temp = num;

	while (temp) {
		reversed += temp % 10;
		temp /= 10;
	}

	return reversed == num ? true : false;
}

void PrintPalindromesBetween(int a = 100, int b = 200) {
	int count{};

	for (int i = a; i <= b; i++) {
		if (IsPalindrome(i)) {
			count++;
			std::cout << i << ' ';
		}
	}

	std::cout << count << '\n';
}
```

4. Se citeste un numar natural n si un sir  de n perechi de numere
 Determinati si afisati perechea pentru care valoarea cmmdc-ului dintre cele 2 valori este maxima
 Exemplu: n = 3
 12 10
 45 35
 23 74
 Se va afisa perechea 45 35

```cpp
int Gcd(int a, int b) { 

	while (b) {
		int r = a % b;
		a = b;
		b = r;
	}

	return a;
}

void PrintMaxGcdPair(int n = 3, std::vector<std::pair<int, int>> vec = { {12, 10}, { 45,35 }, { 23,74 } }) {
	std::pair<int, int> max{};

	for (auto pair : vec) {
		if (Gcd(pair.first, pair.second) > Gcd(max.first, max.second)) {
			max = pair;
		}
	}

	std::cout << "Max pair: " << max.first << ' ' << max.second << '\n';
}
```

5. Se citeste un numar natural k din intervalul [1,9]
 Afisati toate numerele n formate din exact k cifre care au proprietatea ca n-1 si n+1 sunt prime.
 Exemplu: k = 2
 Se vor afisa: 12, 18, 30, 42, 60, 72

```cpp
bool IsPrime(int num) {
	if (num < 0 || num % 2 == 0) {
		return false;
	}

	if (num >= 1 && num <= 3) {
		return true;
	}

	for (int i = 3; i * i <= num; i += 2) {
		if (num % i == 0) {
			return false;
		}
	}

	return true;
}

void PrintTwinPrimesBetween(int k = 2) {
	if (k < 1 || k > 9) {
		return;
	}

	for (int i = pow(10, k - 1); i < pow(10, k) - 1; i++) {
		if (IsPrime(i - 1) && IsPrime(i + 1)) {
			std::cout << i << ' ';
		}
	}
}
```

6. Sa se afiseze cel mai mic numar care se poate forma cu cifrele lui n
 Fiecare cifra repetandu-se de cate ori se repeta si in n.
 Exemplu:    1204192
 Se va afisa: 112249

```cpp
void PrintMinified(int num = 1204192) {
	int digits[10] = { 0 };
	int minified{};

	while (num) {
		digits[num % 10]++;
		num /= 10;
	}

	for (int i = 0; i < 10; i++) {
		while (digits[i]) {
			minified = minified * 10 + digits[i];
			digits[i]--;
		}
	}

	std::cout << minified << '\n';
}
```

7. Sa se verifice daca cifrele lui n sunt in progresie aritmetica
 Exemplu n = 2596
 Se va afisa: Cifrele lui 2596 nu sunt in progresie aritmetica
 Exemplu n = 2468
 Se va afisa: Cifrele lui 2468 sunt in progresie aritmetica

```cpp
bool DigitsInArithmeticProgression(int num = 2468) {
	if (num < 10) {
		return false;
	}

	int r = num % 10 - (num / 10) % 10; // 2

	while (num) {
		if (num % 10 - r != (num / 10) % 10) {
			return false;
		}
		num /= 10;
	}

	return true;
}
```
8. Se citesc un numar natural n de maxim 3 cifre si o cifra c
Eliminati toate aparitiile cifrei c din numarul n si afisati numarul obtinut
Exemplu: n = 2345324 
         c =       2
Rezulta        34534

```cpp
void EraseOcurrances(int num = 2345324, int digit = 2) {
	int erased{};

	while (num) {
		if (num % 10 != digit) {
			erased = erased * 10 + num % 10;
		}
		num /= 10;
	}

	std::cout << Reversed(erased);
}

```

9. Se citeste un numar natural n cu numar par de cifre
 Calculati si afisati numarul obtinut din n 
 inversand cifra unitatilor cu a zecilor
 cea a sutelor cu cea a miilor, etc
 Exemplu: n = 123456
 Rezulta: n = 214365

```cpp
void SwapDigitsPositions(int num = 12345678) {
	int swapped{};

	while (num) {
		int a = (num % 100) / 10;
		int b = num % 10;
		int c = a * 10 + b;
		swapped = swapped * 100 + c;
		num /= 100;
	}

	std::cout << Reversed(swapped);
}
```

10. Se citeste un numar natural n > 1000
 Afisati cel mai mare numar care se poate obtine din n prin eliminarea unei singure cifre
 Exeplu: n = 45329
 Rezulta: n = 5329 (e cel mai mare dintre numerele 4532, 4539, 4529, 4329, 5329)

```cpp
void PrintMaxNumberAfterErasingDigit(int num = 45329)
{
	if (num <= 1000) {
		std::cout << "Number must be greater than 1000.";
		return;
	}

	int div = 1000;
	while (num / div >= 10) {
		div *= 10;
	}
	int max = num % div;
	while (div / 10 > 0) {
		int tempMax = ((num / div) * (div / 10)) + (num % (div / 10));
		if (tempMax > max) {
			max = tempMax;
		}
		div /= 10;
	}
	std::cout << "The maximum number is: " << max << '\n';
}
```