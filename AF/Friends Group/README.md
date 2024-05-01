# Grup de prieteni

Intr-un grup de prieteni avem fete si baieti. 

Despre fiecare persoana cunoastem urmatoarele:
1. nume
2. inaltime (cm)
3. greutate (kg)
4. varsta
5. este fata/baiat

## Cerinte

1. Sa se scrie o functie care numara cati baieti sunt in grup. 

```cpp
int MalesCount(const std::vector<Friend> friends) {
	int maleCount = 0;

	for (const Friend& fr : friends) {
		if (fr.isMale) {
			++maleCount;
		}
	}

	return maleCount;
}

```

2. Sa se scrie o functie care returneaza inaltimea medie a baietilor.

```cpp
float AverageMaleHeight(const std::vector<Friend> friends) {
	int malesCount = 0;
	float averageHeight = 0.0;

	for (const Friend& fr : friends) {
		if (fr.isMale) {
			averageHeight += fr.height;
			++malesCount;
		}
	}

	return averageHeight / malesCount;
}
```

3. Stiind ca greutatile persoanelor sunt pana in 80 kg, sa se afiseze ce greutati au persoanele din grup si numarul de persoane cu o anumita greutate.

```cpp
void PrintWeightGroups(const std::vector<Friend> friends, const int MAX_WEIGHT = 80) {

	std::unordered_map<int, int> weightGroupCount;

	for (const Friend& fr : friends) {
		if (fr.weight > MAX_WEIGHT) {
			continue;
		}
		weightGroupCount[fr.weight]++; 
	}

	for (const std::pair<const int, int>& group : weightGroupCount) {
		std::cout << "Group with " << group.first << " kg has " << group.second << " many people" << std::endl;
	}
}
```

4. Sa se ordoneze persoanele din grup dupa inaltime descrescator si crescator dupa greutate. Sa se afiseze persoanele dupa fiecare sortare

```cpp
void SortByHeight(std::vector<Friend>& friends) {
	std::cout << "---SORT BY HEIGHT---" << std::endl;
	std::sort(friends.begin(), friends.end(), [](const Friend& a, const Friend& b) { return a.height > b.height; });

	for (const Friend& fr : friends) {
		PrintFriendData(fr);
	}
	std::cout << "---SORT BY HEIGHT---" << std::endl;
}

void SortByWeight(std::vector<Friend>& friends) {
	std::cout << "---SORT BY WEIGHT---" << std::endl;
	std::sort(friends.begin(), friends.end(), [](const Friend& a, const Friend& b) { return a.weight < b.weight; });

	for (const Friend& fr : friends) {
		PrintFriendData(fr);
	}
	std::cout << "---SORT BY WEIGHT---" << std::endl;
}
```

5. Sa se scrie o metoda care determina numarul maxim de persoane care pot intra intr-un lift care poate duce maxim 500 kg

```cpp
int MaxCountOfFriendsFittingInElevator(std::vector<Friend>& friends, const int elevatorMaxCapacity = 500) {
	int	fittingFriendsCount = 0;
	
	SortByWeight(friends);

	int currentElevatorCapacity = elevatorMaxCapacity;

	for (const Friend& fr : friends) {
		if (fr.weight > currentElevatorCapacity) {
			std::cout << fr.name << " has " << fr.weight << " kg and does NOT fit in the elevator. Breaking." << std::endl;
			break;
		}

		++fittingFriendsCount;
		currentElevatorCapacity -= fr.weight;
		std::cout << fr.name << " fits in the lift. Can still fit " << currentElevatorCapacity << " kg." << std::endl;
	}

	return fittingFriendsCount;
}
```

Friends file:

```txt
Marcel1
123
145
67
1

Maria1
123
130
24
0

Marcel2
167
89
10
1

Maria2
154
87
33
0

Marcel3
123
145
67
1

Maria3
123
30
24
0

Marcel4
167
89
10
1

Maria3
154
87
33
0

Marcel5
123
45
67
1

Maria5
123
30
24
0

Marcel6
167
89
10
1

Maria6
153
87
33
0

Marcel7
123
45
67
1

Maria7
123
30
24
0

Marcel8
167
89
10
1

Maria8
154
87
33
0
```
