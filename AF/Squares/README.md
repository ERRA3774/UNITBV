

```cpp
#include <iostream>
#include <vector>

struct Paper
{
    int height;
    int width;
};

void ReadSizes(Paper& paper)
{
    std::cout << "Introduceti dimensiunile hartiei.\nlungime = ";
    std::cin >> paper.height;
    std::cout << "latime = ";
    std::cin >> paper.width;
}

int SquaresCountFrom(Paper& paper)
{
    int count = 1;

    while (paper.height != 1 || paper.width != 1)
    {
        if (paper.width > paper.height)
        {
            std::swap(paper.height, paper.width);
        }

        while (paper.height > paper.width)
        {
            paper.height -= paper.width;
            count++;
        }
    }

    return count;
}

int PrintSolution()
{
    Paper paper;
    ReadSizes(paper);
    std::cout << SquaresCountFrom(paper);
}
```