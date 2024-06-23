# MAP

## Modulul 1

### TODO 1/7

Folosind aplcatia ildasm.exe, vizualizati codul CIL al unei aplicatii .NET. Care este instructiunea in care se cheama o metoda a unui obiect?

```cs
public void Test([MarshalAs((short)70)] int test) { }
```

```il
// IL from Ildasm.exe output
.method public hidebysig instance void Test(int32  marshal({ 46 }) test) cil managed
```

```il
.class public auto ansi beforefieldinit MyClass
  extends [mscorlib]System.Object
  implements IMyInterface
  {
    .interfaceimpl type IMyInterface
    .custom instance void
      [mscorlib]System.Diagnostics.DebuggerNonUserCodeAttribute::.ctor() = ( 01 00 00 00 )
      …
```

### TODO 2/7

Inspectati un assembly .NET folosind ildasm si determinati numarul de versiune si assembly-urile de care depinde. Aceste metadate se gasesc in seciunea Manifest, precum in imaginea de mai jos:

![alt text](image.png)

![alt text](image-1.png)


### TODO 3/7

Care este lista de assemblies care se gaseste pe calculatorul dvs?

```ps
Get-ChildItem -Path "C:\Windows\Microsoft.NET\Framework" -Recurse -Include *.dll
```

```
    Directory: C:\Windows\Microsoft.NET\Framework\v1.0.3705

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           12/7/2019 11:10 AM          96632 mscormmc.dll

    Directory: C:\Windows\Microsoft.NET\Framework\v2.0.50727\1033

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           12/3/2019 11:04 PM          28536 alinkui.dll
-a---           12/3/2019 11:04 PM         145272 cscompui.dll
-a---           12/3/2019 11:04 PM          13688 CvtResUI.dll
-a---           12/3/2019 11:04 PM         192888 vbc7ui.dll
-a---           12/3/2019 11:04 PM         218184 Vsavb7rtUI.dll

...etc
```

#### Test de evaluare 1/2

1. Despre Common Intermediate Language:

a) cunoaste conceptul de polimorfism  
b) este disponibil doar pentru limbajele C# si Visual Basic.NET  
c) este limbaj masina  

> Raspuns:  
a) cunoaste conceptul de polimorfism  

2. Functionalitatile de nivel scazut (precum operatii de intrare/iesire, fire de executie) sunt asigurate de:

a) FCL (Framework Class Library)  
b) CLS (Common Language Specification)  
c) BCL (Base Class Library)  
d) CTS (Common Type System)  

> Raspuns:  
c) CLS (Common Language Specification)  

3. In ce varianta de JIT se face precompilarea intregului cod CIL (Common Intermediate Language)?

a) normal JIT  
b) ecno-JIT  
c) pre-JIT  

> Raspuns:
c) pre-JIT  

4. Din ce se compune un assembly?

a) cod compilat  
b) metadate  
c) intregul cod sursa al aplicatiei  
d) manifest  

> Raspuns:  
a) cod compilat,  
b) metadate,  
c) manifest  

5. Cine se ocupa de dealocarea de memorie?

a) CLS (Common Language Specification)  
b) BCL (Base Class Library)  
c) CTS (Common Type System)  

> Raspuns:  
Niciunul din raspunsurile indicate; delocarea se face de catre Garbage Collection, parte din Common Language Runtime  


### TODO 4/7

Afisati valoarea maxima care se poate reprezenta de catre o variabila de tip int. Indicatie: se foloseste proprietatea MaxValue a tipului int.
```cs
Console.WriteLine($"int.MaxValue={int.MaxValue}");
/*
int.MaxValue=2147483647
*/
```

### TODO 5/7

Pentru tipul enumerare LineStyle definit anterior scrieti o aplicatie care sa afiseze pe ecran campurile pe care le contine.
```cs
Console.WriteLine($"LineStyle.{LineStyle.Solid}, LineStyle.{LineStyle.Dotted}, LineStyle.{LineStyle.DotDash}");
/*
LineStyle.Solid, LineStyle.Dotted, LineStyle.DotDash
*/

```

### TODO 6/7
Varificati daca variabila myJaggedArray poate fi initializata asfel:
```cs
int[][] myJaggedArray = {
  {  1,  3,  5,  7,  9 },
  {  0,  2,  4,  6 },
  { 11, 12 },
};

/*
Error (active)	CS0623	Array initializers can only be used in a variable or field initializer. Try using a new expression instead.
*/

int[,] myJaggedArray2 = {
  {  1,  3,  5,  7,  9 },
  {  0,  2,  4,  6 },
  { 11, 12 },
};

/*
Error (active)	CS0847	An array initializer of length '5' is expected
*/

```

### TODO 7/8

Care este avertismentul care se primeste daca se incearca o atribuire de la valoare double unei variabile de tip int?
```cs
double real = 12.3;
int integer = real;
/*
Error (active)	CS0266	Cannot implicitly convert type 'double' to 'int'. An explicit conversion exists (are you missing a cast?)
*/
```

#### Test de evaluare 2/2

1. Despre tipuri de date:

a) tipurile simple sunt tipuri valoare  
b) un tablou de intregi este un tip valoare  
c) tipurile valoare sunt derivate (direct sau indirect) din tipul obiect  
d) conversia de la tipuri valoare la tipuri referinta este de tip explicit si se numeste boxing  

> Raspuns:  
a) tipurile simple sunt tipuri valoare  
c) tipurile valoare sunt derivate din tipul obiect  
d) ar fi corect daca nu s-ar fi specificat explicit - boxing-ul este conversie implicita  

2. Despre tipul string:  

a) este un tip referinta  
b) este tip predefinit  
c) continutul unei variabile de tip string este imutabil  
d) permite verbatim literal  

> Raspuns:  
a) este un tip referinta  
b) este tip predefinit  
c) continutul unei variabile de tip string este imutabil  
d) permite verbatim literal  

3. Pentru tipurile numerice de mai jos, ce este adevarat?

a) float este alias pentru System.Float si se reprezinta pe 32 de biti  
b) double este alias pentru System.Double si se reprezinta pe 64 de biti  
c) byte este tip intreg cu semn, pe 8 biti  
d) decimal este tip numeric in virgula mobila, reprezentat pe 64 de biti  
e) decimal poate reprezenta NaN  
f) literalii de tip decimal se exprima cu sufixul m sau M  

> Raspuns:  
b) double este alias pentru System.Double si se reprezinta pe 64 de biti  
f) literalii de tip decimal se exprima cu suficul m sau M  

4. Despre tipuri enumerare:

a) sunt tipuri valoare  
b) pot contine doua campuri de nume diferite dar cu aceeasi valoare asociata  
c) pot fi reprezentate prin valori in virgula mobila  
d) pot contine intotdeauna si valori negative  
e) permit conversii implicite la valori numerice intregi (de exemplu, la valoare 1)  

> Raspuns:  
a) sunt tipuri valoare  
b) pot contine doua campuri de nume diferite dar cu aceeasi valoare asociata  

5. Pentru linia:  
```cs
int[,] tab = { { 1, 2, }, { 3, 4 } };
```
Este adevarat?  

a) este incorecta si va genera eroare de compilare  
b) proprietatea Length returneaza valoare 2  
c) proprietatea Length returneaza valoare 4  
d) metoda Length() returneaza valoare 2  
e) metoda Length() returneaza valoare 4  

> Raspuns:  
c) proprietatea Length returneaza valoarea 4  

6. Care din urmatoarele sunt conversii implicite?  

a) de la float la double  
b) de la double la float  
c) de la 0 la orice variabila de tip enumerare  
d) de la un tablou de tip string de 3 elemente la unul de tip object  
e) de la un tablou de tip int de 3 elemente la unul de tip object  

> Raspuns:  
a) de la float la double  
c) de la 0 la orice variabila de tip enumerare  
d) de la un tablou de tip string de 3 elemente la unul de tip object  

7. Pentru secventa:  
```cs
int x = 3;
object y = x;
```
Este adevarat? 

a) eroare la compilare  
b) eroare la rulare  
c) la rulare se poate testa daca in interiorul variabilei y se afla un intreg folosind operatorul 'is'  
d) la rulare se poate testa daca in interiorul variabilei y se afla un intreg folosind operatorul 'as'  
e) nu putem sti la rulare daca y provine din boxing-ul unei valori intregi  

> Raspuns:  
c) la rulare se poate testa daca in interiorul variabilei y se afla un intreg folosind operatorul 'is'  

## Modulul 2

### TODO 1/16

Parcurgeti articolul "Go To Statement Considered Harmful" Edsger W. Dijkstra, Communications of the ACM, Vol. 11, No. 3, March 1968, pp. 147-148.

### TODO 2/16

Scrieti un exemplu de ciclu do ... while pentru care valoarea unei variabile intregi afisata dupa iesirea din ciclu sa fie diferita de ultima valoare a variabilei din executia ciclului.

```cs
int number = 0;

do
{
    ++number;
} while (number < 3);

Console.WriteLine($"number={++number}");

/*
number=4
*/
```

### TODO 3/16

Testati printr-un exemplu ca variabila folosita pentru iterare in cadrul unui foreach nu isi poate schimba valoarea prin instructiune de atribuire  

```cs
int[] numbers = { 1, 2, 3, 4, 5, 6, 7, 8 };

foreach (int number in numbers)
{
    number = number - 1;
}

/*
Error (active)	CS1656	Cannot assign to 'number' because it is a 'foreach iteration variable'
*/
```

### TODO 4/16

Se poate sa declaram un spatiu de nume N1^ in interiorul unuia numit tot N1? Se poate sa declaram spatiul de nume N1 in interiorul spatiului de nume deja existent System?

```cs
using System;

Console.WriteLine($"Nice.Nice.Nice.NiceString={Nice.Nice.Nice.NiceString}");
Console.WriteLine($"System.Nice.NiceSystemString={System.NiceSystem.NiceSystemString}");

namespace Nice
{
    namespace Nice
    {
        class Nice
        {
            public static readonly string NiceString = "Nice.Nice.Nice.Nice";
        }
    }
}

namespace System
{
    class Nice
    {
        public static readonly string NiceSystemString = "System.Nice.Nice";
    }
}

/*
Nice.Nice.Nice.NiceString=Nice.Nice.Nice.Nice
System.Nice.NiceSystemString=System.Nice.Nice
*/
```

### TODO 5/16

Scrieti o metoda care primeste un parametru de tip tablou de intregi unidimensional, astfel incat la revenire din apel variabila trimisa din apel sa aiba cu 1 element mai mult

```cs
static void AddElement(ref int[] numbers, int newElement) {
    Array.Resize(ref numbers, numbers.Length + 1);
    numbers[numbers.Length - 1] = newElement;
}

int[] numbers = { 1, 2, 3, 4, 5, 6, 7, 8 };
int beforeLength = numbers.Length;

AddElement(ref numbers, 9);

int afterLength = numbers.Length;

Console.WriteLine($"beforeLength={beforeLength}, afterLength={afterLength}");

/*
beforeLength=8, afterLength=9
*/
```

### TODO 6/16

Notati diferentele dintre directiva using ca alias si directiva using pentru import simbolic

Directiva using ca alias este folosita pentru a crea nume alternative pentru namespace-uri sau tipuri, in timp ce directiva using pentru import simbolic este utilizată pentru a importa membri statici in toate fisierele sursa.

```cs
// Directiva using ca alias
using TextBoxForms = System.Windows.Forms.TextBox;
using TextBoxWeb = System.Web.UI.WebControls.TextBox;
```

```cs
// Directiva using pentru import simbolic
using static System.Math;
```

#### Test de evaluare a cunostinelor 1/1

1. Despre instructiuni de selectie:

a) codul de mai jos genereaza eroare de compilare  
```cs
if (3) {
  Console.WriteLine("Hello, world!");
}

/*
Error (active)	CS0029	Cannot implicitly convert type 'int' to 'bool'
*/
```
b) o ramura case poate sa nu se incheie cu break, chiar daca contine macar o instructiune  
c) in instructiunea switch este permis ca expresia tastata sa fie un sir de caractere  
d) ramura default din cadrul unei instructiuni switch poate fi prima din bloc 
e) putem intalni instructiunea goto default;  

> Raspuns:  
a) codul de mai jos genereaza eroare de compilare  
b) o ramura case poate sa nu se incheie cu break, chiar daca contine macar o instructiune  
c) in instructiunea switch este permis ca expresia tastata sa fie un sir de caractere  
d) ramura default din cadrul unei instructiuni switch poate fi prima din bloc  
e) putem intalni instructiunea goto default;  

2. Care este instructiunea care determina salt peste restul instructiunilor dintr-un ciclu si continuarea de la urmatoare ciclare?

a) break  
b) return  
c) if  
d) case  
e) continue  
f) return  

> Raspuns:  
e) continue  

3. Varificarea din cadrul blocului checked se efectueaza la:

a) doar la compilare  
b) doar la rulare  
c) atat la compilare, cat si la rulare  

> Raspuns:  
b) doar la rulare  

4. Care este metoda care se apeleaza automat la finalul blocului unei instructiuni using?

a) Delete()  
b) Close()  
c) Exit()  
d) Deallocate()  
e) nu exista instructiunea using  

> Raspuns:  
Niciun raspuns din cele indicate; metoda referita este Dispose();  

5. Gradul de vizibilitate implicit al unei clase declarate intr-un spatiu de nume este:

a) public  
b) private  
c) protected  
d) internal  
e) protected internal  

> Raspuns:  
d) internal  

6. In C# transmiterea de parametri se face implicit prin:

a) valoare  
b) referinta, prin ref  
c) referinta, prin out  
d) variabilele de tip valoare se transmit prin valoare, cele de tip referinta prin referinta  

> Raspuns:  
d) variabilele de tip valoare se transmit prin valoare, cele de tip referinta prin referinta  


### TODO 7/16

Care este eroarea afisata la incercarea de accesare a unui camp static prin intermediul unui obiect?  

```cs
/*
Error (active)	CS0176	Member 'Vector2.X' cannot be accessed with an instance reference; qualify it with a type name instead
*/
namespace Map
{
    public class Vector2
    {
        private static float _x;
        private static float _y;

        public static float X
        {
            get
            {
                return _x;
            }

            set
            {
                if (_x != value)
                {
                    _x = value;
                }
            }
        }

        public static float Y
        {
            get
            {
                return _y;
            }

            set
            {
                if (_y != value)
                {
                    _y = value;
                }
            }
        }

        public Vector2(float x, float y)
        {
            _x = x;
            _y = y;
        }
        public static void Scale(float factor)
        {
            _x *= factor;
            _y *= factor;
        }
    }

    public class MapProgram
    {
        private static void Main(string[] args)
        {
            Vector2 point = new(1.2f, 3.4f);
            point.X = 0.1f;



        }
    }
}
```

### TODO 8/16

Ce eroare de compilare apare daca se declara un camp constant de tipul clasei A? Ce eroare apare daca se declara un camp constant de tip int, dar fara sa i se specifice o valoare intiala?

```cs
/*
Error (active)	CS0145	A const field requires a value to be provided
*/

const A thing;
const int num;

class A
{
    const int PROP = 2;
}
```

### TODO 9/16

Verificati daca plecand de la un obiect se poate face apel de metoda statica declarata pentru clasa obiectului

```cs
/*
Error (active)	CS0176	Member 'Thing.Exist()' cannot be accessed with an instance reference; qualify it with a type name instead
*/

Thing thing = new Thing();

thing.Exist();

class Thing
{
    public static void Exist()
    {
        Console.WriteLine("A thing exists.");
    }
}
```

### TODO 10/16

Proprietatea Length a unei variabile sir de caractere permite modificarea lungimii sirului? Cum a fost declarata proprietatea, in acest sens?

```cs
/*

Error (active)	CS0200	Property or indexer 'string.Length' cannot be assigned to -- it is read only
*/

string word = "Fun";

word.Length = 600;
```

### TODO 11/16

Implementati un control utilizator dupa modelul de mai sus si utiliati-l intr-o forma Windows.

```cs
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Learning.Views
{
    public partial class ThingUserControl : UserControl
    {

        private Label _streetLabel;
        private TextBox _streetTextBox;

        private Label _numberLabel;
        private TextBox _numberTextBox;

        private Label _phoneLabel;
        private TextBox _phoneTextBox;

        public ThingUserControl()
        {
            InitializeComponent();

            _streetLabel = new Label();
            _streetTextBox = new TextBox();

            _numberLabel = new Label();
            _numberTextBox = new TextBox();

            _phoneLabel = new Label();
            _phoneTextBox = new TextBox();

            _streetLabel.Name = "streetLabel";
            _streetLabel.TabIndex = 0;
            _streetLabel.Content = "Street";
            _streetLabel.Width = 16;
            _streetLabel.Height = 8;
            _streetTextBox.Name = "streetTextBox";
            _streetTextBox.TabIndex = 1;
            _streetTextBox.Text = "";
            _streetTextBox.Width = 48;
            _streetTextBox.Height = 8;

            _numberLabel.Name = "numberLabel";
            _numberLabel.TabIndex = 2;
            _numberLabel.Content = "Number";
            _numberLabel.Width = 48;
            _numberLabel.Height = 8;
            _numberTextBox.Name = "numberTextBox";
            _numberTextBox.TabIndex = 3;
            _numberTextBox.Text = "";
            _numberTextBox.Width = 48;
            _numberTextBox.Height = 8;

            _phoneLabel.Name = "phoneLabel";
            _phoneLabel.TabIndex = 4;
            _phoneLabel.Content = "Phone";
            _phoneLabel.Width = 48;
            _phoneLabel.Height = 8;
            _phoneTextBox.Name = "phoneTextBox";
            _phoneTextBox.TabIndex = 5;
            _phoneTextBox.Text = "";
            _phoneTextBox.Width = 48;
            _phoneTextBox.Height = 8;
        }

        [Category ("Data"), Description ("Contents of Street Control")]
        public string Street
        {
            get
            {
                return _streetTextBox.Text;
            }
            set
            {
                _streetTextBox.Text = value;
            }
        }

        [Category ("Data"), Description ("Content of Number Control")]
        public string Number
        {
            get
            {
                return _numberTextBox.Text;
            }
            set
            {
                _numberTextBox.Text = value;
            }
        }

        [Category("Data"), Description("Content of Phone Control")]
        public string Phone
        {
            get
            {
                return _phoneTextBox.Text;
            }
            set
            {
                _phoneTextBox.Text = value;
            }
        }
    }
}

```

### TODO 12/16

Scrieti un exemplu prin care sa se arata ca pentru o clasa derivata, constructorul clasei de baza se apeleaza inaintea clasei derivate

```cs
DerivedThing derivedThing = new DerivedThing();

class ThingBase
{
    public ThingBase()
    {
        Console.WriteLine("ThingBase :: Called Constructor");
    }
}

class DerivedThing : ThingBase
{
    public DerivedThing()
    {
        Console.WriteLine("DerivedThing :: Called Constructor");
    }
}

/*
ThingBase :: Called Constructor
DerivedThing :: Called Constructor
*/
```

### TODO 13/16

Gasiti justificare pentru care s-ar dori ca o clasa sa fie declarata sealead

Dacă o clasă conține informații sensibile (cum ar fi parole, chei criptografice sau alte date confidențiale), putem să o marcăm ca sealed. Astfel, împiedicăm orice moștenire a clasei și evităm posibilitatea ca cineva să creeze o subclasă care să compromită securitatea.

Uneori, o clasă poate avea multe metode virtuale sau suprascrise. Sigilarea clasei (marcarea ei ca sealed) spune runtime-ului că nu trebuie să caute mai jos în ierarhia de moștenire pentru alte metode. Acest lucru poate îmbunătăți performanța.
Multe instrumente de optimizare de performanță oferă o opțiune pentru a sigila automat toate clasele care nu sunt moștenite. Aceasta poate fi utilă pentru a evita costurile de căutare în timpul rulării.

Dacă proiectăm o clasă utilitară cu un comportament fix (de exemplu, o clasă matematică cu funcții trigonometrice), putem să o marcăm ca sealed. Astfel, ne asigurăm că nu va fi modificată sau extinsă accidental.

### TODO 14/16

Implementati exemplul ce urmeaza. Folositi rularea pas cu pas pentru a verifica succesiunea de metode efectiv executate.

```cs
Console.WriteLine("First block  -  Start");
Above[] x = new Above[4];
Console.WriteLine("First block  -    End\n");

Console.WriteLine("Second block -  Start");
x[0] = new Above();
x[1] = new Below();
x[2] = new Child();
x[3] = new Deriv();
Console.WriteLine("Second block -    End\n");

Console.WriteLine("Third block  -  Start");
Above a = new Above();
Below b = new Below();
Child c = new Child();
Deriv d = new Deriv();
Console.WriteLine("Third block  -    End\n");

Console.WriteLine("For loop     -  Start");
for (int i = 0; i < 4; ++i)
{
    x[i].Fun();
}
Console.WriteLine("For loop     -    End\n");

Console.WriteLine("Last block   -  Start");
a.Fun();
b.Fun();
c.Fun();
d.Fun();
Console.WriteLine("Last block   -    End\n");

class Above
{
    public virtual void Fun()
    {
        Console.WriteLine("Above :: Called Fun()");
    }
}

class Deriv : Above
{
    public override void Fun()
    {
        Console.WriteLine("Deriv :: Called Fun()");
    }
}

class Below : Above
{
    public override void Fun()
    {
        Console.WriteLine("Below :: Called Fun()");
    }
}

class Child : Below
{
    public override void Fun()
    {
        Console.WriteLine("Child :: Called Fun()");
    }
}

/*
First block  -  Start
First block  -    End

Second block -  Start
Second block -    End

Third block  -  Start
Third block  -    End

For loop     -  Start
Above :: Called Fun()
Below :: Called Fun()
Child :: Called Fun()
Deriv :: Called Fun()
For loop     -    End

Last block   -  Start
Above :: Called Fun()
Below :: Called Fun()
Child :: Called Fun()
Deriv :: Called Fun()
Last block   -    End
*/

```

### TODO 15/16

Este posibil ca o clasa abstracta sa aiba constructor cu implementare? Cum explicati? Construiti un exemplu care sa probeze afirmatia dvs.

O clasă abstractă poate avea un constructor cu implementare (adică un constructor care are corpul definit).

Constructorul dintr-o clasă abstractă poate fi folosit pentru a inițializa membrii clasei sau pentru a executa alte operații necesare la crearea obiectelor.

Constructorul dintr-o clasă abstractă nu poate fi apelat direct (deoarece nu putem crea obiecte direct dintr-o clasă abstractă), dar poate fi apelat indirect prin intermediul claselor derivate.

```cs
abstract class Point
{
    protected int _x;
    protected int _y;
    public Point(int x, int y)
    {
        Console.WriteLine("Idea :: Called constructor");
        _x = x;
        _y = y;
    }

    public abstract void MapToCoordinates(int xNew, int yNew);
}

class Vector2 : Point
{
    public Vector2(int x, int y) : base(x, y)
    {

    }

    public override void MapToCoordinates(int xNew, int yNew)
    {
        _x = xNew;
        _y = yNew;
    }
}
```

### TODO 16/16

Cum explicati faptul ca o clasa de tip WPF este declarata ca fiind partiala in Visual Studio? Care sunt beneficiile separarii in doua fisiere: unul de design, altul de cod pentru implementare?

O clasă parțială este o clasă care poate fi definită în mai multe fișiere separate.

Toate aceste fișiere contribuie la aceeași clasă, iar compilatorul le combină într-o singură entitate.

Fiecare fișier parțial conține o parte din implementarea clasei, dar toate trebuie să aibă același nume.

Beneficiile claselor parțiale în WPF:
a. Separarea design-ului de cod: - În WPF, o clasă parțială poate fi utilizată pentru a separa design-ul (interfața vizuală) de codul de implementare. - Fișierul de design (XAML) conține structura vizuală a elementelor UI (butoane, ferestre, controale etc.). - Fișierul de cod (C#) conține logica de interacțiune, gestionarea evenimentelor și alte aspecte de implementare.

b. Mentinerea organizată și ușurința de citire: - Separarea design-ului de cod face ca fiecare fișier să fie mai concis și să se concentreze pe un aspect specific al clasei. - Dezvoltatorii pot lucra independent pe fiecare parte (design sau cod) fără a afecta celălalt aspect. - Acest lucru face codul mai ușor de citit, de întreținut și de gestionat.

c. Extensibilitate și colaborare: - Clasele parțiale facilitează colaborarea între designeri și dezvoltatori. - Designerii pot lucra pe fișierele XAML, adăugând elemente vizuale și stiluri, în timp ce dezvoltatorii pot implementa logica în fișierele C#. - Această separare permite extinderea și modificarea interfeței fără a afecta logica de cod.

d. Generarea automată de cod: - Un exemplu comun este generarea automată de cod de către Visual Studio. - De exemplu, atunci când adăugăm un eveniment (cum ar fi un click pe un buton) în fișierul XAML, Visual Studio generează automat metoda corespunzătoare în fișierul C#.

#### Test de evaluare 1/2

1. Care este gradul implicit al unui membru intr-o clasa?

a) private  
b) protected  
c) internal  
d) protected internal  
e) public  

> Raspuns:  
a) private  

2. Ce este adevarat despre clasele statice?

a) pot fi partiale  
b) pot avea constructor instanta  
c) pot avea constructor static calificat ca public  
d) pot avea destructor  
e) pot contine indexatori statici  
f) pot contine proprietati statice  

> Raspuns:  
a) pot fi partiale  
f) pot contine proprietati statice  

3. Ce este adevarat?

a) o clasa abstracta nu poate implementa o interfata  
b) o clasa abstracta nu poate avea destructor  
c) o clasa abstracta poate avea metode cu implementare  
d) o clasa abstracta e automat si sealead  
e) orice clasa este tip referinta  

> Raspuns:  
c) o clasa abstracta poate avea metode cu implementare  
e) orice clasa este tip referinta  

4. Despre proprietati in cadrul claselor:

a) pot fi declarate statice  
b) pot fi declarate ca abstracte in clase abstracte  
c) pot avea get public si set privat  

> Raspuns:  
a) pot fi declarate statice  
b) pot fi declarate ca abstracte in clase abstracte  
c) pot avea get public si set privat  

```cs
public abstract class Shape
{
    public abstract double Aria { get; }
}
```

#### Test de evaluare 2/2

1. Ce se pot declara in interfete?

a) campuri  
b) evenimente  
c) constructori de instanta  
d) constructor static  
e) destructor  
f) metode  

> Raspuns:  
b) evenimente  
f) metode  

2. Care este gradul de acces implicit al metodelor din cadrul interfetelor?

a) public  
b) private  
c) protected  
d) internal  
e) protected internal  

> Raspuns:  
a) public  

3. Relativ la structuri:

a) din ele se pot deriva alte tipuri de date  
b) sunt derivate direct din System.ValueType  
c) permit definirea unui constructor static  
d) permit definirea unui destructor  
e) nu pot contine indexatori  

> Raspuns:  
b) sunt derivate direct din System.ValueType  
c) permit definirea unui constructor static  


4. Ce este adevarat despre clase abstracte:

a) exista cel putin un caz in care pot contine metoda calificata override  
b) pot declara evenimente  
c) pot fi derivate din mai multe clase, simultan  
d) pot declara ca implementeaza mai multe interfete  

> Raspuns:  
a) exista cel putin un caz in care pot contine metoda calificata override  
b) pot declara evenimente  
d) pot declara ca implementeaza mai multe interfete  

## Modulul 3

### TODO 1/3

Sugeram cititorului interesat urmarirea pas cu pas a executiei aplicatiei pentru a vedea metodele care se aplica.

```cs
MyDelegate deleg;

deleg = Sum;

Console.WriteLine($"Sum={Callback(3, 4, deleg)}");

deleg = Sub;

Console.WriteLine($"Sub={Callback(3, 4, deleg)}");

Console.WriteLine($"Mul={Callback(3, 4, Mul)}");

Console.WriteLine($"Div={OtherCallback(3, 4, Div)}");


int Sum(int a, int b)
{
    return a + b;
}

int Sub(int a, int b)
{
    return a - b;
}

int Mul(int a, int b)
{
    return a * b;
}

float Div(int a, int b)
{
    return a / (float) b;
}

int Callback(int a, int b, MyDelegate deleg)
{
    return deleg(a, b);
}

float OtherCallback(int a, int b, OtherDelegate otherDeleg)
{
    return otherDeleg(a, b);
}

delegate int MyDelegate(int a, int b);

delegate float OtherDelegate(int a, int b);

```

### TODO 2/3

Implementati exemplul de mai sus si verificati-i comportamentul in timpul rularii pas cu pas.

```cs
Something something = new Something();

something.InvokeMethod();

SomethingElse somethingElse = new SomethingElse();

somethingElse.InvokeMethod();

class Something
{
    delegate void SomeDelegate();

    public void InvokeMethod()
    {
        SomeDelegate deleg = new SomeDelegate(SomeMethod);
        deleg();
    }

    private void SomeMethod()
    {
        Console.WriteLine("Something :: SomeMethod()");
    }
}

class SomethingElse
{
    delegate void SomeOtherDelegate();

    public void InvokeMethod()
    {
        SomeOtherDelegate deleg = delegate ()
        {
            Console.WriteLine("SomethingElse :: InvokeMethod()");
        };
        deleg();
    }
}
```

#### Test de evaluare 1/x

1. Tipurile delegat:

a) sunt tipuri valoare  
b) sunt tipuri referinta  
c) sunt tipuri structura  
d) se pot declara doar in interiorul claselor  
e) se pot declara in interiorul interfetelor  

> Raspuns:  
b) sunt tipuri referinta  
e) se pot declara in interiorul interfetelor  

2. Ce inseamna multicast?

a) un anumit tip de delegat  
b) o inlantuire de conversii de tip    
c) un tip delegat fara parametri de apel  
d) un tip de metoda  

> Raspuns:  
a) un anumit tip de delegat  


### TODO 3/3

Implementati exemplul de mai sus. Modificati exemplul astfel incat sa se opreasca executia automat dupa 1 minut.

```cs

Clock clock = new Clock();

DisplayClock dc = new DisplayClock();
dc.Subscribe(clock);

LogCurrentTime lct = new LogCurrentTime();
lct.Subscribe(clock);

clock.Run();


public class TimeInfoEventArgs : EventArgs
{
    public readonly int Hour;
    public readonly int Minute;
    public readonly int Second;

    public TimeInfoEventArgs(int hour, int minute, int second)
    {
        Hour = hour;
        Minute = minute;
        Second = second;
    }
}

public class DisplayClock
{
    public void Subscribe(Clock clock)
    {
        clock.OnSecondChange += new Clock.SecondChangeHandler(TimeHasChanged);
    }

    private void TimeHasChanged(object sender, TimeInfoEventArgs e)
    {
        Console.WriteLine($"Current Time: {e.Hour}:{e.Minute}:{e.Second}");
    }
}

public class LogCurrentTime
{
    public void Subscribe(Clock clock)
    {
        clock.OnSecondChange += new Clock.SecondChangeHandler(WriteLogEntry);
    }

    private void WriteLogEntry(object sender, TimeInfoEventArgs e)
    {
        Console.WriteLine($"Logging Time: {e.Hour}:{e.Minute}:{e.Second}");
    }
}

public class Clock
{
    public delegate void SecondChangeHandler(object sender, TimeInfoEventArgs e);

    public event SecondChangeHandler OnSecondChange;

    private int _hour;
    private int _minute;
    private int _second;

    public void Run()
    {
        DateTime prevTime = DateTime.Now;
        _hour = prevTime.Hour;
        _minute = prevTime.Minute;
        _second = prevTime.Second;

        while (true)
        {
            DateTime currTime = DateTime.Now;

            if (currTime.Second != _second)
            {
                TimeInfoEventArgs timeInfo = new TimeInfoEventArgs(currTime.Hour, currTime.Minute, currTime.Second);

                if (OnSecondChange != null)
                {
                    OnSecondChange(this, timeInfo);
                }

                TimeSpan elapsed = currTime - prevTime;

                if (elapsed.TotalSeconds >= 60)
                {
                    Console.WriteLine($"One minute has passed. Terminating . . .");
                    break;
                }
            }

            _hour = currTime.Hour;
            _minute = currTime.Minute;
            _second = currTime.Second;
        }
    }
}

/*
Current Time: 11:30:32
Current Time: 11:30:33
Current Time: 11:30:34
Current Time: 11:30:35
Current Time: 11:30:36
Current Time: 11:30:37
Current Time: 11:30:38
Current Time: 11:30:39
Current Time: 11:30:40
Current Time: 11:30:41
Current Time: 11:30:42
Current Time: 11:30:43
Current Time: 11:30:44
Current Time: 11:30:45
Current Time: 11:30:46
Current Time: 11:30:47
Current Time: 11:30:48
Current Time: 11:30:49
Current Time: 11:30:50
Current Time: 11:30:51
Current Time: 11:30:52
Current Time: 11:30:53
Current Time: 11:30:54
Current Time: 11:30:55
Current Time: 11:30:56
Current Time: 11:30:57
Current Time: 11:30:58
Current Time: 11:30:59
Current Time: 11:31:0
Current Time: 11:31:1
Current Time: 11:31:2
Current Time: 11:31:3
Current Time: 11:31:4
Current Time: 11:31:5
Current Time: 11:31:6
Current Time: 11:31:7
Current Time: 11:31:8
Current Time: 11:31:9
Current Time: 11:31:10
Current Time: 11:31:11
Current Time: 11:31:12
Current Time: 11:31:13
Current Time: 11:31:14
Current Time: 11:31:15
Current Time: 11:31:16
Current Time: 11:31:17
Current Time: 11:31:18
Current Time: 11:31:19
Current Time: 11:31:20
Current Time: 11:31:21
Current Time: 11:31:22
Current Time: 11:31:23
Current Time: 11:31:24
Current Time: 11:31:25
Current Time: 11:31:26
Current Time: 11:31:27
Current Time: 11:31:28
Current Time: 11:31:29
Current Time: 11:31:30
Current Time: 11:31:31
Current Time: 11:31:32
One minute has passed. Terminating . . .
*/

```

#### Test de evaluare 1/1

1. Un eveniment poate fi tratat printr-o metoda:

a) de orice tip  
b) intotdeauna publica  
c) compatibilita cu orice tip delegat  

> Raspuns:  
Niciunul din raspunsurile furnizate; raspunsul corect este 'delegat multicast'  

2. Subscrierea la un eveniment se face folosind:

a) metoda Subscribe()  
b) metoda subscribe()  
c) un constructor  

> Raspuns:  
Niciunul din raspunsuri; subscrierea se face cu operatorul +=  

3. Despre evenimente:

a) pot fi declarate in interiorul interfetelor  
b) pot fi declarate in interiorul claselor  
c) pot fi declarate direct intr-un spatiu de nume  
d) pot fi declarate in interiorul tipurilor enumerare  
e) pot fi declarate in interiorul tipurilor structura  

> Raspuns:  
a) pot fi declarate in interiorul interfetelor  
b) pot fi declarate in interiorul claselor  
c) pot fi declarate direct intr-un spatiu de nume  
e) pot fi declarate in interiorul tipurilor structura  

## Modulul 4

### TODO 1/x

Este posibil ca pentru o metoda ce returneaza un tip oarecare (nu void), in bloc finally sa se includa instructinea return? Cum explicati?

Blocul finally este executat întotdeauna, indiferent dacă o excepție a fost aruncată sau nu.

Dacă o excepție este aruncată în blocul try, codul din blocul finally se execută înainte de a se propaga excepția mai departe.

Dacă nu există excepții, blocul finally se execută după ce blocul try a terminat execuția.

Dacă includem o instrucțiune return în blocul finally, aceasta va suprascrie orice valoare de returnare stabilită în blocul try.

În esență, valoarea de returnare din blocul finally va fi întotdeauna cea care va fi returnată, indiferent de ce s-a întâmplat în blocul try.

Dacă am permite o instrucțiune return în blocul finally, ar putea duce la comportamente confuze și greu de anticipat.

Ar fi dificil să ne așteptăm la o valoare de returnare specifică când blocul finally poate modifica această valoare.

### TODO 2/x

Implementati si executati pas cu pas exemplul de mai jos

```cs


public class MyCustomException : ApplicationException
{
    public MyCustomException(string message) : base(message)
    {

    }

    public MyCustomException(string message, Exception innterException) : base(message, innterException)
    {

    }
}

public class Test
{
    public static void Main()
    {
        Test t = new Test();
        t.TestFunc();
        t.TestDangerousFunc();
    }

    public void TestFunc()
    {
        try
        {
            double a = 0;
            double b = 5;
            Console.WriteLine($"{a}/{b} = {Divide(a, b)}");
        }
        catch (MyCustomException e)
        {
            Console.WriteLine(e.Message);
        }
        catch
        {
            Console.WriteLine("Test :: TestFunc() :: Caught unknown exception.");
        }
    }

    public void TestDangerousFunc()
    {
        try
        {
            DangerousFunc1();
        }
        catch (MyCustomException e)
        {
            Console.WriteLine(e.Message);
            Console.WriteLine("Test :: TestDangerousFunc() :: Retrieving exception history. . .");
            Exception? inner = e.InnerException;

            while (inner != null)
            {
                Console.WriteLine(inner.Message);
                inner = inner.InnerException ?? null;
            }
        }
    }

    public double Divide( double numerator, double denominator )
    {
        if (denominator == 0)
        {
            DivideByZeroException e = new DivideByZeroException();
            e.HelpLink = "https://learn.microsoft.com/en-us/dotnet/api/system.dividebyzeroexception?view=net-8.0";
            throw e;
        }

        if (numerator == 0)
        {
            MyCustomException e = new MyCustomException("This method does not accept 0 as numerator.");
            e.HelpLink = "";
            throw e;
        }

        return numerator / denominator;
    }

    public void DangerousFunc1()
    {
        try
        {
            DangerousFunc2();
        }
        catch (Exception e)
        {
            MyCustomException ex = new MyCustomException("Test :: DangerousFunc1() :: E3 - Caught Custom Exception", e);
            throw ex;
        }
    }

    public void DangerousFunc2()
    {
        try
        {
            DangerousFunc3();
        }
        catch(DivideByZeroException e)
        {
            Exception ex = new Exception("Test :: DangerousFunc2() :: E2 - Caught Divide by Zero Exception", e);
            throw ex;
        }
    }

    public void DangerousFunc3()
    {
        try
        {
            DangerousFunc4();
        }
        catch (ArithmeticException e)
        {
            throw;
        }
        catch (Exception e)
        {
            Console.WriteLine("Test :: DangerousFunc3() :: Exception handled here.");
        }
    }

    public void DangerousFunc4()
    {
        throw new DivideByZeroException("Test :: DangerousFunc4() :: E1 - DivideByZero Exception.");
    }
}
```

### TODO 3/x

Urmariti discutia dintre Anders Heilsberg si Bruce Eckel pe tema check/unchecked exceptions de la adresa: 404 Page not found

#### Test de evaluare

1. Despre tipurile exceptie:

a) sunt tipuri valoare  
b) sunt tipuri referinta  
c) se deriveaza intotdeauna direct din tipul Exception  
d) se declara ca fiind aruncate de catre metodele in care pot aparea  

> Raspuns:  
b) sunt tipuri referinta  

2. Relativ la obiectele exceptie:  

a) continutul lor se stocheaza pe stiva  
b) pot contine alte obiecte de tip exceptie  
c) permit determinarea sirului de apeluri de metode care a dus la aparitia lor  
d) pot fi rearuncate  
e) se prind si se trateaza intr-un bloc finally  

> Raspuns:  
b) pot contine alte obiecte de tip exceptie 
c) permit determinarea sirului de apeluri de metode care a dus la aparitia lor  
d) pot fi rearuncate  

3. Ce este corect legat de exceptii?

a) pot fi aruncate din constructori  
b) nu pot fi aruncate din destructori  
c) daca nu sunt aruncate, intotdeauna opresc executia intregii aplicatii  
d) cele definite de programator pot contine proprietati calificate cu override  

> Raspuns:  
a) pot fi aruncate din constructori  
d) cele definite de programator pot contine proprietati calificate de override  

### TODO 4/x

Verificati ca intr-un obiect de tip ArrayList se pot depune consecutiv obiecte de tip int, String, tablou.

```cs
using System.Collections;

ArrayList arrayList = new ArrayList();

arrayList.Add(1);
arrayList.Add(2);
arrayList.Add("One");
arrayList.Add("Two");
arrayList.Add(new int[] { 1, 2 });
arrayList.Add(new string[] { "One", "Two" });

foreach (var v in arrayList)
{
    Console.WriteLine(v.ToString());
}

ArrayList arrayList2 = [
    3, 4,
    "Three", "Four",
    new int[] { 1, 2 },
    new string[]{ "One", "Two" },
    ];

```

### TODO 5/x

Implementati si rulati exemplele de mai sus.

```cs
using System.Collections;

Hashtable hashtable = new Hashtable();
hashtable.Add("A", "Chapter I");
hashtable.Add("B", "Chapter II");
hashtable.Add("App", "Appendix");

IDictionaryEnumerator en = hashtable.GetEnumerator();

for (; en.MoveNext(); )
{
    Console.WriteLine($"key={en.Key}, value={en.Value}");
}

foreach (DictionaryEntry entry in hashtable)
{
    Console.WriteLine($"key={entry.Key}, value={entry.Value}");
}

```
