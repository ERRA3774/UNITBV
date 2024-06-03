# Homework 4

```cpp
/*
2. Operatii pe un arbore binar
Se citeste dintr-un fisier un arbone binar. (1p)
Modul de citire este pe niveluri (in latime)
Sa se implementeze urmatoarele functii:
1. Functie ce calculeaza inaltimea unui arbore (0.5p)
2. Functii de parcurgerea arborelui (RSD, SRD, SDR, Niveluri) (0.5p)
3. Functie care afiseaza frunzele de la stanga la dreapta (0.5p)
4. Functie care verifica daca 2 arbori sunt identici (1p)
5. Functie care verifica daca un arbore e complet (0.5p)
6. Functie care determina adancimea unui nod (0.5p)
*/
```

```cpp
#include <iostream>
#include <fstream>
#include <string>
#include <stack>
#include <queue>

using std::make_pair;
using std::ifstream;
using std::string;
using std::stack;
using std::queue;
using std::pair;
using std::cout;
using std::endl;

struct Node
{
	char data;
	Node* left;
	Node* right;

	Node(char d) : data(d), left(nullptr), right(nullptr) {}
};

class BinaryTree
{
public:
	BinaryTree();
	BinaryTree(string path);

	int GetSize();
	int GetHeight();

	void PreorderTraversal();
	void InorderTraversal();
	void PostorderTraversal();
	void LevelTraversal();

	void PrintLeaves();
	bool IsComplete();
	
	int Depth(char ch);
	void Display();

	bool operator == (BinaryTree& rhs);

private:
	void PreorderTraversal(Node* node);
	void InorderTraversal(Node* node);
	void PostorderTraversal(Node* node);
	void LevelTraversal(Node* node);

	void CalculateHeight();
	void CalculateHeight(Node* node, int level);

private:
	Node* m_Root;
	int m_Size;
	int m_Height;
};

BinaryTree::BinaryTree()
{
	m_Root = nullptr;
	m_Size = 0;
	m_Height = 0;
}

BinaryTree::BinaryTree(string path) : m_Root(nullptr), m_Size(0), m_Height(0)
{
	ifstream fin(path);

	if (!fin.is_open())
	{
		cout << "Could not open file from " << path << endl;
		return;
	}

	char ch;
	queue<Node*> queue;
	if (fin >> ch)
	{
		m_Root = new Node(ch);
		queue.push(m_Root);
	}
	else
	{
		cout << "The file is empty." << endl;
		return;
	}

	while (!fin.eof() && !queue.empty())
	{
		Node* curr = queue.front();
		queue.pop();

		if (fin >> ch && ch != '#')
		{
			Node* lNode = new Node(ch);
			curr->left = lNode;
			queue.push(lNode);
		}

		if (fin >> ch && ch != '#')
		{
			Node* rNode = new Node(ch);
			curr->right = rNode;
			queue.push(rNode);
		}
	}

	CalculateHeight();
	fin.close();
}

int BinaryTree::GetSize()
{
	return m_Size;
}

int BinaryTree::GetHeight()
{
	return m_Height;
}

void BinaryTree::PreorderTraversal()
{
	cout << "Preorder Traversal: " << endl;
	PreorderTraversal(m_Root);
}

void BinaryTree::InorderTraversal()
{
	cout << "Inorder Traversal: " << endl;
	InorderTraversal(m_Root);
}

void BinaryTree::PostorderTraversal()
{
	cout << "Postorder Traversal: " << endl;
	PostorderTraversal(m_Root);
}

void BinaryTree::LevelTraversal()
{
	cout << "Postorder Traversal: " << endl;
	LevelTraversal(m_Root);
}

void BinaryTree::PrintLeaves()
{
	if (m_Root == nullptr) return;

	queue<Node*> queue;
	queue.push(m_Root);

	cout << "Binary Tree leaves from left to right:" << endl;
	while (!queue.empty())
	{
		Node* curr = queue.front();
		queue.pop();

		if (curr->left == nullptr && curr->right == nullptr) cout << curr->data << " ";
		if (curr->left != nullptr) queue.push(curr->left);
		if (curr->right != nullptr) queue.push(curr->right);
	}
}

bool BinaryTree::IsComplete()
{
	if (m_Root == nullptr) return true;

	queue<Node*> queue;
	queue.push(m_Root);

	bool isIncomplete = false;

	while (!queue.empty())
	{
		Node* curr = queue.front();
		queue.pop();

		if (isIncomplete && (curr->left != nullptr || curr->right != nullptr)) return false;

		if (curr->left == nullptr && curr->right != nullptr) return false;

		if (curr->left == nullptr && curr->right != nullptr || 
			curr->left != nullptr && curr->right == nullptr)
			isIncomplete = true;

		if (curr->left != nullptr) queue.push(curr->left);
		if (curr->right != nullptr) queue.push(curr->right);
	}

	return true;
}

int BinaryTree::Depth(char ch)
{
	if (m_Root == nullptr) return -1;

	queue<pair<Node*, int>> queue;
	queue.push(make_pair(m_Root, 0));

	while (!queue.empty()) {
		pair<Node*, int> curr = queue.front();
		queue.pop();

		if (curr.first->data == ch) {
			return curr.second;
		}

		if (curr.first->left != nullptr) queue.push(make_pair(curr.first->left, curr.second + 1));


		if (curr.first->right != nullptr) queue.push(make_pair(curr.first->right, curr.second + 1));
	}

	return -1;
}

void BinaryTree::Display()
{
	if (m_Root == nullptr)
	{
		cout << "null" << endl;
		return;
	}

	cout << "Display tree:" << endl;

	int currLevel = 1;
	int nextLevel = 0;

	queue<Node*> queue;
	queue.push(m_Root);
	while (!queue.empty())
	{
		Node* curr = queue.front();
		queue.pop();
		currLevel--;

		if (curr == m_Root)
		{
			cout << "(" << curr->data << ") ";
			cout << endl;
		}

		if (curr->left != nullptr)
		{
			queue.push(curr->left);
			cout << "(" << curr->left->data << ") ";
			nextLevel++;
		}

		if (curr->right != nullptr)
		{
			queue.push(curr->right);
			cout << "(" << curr->right->data << ") ";
			nextLevel++;
		}

		if (currLevel == 0)
		{
			currLevel = nextLevel;
			nextLevel = 0;
			cout << endl;
		}
	}
}

bool BinaryTree::operator==(BinaryTree& rhs)
{
	if (m_Root == nullptr && rhs.m_Root == nullptr) return true;

	if (m_Root == nullptr || rhs.m_Root == nullptr) return false;

	if (m_Size != rhs.m_Size) return false;

	stack<Node*> stack1, stack2;
	stack1.push(m_Root);
	stack2.push(rhs.m_Root);

	while (!stack1.empty() && !stack2.empty())
	{
		Node* curr1 = stack1.top();
		stack1.pop();
		Node* curr2 = stack2.top();
		stack2.pop();
		
		if (curr1->data != curr2->data) return false;

		if (curr1->left != nullptr && curr2->left != nullptr)
		{
			stack1.push(curr1->left);
			stack2.push(curr2->left);
		}

		if (curr1->right != nullptr && curr2->right != nullptr)
		{
			stack1.push(curr1->right);
			stack2.push(curr2->right);
		}
	}

	return true;
}

// PRIVATE FUNCTIONS:

void BinaryTree::PreorderTraversal(Node* node)
{
	if (node == nullptr) return;

	cout << node->data << " ";
	PreorderTraversal(node->left);
	PreorderTraversal(node->right);
}

void BinaryTree::InorderTraversal(Node* node)
{
	if (node == nullptr) return;

	InorderTraversal(node->left);
	cout << node->data << " ";
	InorderTraversal(node->right);
}

void BinaryTree::PostorderTraversal(Node* node)
{
	if (node == nullptr) return;

	PostorderTraversal(node->left);
	PostorderTraversal(node->right);
	cout << node->data << " ";
}

void BinaryTree::LevelTraversal(Node* node)
{
	if (node == nullptr) return;

	queue<Node*> queue;
	queue.push(node);

	while (!queue.empty())
	{
		Node* curr = queue.front();	
		queue.pop();

		cout << curr->data << " ";
		if (curr->left != nullptr) queue.push(curr->left);		
		if (curr->right != nullptr) queue.push(curr->right);
	}
}

void BinaryTree::CalculateHeight()
{
	CalculateHeight(m_Root, 1);
}

void BinaryTree::CalculateHeight(Node* node, int level)
{
	if (node == nullptr) return;

	if (level > m_Height)
	{
		m_Height = level;
	}

	CalculateHeight(node->left, level + 1);
	CalculateHeight(node->right, level + 1);
}

void TestProblem2()
{
	BinaryTree tree1("Tree1.txt");
	BinaryTree tree2("Tree2.txt");

	tree1.Display();
	tree2.Display();

	tree1.PreorderTraversal();
	cout << endl;
	tree1.InorderTraversal();
	cout << endl;
	tree1.PostorderTraversal();
	cout << endl;
	tree1.LevelTraversal();
	cout << endl;
	tree1.PrintLeaves();
	cout << endl;

	(tree1 == tree2) ? cout << "YES" << endl : cout << "NO" << endl;

	tree1.IsComplete() ? cout << "Complete" << endl : cout << "Incomplete" << endl;

	cout << "Node " << 'g' << " is at depth: " << tree1.Depth('g');

	return EXIT_SUCCESS;
}
```

```cpp

#pragma once
#include <fstream>
#include <iostream>
#include <stack>
#include <string>


using std::cout;
using std::endl;
using std::stack;
using std::string;
using std::ifstream;


class Expression
{
public:
    Expression(string path);


    string GetExpression();


private:
    string m_Expression;
};


bool IsDigit(char ch);
bool IsOperator(char ch);
bool IsVariable(char ch);
int Precedence(char op);


#include "HeapSiArbori_Problema1_Expression.h"


Expression::Expression(string path) : m_Expression("")
{
    ifstream fin(path);


    if (!fin.is_open())
    {
        cout << "[INFO] Could not open file from " << path << "." << endl;
        return;
    }


    string infix;
    getline(fin, infix);


    string postfix;
    stack<char> operators;


    if (infix.length() < 3)
    {
        cout << "[INFO] Input expression is not valid." << endl;
        return;
    }


    for (char ch : infix)
    {
        if (ch == ' ') continue;


        if (IsDigit(ch) || IsVariable(ch))
        {
            postfix += ch;
        }
        else if (ch == '(')
        {
            operators.push(ch);
        }
        else if (ch == ')')
        {
            while (!operators.empty() && operators.top() != '(')
            {
                postfix += operators.top();
                operators.pop();
            }
            operators.pop();
        }
        else
        {
            while (!operators.empty() && operators.top() != '(' && Precedence(ch) <= Precedence(operators.top()))
            {
                postfix += operators.top();
                operators.pop();
            }
            operators.push(ch);
        }
    }


    while (!operators.empty())
    {
        postfix += operators.top();
        operators.pop();
    }


    m_Expression = postfix;
}


string Expression::GetExpression()
{
    return m_Expression;
}


bool IsDigit(char ch)
{
    return ch >= '0' && ch <= '9';
}


bool IsOperator(char ch)
{
    return
        ch == '^' ||
        ch == '*' ||
        ch == '/' ||
        ch == '+' ||
        ch == '-';
}


bool IsVariable(char ch)
{
    ch = tolower(ch);


    return ch >= 'a' && ch <= 'z';
}


int Precedence(char op)
{
    switch (op)
    {
    case '^':
        return 3;


    case '*':
    case '/':
        return 2;


    case '+':
    case '-':
        return 1;


    default:
        return 0;
    }
}


#pragma once
#include "HeapSiArbori_Problema1_Expression.h"
#include <map>
#include <sstream>


using std::cin;
using std::map;
using std::stringstream;


class SyntaxTree
{
public:
    struct Node
    {
        char data;
        Node* left;
        Node* right;


        Node(char d) : data(d), left(nullptr), right(nullptr) {}
        Node(char d, Node* l, Node* r) : data(d), left(l), right(r) {}
    };


    SyntaxTree(Expression expr);
   
    void Evaluate();
    void Display();


private:
    double EvaluateNode(Node* curr);
    void CalculateHeight(Node* curr, int level);
    void PrintNode(Node* curr, string format, bool isLast);


private:
    Node* m_Root;
    int m_Size;
    int m_Height;
    map<char, double> variables;
};


#include "HeapSiArbori_Problema1_SyntaxTree.h"


SyntaxTree::SyntaxTree(Expression expr) : m_Root(nullptr), m_Size(0), m_Height(0)
{
    stack<Node*> nodes;
    string postfix = expr.GetExpression();


    for (char ch : postfix)
    {
        if (IsDigit(ch) || IsVariable(ch))
        {
            if (IsVariable(ch)) variables[ch] = 0.0;


            Node* var = new Node(ch);
            nodes.push(var);
            m_Size++;
        }
        else
        {
            Node* right = nodes.top();
            nodes.pop();
            Node* left = nodes.top();
            nodes.pop();


            Node* parent = new Node(ch, left, right);
            nodes.push(parent);
        }
    }


    m_Root = nodes.top();
    CalculateHeight(m_Root, 1);
}


void SyntaxTree::Evaluate()
{
    if (!variables.empty())
    {
        for (auto& var : variables)
        {
            string input;
            double x;
            cout << var.first << " = ";
            getline(cin, input);
            stringstream(input) >> x;
            var.second = x;
        }
    }


    cout << "The result is: " << EvaluateNode(m_Root) << endl;
}


double SyntaxTree::EvaluateNode(Node* curr)
{
    if (curr == nullptr) return 0.0;


    if (variables.find(curr->data) != variables.end())
    {
        return variables[curr->data];
    }


    if (curr->left == nullptr && curr->right == nullptr)
    {
        return curr->data - '0';
    }


    double l = EvaluateNode(curr->left);
    double r = EvaluateNode(curr->right);


    switch (curr->data)
    {
    case '+':
        return l + r;


    case '-':
        return l - r;


    case '*':
        return l * r;


    case '/':
        return l / r;


    case '^':
        return pow(l, r);


    default:
        return 0;
    }
}


void SyntaxTree::Display()
{
    PrintNode(m_Root, "", false);
}


// PRIVATE FUNCTIONS


void SyntaxTree::CalculateHeight(Node* curr, int level)
{
    if (curr == nullptr) return;


    if (level > m_Height)
    {
        m_Height = level;
    }


    CalculateHeight(curr->right, level + 1);
    CalculateHeight(curr->left, level + 1);
}


void SyntaxTree::PrintNode(Node* curr, string format, bool isLast)
{
    if (curr == nullptr) return;


    cout << format;


    if (curr == m_Root)
    {
        cout << "Root: ";
        format += "      ";
    }
    else if (isLast)
    {
        cout << " +---";
        format += "     ";
    }
    else
    {
        cout << " +---";
        format += " |    ";
    }


    cout << '(' << curr->data << ')' << endl;


    PrintNode(curr->right, format, curr->left == nullptr);
    PrintNode(curr->left, format, true);
}


// Arbore sintactic
// Se citeste dintr-un fisier o expresie aritmetica formata din:
// 1. numere
// 2. variabile
// 3. operatori de baza (+, -, *, /) si paranteze
// Exemplu: (3+1)*7
// Exemplu: 4+x*((5-1+2)*3+2*(y-1))
// a) Sa se construiasca un arbore sintactic corespunzator expreisei. (2p)
// b) Sa se afiseze Arborele pe niveluri. (0.5p)
// c) Sa se evalueze expresia. Pentru variabile sa se ceara in mod repetat vari de tip double. (2p)


#include "HeapSiArbori_Problema1_SyntaxTree.h"
#include "conio.h"


int main()
{
    Expression expr("HeapSiArbori_Problema1.txt");


    SyntaxTree tree(expr);


    tree.Display();


    cout << "Press ESC to exit." << endl;
    do
    {
        tree.Evaluate();


    } while (_getch() != 27);


    return EXIT_SUCCESS;
}


4 + x * ( ( 5 - 1 + 2 ) * 3 + 2 * ( y - 1 ) )


// Operatii pe un arbore binar
// Se citeste dintr-un fisier un arbone binar. (1p)
// Modul de citire este pe niveluri (in latime)
// Sa se implementeze urmatoarele functii:
// 1. Functie ce calculeaza inaltimea unui arbore (0.5p)
// 2. Functii de parcurgerea arborelui (RSD, SRD, SDR, Niveluri) (0.5p)
// 3. Functie care afiseaza frunzele de la stanga la dreapta (0.5p)
// 4. Functie care verifica daca 2 arbori sunt identici (1p)
// 5. Functie care verifica daca un arbore e complet (0.5p)
// 6. Functie care determina adancimea unui nod (0.5p)


#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <stack>
#include <queue>


using std::make_pair;
using std::ifstream;
using std::vector;
using std::string;
using std::stack;
using std::queue;
using std::pair;
using std::cout;
using std::endl;


struct Node
{
    char data;
    Node* left;
    Node* right;


    Node(char d) : data(d), left(nullptr), right(nullptr) {}
};


class BinaryTree
{
public:
    BinaryTree();
    BinaryTree(string path);


    int GetSize();
    int GetHeight();


    void PreorderTraversal();
    void InorderTraversal();
    void PostorderTraversal();
    void LevelTraversal();


    void PrintLeaves();
    bool IsComplete();
   
    int Depth(char ch);
    void Display();


    bool operator == (BinaryTree& rhs);


private:
    void PreorderTraversal(Node* node);
    void InorderTraversal(Node* node);
    void PostorderTraversal(Node* node);
    void LevelTraversal(Node* node);


    void CalculateHeight();
    void CalculateHeight(Node* node, int level);


private:
    Node* m_Root;
    int m_Size;
    int m_Height;
};


BinaryTree::BinaryTree()
{
    m_Root = nullptr;
    m_Size = 0;
    m_Height = 0;
}


BinaryTree::BinaryTree(string path) : m_Root(nullptr), m_Size(0), m_Height(0)
{
    ifstream fin(path);


    if (!fin.is_open())
    {
        cout << "Coult not open file." << path << endl;
        return;
    }


    char ch;
    vector<char> vec;
    while (fin >> ch)
    {
        vec.emplace_back(ch);
    }


    m_Root = new Node(vec[0]);
    m_Size = 1;
    queue<Node*> queue;
    queue.push(m_Root);


    int i = 1;
    while (i < vec.size())
    {
        Node* curr = queue.front();
        queue.pop();


        if (i < vec.size())
        {
            curr->left = new Node(vec[i++]);
            m_Size++;
            queue.push(curr->left);
        }


        if (i < vec.size())
        {
            curr->right = new Node(vec[i++]);
            m_Size++;
            queue.push(curr->right);
        }
    }


    CalculateHeight();
    fin.close();
}


int BinaryTree::GetSize()
{
    return m_Size;
}


int BinaryTree::GetHeight()
{
    return m_Height;
}


void BinaryTree::PreorderTraversal()
{
    cout << "Preorder Traversal: " << endl;
    PreorderTraversal(m_Root);
}


void BinaryTree::InorderTraversal()
{
    cout << "Inorder Traversal: " << endl;
    InorderTraversal(m_Root);
}


void BinaryTree::PostorderTraversal()
{
    cout << "Postorder Traversal: " << endl;
    PostorderTraversal(m_Root);
}


void BinaryTree::LevelTraversal()
{
    cout << "Postorder Traversal: " << endl;
    LevelTraversal(m_Root);
}


void BinaryTree::PrintLeaves()
{
    if (m_Root == nullptr) return;


    queue<Node*> queue;
    queue.push(m_Root);


    cout << "Binary Tree leaves from left to right:" << endl;
    while (!queue.empty())
    {
        Node* curr = queue.front();
        queue.pop();


        if (curr->left == nullptr && curr->right == nullptr) cout << curr->data << " ";
        if (curr->left != nullptr) queue.push(curr->left);
        if (curr->right != nullptr) queue.push(curr->right);
    }
}


bool BinaryTree::IsComplete()
{
    if (m_Root == nullptr) return true;


    queue<Node*> queue;
    queue.push(m_Root);


    bool isIncomplete = false;


    while (!queue.empty())
    {
        Node* curr = queue.front();
        queue.pop();


        if (isIncomplete && (curr->left != nullptr || curr->right != nullptr)) return false;


        if (curr->left == nullptr && curr->right != nullptr) return false;


        if (curr->left == nullptr && curr->right != nullptr ||
            curr->left != nullptr && curr->right == nullptr)
            isIncomplete = true;


        if (curr->left != nullptr) queue.push(curr->left);
        if (curr->right != nullptr) queue.push(curr->right);
    }


    return true;
}


int BinaryTree::Depth(char ch)
{
    if (m_Root == nullptr) return -1;


    queue<pair<Node*, int>> queue;
    queue.push(make_pair(m_Root, 0));


    while (!queue.empty()) {
        pair<Node*, int> curr = queue.front();
        queue.pop();


        if (curr.first->data == ch) {
            return curr.second;
        }


        if (curr.first->left != nullptr) queue.push(make_pair(curr.first->left, curr.second + 1));




        if (curr.first->right != nullptr) queue.push(make_pair(curr.first->right, curr.second + 1));
    }


    return -1;
}


void BinaryTree::Display()
{
    if (m_Root == nullptr)
    {
        cout << "null" << endl;
        return;
    }


    cout << "Display tree:" << endl;


    int currLevel = 1;
    int nextLevel = 0;


    queue<Node*> queue;
    queue.push(m_Root);
    while (!queue.empty())
    {
        Node* curr = queue.front();
        queue.pop();
        currLevel--;


        if (curr == m_Root)
        {
            cout << "(" << curr->data << ") ";
            cout << endl;
        }


        if (curr->left != nullptr)
        {
            queue.push(curr->left);
            cout << "(" << curr->left->data << ") ";
            nextLevel++;
        }


        if (curr->right != nullptr)
        {
            queue.push(curr->right);
            cout << "(" << curr->right->data << ") ";
            nextLevel++;
        }


        if (currLevel == 0)
        {
            currLevel = nextLevel;
            nextLevel = 0;
            cout << endl;
        }
    }
}


bool BinaryTree::operator==(BinaryTree& rhs)
{
    if (m_Root == nullptr && rhs.m_Root == nullptr) return true;


    if (m_Root == nullptr || rhs.m_Root == nullptr) return false;


    if (m_Size != rhs.m_Size) return false;


    stack<Node*> stack1, stack2;
    stack1.push(m_Root);
    stack2.push(rhs.m_Root);


    while (!stack1.empty() && !stack2.empty())
    {
        Node* curr1 = stack1.top();
        stack1.pop();
        Node* curr2 = stack2.top();
        stack2.pop();
       
        if (curr1->data != curr2->data) return false;


        if (curr1->left != nullptr && curr2->left != nullptr)
        {
            stack1.push(curr1->left);
            stack2.push(curr2->left);
        }


        if (curr1->right != nullptr && curr2->right != nullptr)
        {
            stack1.push(curr1->right);
            stack2.push(curr2->right);
        }
    }


    return true;
}


// PRIVATE FUNCTIONS:


void BinaryTree::PreorderTraversal(Node* node)
{
    if (node == nullptr) return;


    cout << node->data << " ";
    PreorderTraversal(node->left);
    PreorderTraversal(node->right);
}


void BinaryTree::InorderTraversal(Node* node)
{
    if (node == nullptr) return;


    InorderTraversal(node->left);
    cout << node->data << " ";
    InorderTraversal(node->right);
}


void BinaryTree::PostorderTraversal(Node* node)
{
    if (node == nullptr) return;


    PostorderTraversal(node->left);
    PostorderTraversal(node->right);
    cout << node->data << " ";
}


void BinaryTree::LevelTraversal(Node* node)
{
    if (node == nullptr) return;


    queue<Node*> queue;
    queue.push(node);


    while (!queue.empty())
    {
        Node* curr = queue.front();
        queue.pop();


        cout << curr->data << " ";
        if (curr->left != nullptr) queue.push(curr->left);      
        if (curr->right != nullptr) queue.push(curr->right);
    }
}


void BinaryTree::CalculateHeight()
{
    CalculateHeight(m_Root, 1);
}


void BinaryTree::CalculateHeight(Node* node, int level)
{
    if (node == nullptr) return;


    if (level > m_Height)
    {
        m_Height = level;
    }


    CalculateHeight(node->left, level + 1);
    CalculateHeight(node->right, level + 1);
}


int main()
{
    BinaryTree tree1("Tree1.txt");
    BinaryTree tree2("Tree2.txt");


    tree1.Display();
    tree2.Display();


    tree1.PreorderTraversal();
    cout << endl;
    tree1.InorderTraversal();
    cout << endl;
    tree1.PostorderTraversal();
    cout << endl;
    tree1.LevelTraversal();
    cout << endl;
    tree1.PrintLeaves();
    cout << endl;


    (tree1 == tree2) ? cout << "YES" << endl : cout << "NO" << endl;


    tree1.IsComplete() ? cout << "Complete" << endl : cout << "Incomplete" << endl;


    cout << "Node " << 'g' << " is at depth: " << tree1.Depth('g');


    return EXIT_SUCCESS;
}


          a 
    b           c 
 d     e     f     g 
h i   j k   l m   n o


// Sortare
// Sa se implementeze algoritmul Heap-Sort. Sa se sorteze un vector de numere. (1p)


// Priority Queue
// Implementati o coada de prioritati folosind o structura HeapMax care sa aiba:
// Un camp m_Heap de tip vector de int care sa stocheze elementele cozii sub forma unui heap max
// Structura trebuia sa aiba:
// 1. Insert
// 2. ExtractMax
// 3. GetMax
// 4. SiftUp
// 5. SiftDown
// In functia main se declare o variabila de tip HeapMax
// Se foloseste un menu implementat cu ajutorul unei instructiuni switch (2p)


#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include "conio.h"


using std::vector;
using std::cin;
using std::cout;
using std::endl;
using std::swap;
using std::string;
using std::istringstream;


constexpr int ESC = 27;
constexpr int KEY_Y = 121;


struct Node
{
    int data;
    Node* left;
    Node* right;


    Node(int d) : data(d), left(nullptr), right(nullptr) {}
};


class HeapMax
{
public:
    HeapMax(vector<int>& vec);
    HeapMax(vector<int>& vec, bool sortOnInit);


    int GetMax();
    int GetHeight();


    void Insert(int val);
    int ExtractMax();


    void SiftUp(int i);
    void SiftDown(int i);


    void Sort();
    void Display();


private:
    int Parent(int i);
    int LeftChild(int i);
    int RightChild(int i);


private:
    vector<int> m_Heap;
    int m_Height;
};


HeapMax::HeapMax(vector<int>& vec, bool sortOnInit) :m_Heap(vector<int>()), m_Height(0)
{
    if (sortOnInit)
    {
        Sort();
    }


    for (int i : vec) m_Heap.emplace_back(i);
    m_Height = log2(vec.size());
}


HeapMax::HeapMax(vector<int>& vec) : m_Heap(vector<int>()), m_Height(0)
{
    for (int i : vec)
    {
        m_Heap.emplace_back(i);
        SiftUp(m_Heap.size() - 1);
    }
    m_Height = log2(vec.size());
}


int HeapMax::GetMax()
{
    return m_Heap[0];
}


int HeapMax::GetHeight()
{
    return log2(m_Heap.size());
}


void HeapMax::Insert(int val)
{
    m_Heap.emplace_back(val);
    SiftUp(m_Heap.size() - 1);
}


int HeapMax::ExtractMax()
{
    if (m_Heap.empty()) return -1;


    int toExtract = m_Heap[0];


    m_Heap[0] = m_Heap[m_Heap.size() - 1];
    m_Heap.pop_back();
    SiftDown(0);


    return toExtract;
}


// PRIVATE FUNCTIONS


int HeapMax::Parent(int i)
{
    return (i + 1) / 2;
}


int HeapMax::LeftChild(int i)
{
    return (i * 2) + 1;
}


int HeapMax::RightChild(int i)
{
    return (i + 2) + 2;
}


void HeapMax::SiftUp(int i)
{
    while (i > 0 && m_Heap[Parent(i)] < m_Heap[i])
    {
        swap(m_Heap[Parent(i)], m_Heap[i]);
        SiftUp(Parent(i));
    }
}


void HeapMax::SiftDown(int i)
{
    int imax = i;
    int l = LeftChild(i);
    int r = RightChild(i);


    if (l < m_Heap.size() && m_Heap[l] > m_Heap[imax])
    {
        imax = l;
    }


    if (r < m_Heap.size() && m_Heap[r] > m_Heap[imax])
    {
        imax = r;
    }


    if (i != imax)
    {
        swap(m_Heap[i], m_Heap[imax]);
        SiftDown(imax);
    }
}


void HeapMax::Sort()
{
    int n = m_Heap.size();


    for (int i = n / 2 - 1; i >= 0; i--) SiftDown(i);


    for (int i = n - 1; i >= 0; i--)
    {
        swap(m_Heap[0], m_Heap[i]);
        SiftDown(0);
    }
}


void HeapMax::Display()
{
    if (m_Heap.empty()) return;


    if (m_Heap.size() == 1) cout << m_Heap[0] << endl;


    for (int i = 0, k = 0; i <= m_Height; i++)
    {
        cout << "Level " << i << ": ";
        for (int j = 0; j < pow(2, i) && k < m_Heap.size(); j++)
        {
            cout << m_Heap[k++] << " ";
        }
        cout << endl;
    }
}


void MenuMain(string username);
void MenuCustomize(string& username);
void MenuInsert(HeapMax& heapMax);
void MenuGetMax(HeapMax& heapMax);
void MenuExtractMax(HeapMax& heapMax);
void MenuSiftUp(HeapMax& heapMax);
void MenuSiftDown(HeapMax& heapMax);
void MenuSort(HeapMax& heapMax);
void MenuDisplay(HeapMax& heapMax);
void MenuExit(bool& exit);


void MenuCustomize(string& username)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                 Customize                |\n"
        << "\t\t|            Customize your name           |\n"
        << "\t\t+------------------------------------------+\n";
    cout << "<" << username << "> ";
    string newUsername = username;
    getline(cin, newUsername);
    if (newUsername != username || newUsername != "")
    {
        username = newUsername;
        cout << "Name changed successfully." << endl;
        cout << "Press ESC to continue." << endl;
        while (_getch() != ESC);
    }
    return;
}


void MenuMain(string username)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                1. Customize              |\n"
        << "\t\t|                2. Insert()               |\n"
        << "\t\t|                3. GetMax()               |\n"
        << "\t\t|                4. ExtractMax()           |\n"
        << "\t\t|                5. SiftUp()               |\n"
        << "\t\t|                6. SiftDown()             |\n"
        << "\t\t|                7. Sort()                 |\n"
        << "\t\t|                8. Display()              |\n"
        << "\t\t|                9. Exit                   |\n"
        << "\t\t+------------------------------------------+\n";
    cout << "<" << username << "> ";
    return;
}


void MenuExit(bool& exit)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|      Are you sure you want to quit?      |\n"
        << "\t\t|           Press Y to confirm.            |\n"
        << "\t\t+------------------------------------------+\n";
    if (_getch() == KEY_Y)
    {
        system("cls");
        cout
            << "\t\t+------------------------------------------+\n"
            << "\t\t|                 Goodbye                  |\n"
            << "\t\t+------------------------------------------+\n";
        exit = true;
    }


    return;
}


void MenuInsert(HeapMax& heapMax)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                  Insert                  |\n"
        << "\t\t+------------------------------------------+\n";
    do {
        int val = 0;
        string input = "";
        cout << "Value> ";
        getline(cin, input);
        istringstream(input) >> val;
        heapMax.Insert(val);
        cout << "Press ESC to continue." << endl;
    } while (_getch() != ESC);
    return;
}


void MenuGetMax(HeapMax& heapMax)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                  GetMax                  |\n"
        << "\t\t+------------------------------------------+\n";
    cout << "The max value is: " << heapMax.GetMax() << endl;
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void MenuExtractMax(HeapMax& heapMax)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                ExtractMax                |\n"
        << "\t\t+------------------------------------------+\n";
    do {
        cout << "Extract> " << heapMax.GetMax();
        heapMax.ExtractMax();
        cout << "Press ESC to continue." << endl;
    } while (_getch() != ESC);
    return;
}


void MenuSiftUp(HeapMax& heapMax)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                 SiftUp                   |\n"
        << "\t\t+------------------------------------------+\n";
    do {
        int i = 0;
        string input = "";
        cout << "Index> ";
        getline(cin, input);
        istringstream(input) >> i;
        heapMax.SiftUp(i);
        cout << "Press ESC to continue." << endl;
    } while (_getch() != ESC);
    return;
}


void MenuSiftDown(HeapMax& heapMax)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                SiftDown                  |\n"
        << "\t\t+------------------------------------------+\n";
    do {
        int i = 0;
        string input = "";
        cout << "Index> ";
        getline(cin, input);
        istringstream(input) >> i;
        heapMax.SiftDown(i);
        cout << "Press ESC to continue." << endl;
    } while (_getch() != ESC);
    return;
}


void MenuSort(HeapMax& heapMax)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                  Sort                    |\n"
        << "\t\t+------------------------------------------+\n";
    cout << "Before: " << endl;
    heapMax.Display();
    heapMax.Sort();
    cout << "After: " << endl;
    heapMax.Display();
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void MenuDisplay(HeapMax& heapMax)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                 Display                  |\n"
        << "\t\t+------------------------------------------+\n";
    heapMax.Display();
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void InitMenu()
{
    int option = 0;
    bool exit = false;
    bool subMenu = false;
    string username = "";
    string input = "";
    vector<int> vec{ 9,8,7,6,5,4,3,2,1,0, 10, 11, 12, 13, 14 };


    HeapMax heapMax(vec, false);
    do
    {
        MenuMain(username);
        getline(cin, input);
        istringstream(input) >> option;
        switch (option)
        {
        case 1:
            MenuCustomize(username);
            break;


        case 2:
            MenuInsert(heapMax);
            break;


        case 3:
            MenuGetMax(heapMax);
            break;


        case 4:
            MenuExtractMax(heapMax);
            break;


        case 5:
            MenuSiftUp(heapMax);
            break;


        case 6:
            MenuSiftDown(heapMax);
            break;


        case 7:
            MenuSort(heapMax);
            break;


        case 8:
            MenuDisplay(heapMax);
            break;
        case 9:
            MenuExit(exit);
            break;
        }
    } while (!exit);


    return;
}


int main()
{
    InitMenu();
    return EXIT_SUCCESS;
}


```