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