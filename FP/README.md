

procedural_programming.h

```h
#include <stdio.h>
#include <float.h>
#include <malloc.h>
#include <stdarg.h> 
#include <string.h>

// MACROS

#define max(a,b) (a > b ? a : b)  
#define sum(a,b) (a + b)
#define avg(a,b) ((a + b) / 2.0f))
#define concat(a,b) (a##b)

// STRUCTS
typedef struct Person Person;

struct Person {
	char name[128];
	char adress[128];
	int age;
};

// DEMOS

void intArrayDemo();
void intArrayDemo2();
void macrosDemo();
void mallocDemo();
void readFromFileDemo();
void structDemo();
void switchDemo();
void variableArgumentsDemo();
void stackDemo();
void charOccuranceDemo();

int maxValBetween(int a, int b);
int maxValInArray(int* arr, int size);
int negativeNumsCountInMatrix(float** a, int m, int n);
int charOccuranceCount(char* string, char ch);

float averageBetween(int a, int b);

double maxValBetweenAll(int numOfArgs, ...);

// IMPLEMENTATIONS

// Stack
typedef struct Stack Stack;

struct Stack {
	char data;
	Stack* next;
} *top;

bool push(char ch);
bool pop();
void print();
```

procedural_programming.c

```c
#include "procedural_programming.h"

// DEMOS

void intArrayDemo() {
	int arr[10] = {};
	int n = 10;

	for (int i = 0; i < n; i++) {
		prinf("a[%d] = ", i);
		scanf("%d", &arr[i]);
	}

	for (int i = 0; i < n; i++) {
		printf("%d ", i);
	}
}

void intArrayDemo2() {
	int arr[10] = {};

	for (int i = 0; i < sizeof(arr) / sizeof(int); i++) {
		prinf("a[%d] = ", i);
		scanf("%d", &arr[i]);
	}

	printf("Nums are: ");

	for (int i = 0; i < sizeof(arr) / sizeof(int); i++) {
		prinf("%d\n", arr[i]);
	}
}

void macrosDemo() {
	int firstNum = {};
	int secondNum = {};
	int maxVal = {};
	int totalSum = {};
	float average = {};

	printf("Pleease input your first number: ");
	scanf("%d", &firstNumber);

	printf("Pleease input your first number: ");
	scanf("%d", &secondNumber);

	average = avg(firstNum, secondNum);
	printf("The average between %d and %d is %f.", firstNum, secondNum, average);

	maxVal = max(firstNum, secondNum);
	printf("The maximum value between %d and %d is %d.", firstNum, secondNum, maxVal);

	totalSum = sum(firstNum, secondNum);
	printf("The sum between %d si %d is %d", firstNumber, secondNumber, totalSum);
}

void mallocDemo() {
	int* arr = {};
	int size = {};
	int maxVal = {};

	printf("size = ");
	scanf("%d", &size);

	if (size < 1) {
		printf("Size must be greater than 1");
		exit(1);
	}

	arr = (int*)malloc(n * sizeof(int));

	if (arr == NULL) {
		perror("Cannot allocate memory. Not enough memory.");
		exit(1);
	}

	for (int i = 0; i < size; i++) {
		printf("a[%d] = ", i);
		scanf("%d", &arr[i]);
	}

	maxVal = maxValInArray(arr, size);

	printf("The nums are: \n");

	for (int i = 0; i < size; i++) {
		printf("%d ", i);
	}
	printf("\n");
	printf("The maximum value is: %d", maxVal);

	free(a);
}

void structDemo() {
	Person* person;

	person = (Person*)malloc(sizeof(Person));

	if (person == NULL) {
		perror("Cannot allocate memory. Not enough memory.");
		exit(1);
	}

	printf("Enter name: ");
	scanf("%s", &person->name);

	printf("Enter address: ");
	scanf("%s", &person->adress);

	printf("Enter age: ");
	scanf("%d", &person->age);

	printf("Information read:\nName: %s\nAdress: %s\nAge: %d\n", person->name, person->adress, person->age);

	free(person);
}

void readFromFileDemo() {
	char filePath[256] = {};
	FILE* file = {};
	int row = {};
	int col = {};
	int size = {};
	int negativeNumsCount = {};
	float** mat;

	printf("Enter the file path: ");
	scanf("%s", filePath);

	file = fopen(filePath, "rb");

	if (file == NULL) {
		printf("Could not open file from path %s", filePath);
		exit(1);
	}

	fscanf(file, "%d%d", &row, &col);

	mat = (float**)malloc(row * sizeof(float*));

	if (mat == NULL) {
		perror("Could not allocate memory. Not enough memory.");
		exit(1);
	}

	for (int i = 0; i < row; i++) {
		arr[i] = (float*)malloc(col * sizeof(float));
		if (arr[i] == NULL) {
			perror("Could not allocate memory. Not enough memory.");
			exit(1);
		}
	}

	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			fscanf(file, "%f", &arr[i][j]);
		}
	}

	negativeNumsCount = negativeNumsCountInMatrix(mat, row, col);

	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			printf("%.2f ", arr[i][j]);
		}
		printf("\n");
	}

	printf("There are %d nevative numbers in the matrix." negativeNumsCount);

	for (int i = 0; i < row; i++) {
		free(arr[i]);
	}
	free(a);
	fclose(f);
}

void switchDemo() {
	int option = {};

	printf("Menu:\n");

	do
	{
		printf("1: Option 1\n2: Option 2\n0: Exit\n");

		printf("Enter option: ");

		scanf("%d", &option);

		switch (option)
		{
		case 1:
			printf("Option 1 selected!\n");
			break;
		case 2:
			printf("Option 2 selected\n");
			break;
		case 0:
			printf("Exit selected\n");
			break;
		default:
			printf("Invalid command.");
			break;
		}
	} while (!option);
}

void variableArgumentsDemo() {
	double maxVal = {};

	maxVal = maxValBetweenAll(4, 2.5, 6., 5.7, 1.);

	printf("Maximum value is: %.2lf", max);
}

void charOccuranceDemo() {
	int length = 256;
	char* string = {};
	char ch = {};
	int count = {};

	printf("Input a letter: ");
	scanf("%c", &ch);

	string = (char*)malloc(length * sizeof(char));

	if (string == NULL) {
		perror("Not enough memory.");
		exit(1);
	}

	printf("Input a string: ");
	scanf("%s", string);

	count = charOccuranceCount(string, ch);

	printf("The letter %c appears %d times in %s.", ch, count, string);

	free(string);
}

int maxValBetween(int a, int b) {
	return a > b ? a : b;
}

int maxValInArray(int* arr, int size) {
	int max = arr[0];

	for (int i = 0; i < size; i++) {
		if (arr[i] > max) {
			max = arr[i];
		}
	}

	return max;
}

int negativeNumsCountInMatrix(float** mat, int row, int col) {
	int count = 0;

	for (int i = 0; i < row; i++) {
		for (int j = 0; j < col; j++) {
			if (mat[i][j] < 0) {
				count++;
			}
		}
	}

	return count;
}

float averageBetween(int a, int b) {
	float avg;

	avg = (a + b) / 2.0f;

	return avg;
}

double maxValBetweenAll(int numOfArgs, ...) {
	double max = -DBL_MAX; // Smallest double value
	double x = {};
	va_list list; // Data type

	va_start(list, numOfArgs); // Macro

	for (int i = 0; i < numsOfArgs; i++) {
		double x = va_arg(list, double);
		if (x > max) {
			max = x;
		}
	}

	va_end(list); // Macro

	return max;
}

int charOccuranceCount(char* string, char ch) {
	int count = {};

	while (strchr(string, ch) != NULL) {
		string = strchr(string, ch) + 1;
		count++;
	}

	return count;
}

// Stack

void stackDemo() {
	char ch = {};
	int option = {};

	do
	{
		printf("Select an option:\n");
		printf("1. push()\n");
		printf("2. pop()\n");
		printf("3. print()\n");
		printf("4. exit()\n");
		scanf("%d", &option);
		getchar();
		switch (option) {
		case 1: {
			printf("Input a character:");
			scanf("%c", &c);
			getchar();
			if (push(ch)) {
				printf("Pushed %c\n", c);
			}
			break;
		}
		case 2: {
			if (pop()) {
				printf("Popped\n");
			}
			break;
		}
		case 3: {
			print();
			break;
		}
		case 4: {
			break;
		}
		default: {
			printf("Invalid input.");
		}
		}
	} while (option != 4);
}

bool push(char ch) {
	Stack* node;
	node = (Stack*)malloc(sizeof(Stack));
	if (node == NULL) {
		return false;
	}
	node->data = ch;
	node->next = top;
	top = node;
	return true;
}

bool pop() {
	Stack* node = top;
	if (node == NULL) {
		return false;
	}
	top = node->next;
	free(node);
	return true;
}

void print() {
	Stack* node = top;
	while (node != NULL) {
		printf("%c ", node->data);
		node = node->next;
	}
	printf("\n");
}
```