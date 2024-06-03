# Homework 5

```cpp
/*
Arbore binar de cautare
Implementati un arbore binar de cautare cu chei numere intregi
Utilizati o structura Node care are:
1. un camp tip int ce stocheaza cheia nodului
2. trei campuri de tip pointer la Node pentru fiul stang, fiul drept, si parintele nodului
De asemenea structura Node dispune de un constructor care seteaza campul int la o valoare transmisa prin paramentru si campurile de tip pointrer la Node le initializeaza cu nullptr
Utilizati apoi o strcutura de tip SearchTree, care are ca membru o radacina root de tip pointer la Node.
Structura trebuie sa dispuna de un constructor care initializeaza radacina cu nullptr.
In functia main se declara o variabila de tip SearchTree si se foloseste un menu implementat cu ajutorul unei structuri switch prin care utilizatorul poate selecta oricare dinstre operatii
In plus structura trebuie sa aiba metodele:
Insert(int key)
Max(Node* x)
Min(Node* x)
Successor(Node* x)
Predecessor(Node* x)
Find(int key)
Delete(int key)
Erase(Node* x)
Display(int opt)
Construct()
Empty()
Clear()
*/
```

```cpp

#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <vector>
#include <stack>
#include <queue>
#include "conio.h"


using std::istringstream;
using std::ifstream;
using std::string;
using std::vector;
using std::stack;
using std::queue;
using std::cout;
using std::endl;
using std::cin;
constexpr int ESC = 27;
constexpr int KEY_Y = 121;
constexpr int KEY_N = 79;


struct Node
{
    int data;
    Node* left;
    Node* right;
    Node* parent;


    Node(int d) : data(d), left(nullptr), right(nullptr), parent(nullptr) {}
};


struct SearchTree
{
    Node* root;


    SearchTree() : root(nullptr) {}
    void Insert(int key);
    Node* Max(Node* x);
    Node* Min(Node* x);
    Node* Successor(Node* x);
    Node* Predecessor(Node* x);
    Node* Find(int key);
    void Transpose(Node* u, Node* v);
    void Delete(int key);
    void Erase(Node* x);
    void Display(int opt);
    void Construct();
    bool Empty();
    void Clear();
    void Clear(Node* node);


    void PreorderTraversal(Node* node);
    void InorderTraversal(Node* node);
    void PostorderTraversal(Node* node);
    void LevelTraversal(Node* node);
};


void SearchTree::Insert(int key)
{
    Node* node = new Node(key);


    if (root == nullptr)
    {
        root = node;
        return;
    }


    Node* curr = root;
    Node* par = nullptr;


    while (curr != nullptr)
    {
        par = curr;
        if (key < curr->data) curr = curr->left;
        else curr = curr->right;
    }


    node->parent = par;
    if (key < par->data) par->left = node;
    else par->right = node;
}


Node* SearchTree::Max(Node* x)
{
    Node* max = x;


    while (max->right != nullptr) max = max->right;


    return max;
}


Node* SearchTree::Min(Node* x)
{
    Node* min = x;


    while (min->left != nullptr) min = min->left;


    return min;
}


Node* SearchTree::Successor(Node* x)
{
    Node* succ = x;


    if (x->right != nullptr) succ = Min(x->right);
    else
    {
        succ = x->parent;
        while (succ != nullptr && x == succ->right)
        {
            x = succ;
            succ = succ->parent;
        }
    }


    return succ;
}


Node* SearchTree::Predecessor(Node* x)
{
    Node* pred = x;


    if (x->left != nullptr) pred = Max(x->left);
    else
    {
        pred = x->parent;
        while (pred != nullptr && x == pred->left)
        {
            x = pred;
            pred = pred->parent;
        }
    }


    return pred;
}


Node* SearchTree::Find(int key)
{
    if (root == nullptr) return nullptr;


    Node* targ = root;


    while (targ != nullptr && targ->data != key)
    {
        if (key < targ->data) targ = targ->left;
        if (key > targ->data) targ = targ->right;
    }


    return targ;
}


void SearchTree::Transpose(Node* u, Node* v)
{
    if (u->parent == nullptr) root = v;
    else
    {
        if (u == u->parent->left) u->parent->left = v;
        else u->parent->right = v;
    }


    if (v != nullptr) v->parent = u->parent;
}


void SearchTree::Delete(int key)
{
    Node* node = Find(key);
    Erase(node);
}


void SearchTree::Erase(Node* node)
{
    Node* succ = nullptr;


    if (node->left == nullptr) Transpose(node, node->right);
    else
    {
        if (node->right == nullptr) Transpose(node, node->left);
        else
        {
            succ = Successor(node);
            if (succ != node->right)
            {
                Transpose(succ, succ->right);
                succ->right = node->right;
                node->right->parent = succ;
            }
            Transpose(node, succ);
            succ->left = node->left;
            node->left->parent = succ;
        }
    }
}


void SearchTree::Display(int opt)
{
    if (Empty())
    {
        cout << "SearchTree is empty." << endl;
        cout << "\n---------------------------------------\n";
        return;
    }


    switch (opt)
    {
    case 1:
        cout << "Preorder Traversal: " << endl;
        PreorderTraversal(root);
        cout << "\n---------------------------------------\n";
        return;


    case 2:
        cout << "Inorder Traversal: " << endl;
        InorderTraversal(root);
        cout << "\n---------------------------------------\n";
        return;


    case 3:
        cout << "Postorder Traversal: " << endl;
        PostorderTraversal(root);
        cout << "\n---------------------------------------\n";
        return;


    case 4:
        cout << "Level Traversal: " << endl;
        LevelTraversal(root);
        cout << "\n---------------------------------------\n";
        return;


    default:
        return;
    }
}


void SearchTree::Construct()
{
    ifstream fin("Keys.txt");


    if (!fin.is_open())
    {
        cout << "Could not open file from path" << endl;
        return;
    }


    vector<int> keys;
    int x;


    while (fin >> x)
    {
        keys.emplace_back(x);
    }


    for (auto i : keys)
    {
        Insert(i);
    }
}


bool SearchTree::Empty()
{
    return root;
}


void SearchTree::Clear()
{
    Clear(root);
}


void SearchTree::Clear(Node* node)
{
    if (node == nullptr) return;


    Clear(node->left);
    Clear(node->right);
    cout << "Deleted" << node->data;
    delete node;
}


void SearchTree::PreorderTraversal(Node* node)
{
    if (node == nullptr) return;


    cout << node->data << " ";
    PreorderTraversal(node->left);
    PreorderTraversal(node->right);
}


void SearchTree::InorderTraversal(Node* node)
{
    if (node == nullptr) return;


    InorderTraversal(node->left);
    cout << node->data << " ";
    InorderTraversal(node->right);
}


void SearchTree::PostorderTraversal(Node* node)
{
    if (node == nullptr) return;


    PostorderTraversal(node->left);
    PostorderTraversal(node->right);
    cout << node->data << " ";
}


void SearchTree::LevelTraversal(Node* node)
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


void MenuMain(string username);
void MenuCustomize(string& username);
void MenuInsert(SearchTree& tree);
void MenuMax(SearchTree& tree);
void MenuMin(SearchTree& tree);
void MenuSuccessor(SearchTree& tree);
void MenuPredecessor(SearchTree& tree);
void MenuFind(SearchTree& tree);
void MenuDelete(SearchTree& tree);
void MenuDisplay(SearchTree& tree);
void MenuExit(bool& exit);


void MenuMain(string username)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                1. Customize              |\n"
        << "\t\t|                2. Insert()               |\n"
        << "\t\t|                3. Max()                  |\n"
        << "\t\t|                4. Min()                  |\n"
        << "\t\t|                5. Successor()            |\n"
        << "\t\t|                6. Predecessor()          |\n"
        << "\t\t|                7. Find()                 |\n"
        << "\t\t|                8. Delete()               |\n"
        << "\t\t|                9. Display()              |\n"
        << "\t\t|               10. Clear()                |\n"
        << "\t\t|               11. Exit                   |\n"
        << "\t\t+------------------------------------------+\n";
    cout << "<" << username << "> ";
    return;
}


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


void MenuInsert(SearchTree& tree)
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
        tree.Insert(val);
        cout << "Press ESC to continue." << endl;
    } while (_getch() != ESC);
    return;
}


void MenuMax(SearchTree& tree)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                  Max                     |\n"
        << "\t\t+------------------------------------------+\n";


    int val = 0;
    string input = "";
    cout << "Value> ";
    getline(cin, input);
    istringstream(input) >> val;
    cout << "The max value is: " << tree.Max(tree.Find(val)) << endl;
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void MenuMin(SearchTree& tree)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                  Min                     |\n"
        << "\t\t+------------------------------------------+\n";


    int val = 0;
    string input = "";
    cout << "Value> ";
    getline(cin, input);
    istringstream(input) >> val;
    cout << "The min value is: " << tree.Min(tree.Find(val)) << endl;
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void MenuSuccessor(SearchTree& tree)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                  Sucessor                |\n"
        << "\t\t+------------------------------------------+\n";


    int val = 0;
    string input = "";
    cout << "Value> ";
    getline(cin, input);
    istringstream(input) >> val;
    cout << "The successor of " << val << " is: " << tree.Successor(tree.Find(val)) << endl;
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void MenuPredecessor(SearchTree& tree)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                Predecessor               |\n"
        << "\t\t+------------------------------------------+\n";


    int val = 0;
    string input = "";
    cout << "Value> ";
    getline(cin, input);
    istringstream(input) >> val;
    cout << "The predecessor of " << val << " is: " << tree.Predecessor(tree.Find(val)) << endl;
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void MenuFind(SearchTree& tree)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                  Find                    |\n"
        << "\t\t+------------------------------------------+\n";


    int val = 0;
    string input = "";
    cout << "Value> ";
    getline(cin, input);
    istringstream(input) >> val;
    if (tree.Find(val)) cout << "Found." << endl;
    else cout << "Not Found" << endl;
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void MenuDelete(SearchTree& tree)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                  Delete                  |\n"
        << "\t\t+------------------------------------------+\n";


    int val = 0;
    string input = "";
    cout << "Value> ";
    getline(cin, input);
    istringstream(input) >> val;
    if (tree.Find(val))
    {
        tree.Delete(val);
        cout << "Deleted " << val << endl;
    }
    else cout << "Not Found" << endl;
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void MenuClear(SearchTree& tree)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                  Clear                   |\n"
        << "\t\t+------------------------------------------+\n";


    cout << "Are you sure you want to clear the tree?" << endl;
    if (_getch() == KEY_Y)
    {
        tree.Clear();
        cout << "Cleared tree." << endl;
    }
    else if (_getch() == KEY_Y)
    {
        cout << "Tree not cleared" << endl;
    }
    cout << "Press ESC to continue." << endl;
    while (_getch() != ESC);
    return;
}


void MenuDisplay(SearchTree& tree)
{
    system("cls");
    cout
        << "\t\t+------------------------------------------+\n"
        << "\t\t|                 Display                  |\n"
        << "\t\t+------------------------------------------+\n";
    int val = 0;
    string input = "";
    cout << "Value> ";
    getline(cin, input);
    istringstream(input) >> val;
    tree.Display(val);
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


    SearchTree tree;


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
            MenuInsert(tree);
            break;


        case 3:
            MenuMax(tree);
            break;


        case 4:
            MenuMin(tree);
            break;


        case 5:
            MenuSuccessor(tree);
            break;


        case 6:
            MenuPredecessor(tree);
            break;


        case 7:
            MenuFind(tree);
            break;


        case 8:
            MenuDelete(tree);
            break;


        case 9:
            MenuDisplay(tree);
            break;


        case 10:
            MenuClear(tree);
            break;


        case 11:
            MenuExit(exit);
            break;
        }
    } while (!exit);


    return;
}


```