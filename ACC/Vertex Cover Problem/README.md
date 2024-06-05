# Vertex Cover Problem



Main

```cpp

#include <cstdlib>

#include "Utils.hpp"
#include "Window.hpp"

int main() {
	Window window(consts::SCREEN_WIDTH, consts::SCREEN_HEIGHT);

	window.Start();

	return EXIT_SUCCESS;
}

```

Window

```cpp

#pragma once

#include <raylib.h>
#include <string>
#include <memory>

#include "Utils.hpp"

#include "Node.hpp"
#include "Graph.hpp"
#include <vector>

class Window {

    enum ECover {
        EGA,
        EDPSO,
    };

public:
    Window(int width, int height);

    void Start();

private:
    int m_windowWidth;
    int m_windowHeight;
    const char* m_windowTitle;

    std::vector<Node*> m_clickedNodes;

    ECover m_cover;
    const char* m_coverName;
};

Window::Window(int width, int height) {
    m_windowWidth = width;
    m_windowHeight = height;
    m_windowTitle = texts::WINDOW_TITLE;
    m_clickedNodes = std::vector<Node*>();
    m_cover = EGA;
    m_coverName = texts::COVER_GA;
}

void Window::Start() {
    // Initialization
    //--------------------------------------------------------------------------------------
    Graph graph;
    SetRandomSeed(settings::SEED_DEFAULT);
    SetConfigFlags(FLAG_MSAA_4X_HINT);
    SetTargetFPS(settings::FPS);
    InitWindow(m_windowWidth, m_windowHeight, m_windowTitle);
    //--------------------------------------------------------------------------------------

    // Main event loop
    while (!WindowShouldClose()) {     // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------

        if (IsMouseButtonPressed(MOUSE_BUTTON_LEFT)) {
            graph.Update(GetMousePosition(), m_clickedNodes);
        }

        if (IsKeyDown(KEY_LEFT_CONTROL) && IsKeyPressed(KEY_A)) {
            graph.ConnectRandom();
        }

        if (IsKeyPressed(KEY_TAB)) {

            switch (graph.GetNextVertexCover(static_cast<int>(m_cover))) {

            case EGA:
                m_cover = EGA;
                m_coverName = texts::COVER_GA;
                break;

            case EDPSO:
                m_cover = EDPSO;
                m_coverName = texts::COVER_DPSO;
                break;

            default:
                break;
            }
        }

        if (IsKeyDown(KEY_LEFT_CONTROL) && IsKeyPressed(KEY_D)) {
            graph.DebugPrint();
        }

        if (IsKeyDown(KEY_LEFT_CONTROL) && IsKeyPressed(KEY_F)) {
            graph.Clear();
        }

        if (IsKeyDown(KEY_LEFT_CONTROL) && IsKeyPressed(KEY_C)) {
            graph.CoverVertices();
        }

        if (IsKeyDown(KEY_LEFT_CONTROL) && IsKeyPressed(KEY_ONE)) {
            graph.MakePresetCube();
        }

        if (IsKeyDown(KEY_LEFT_CONTROL) && IsKeyPressed(KEY_TWO)) {
            graph.MakePresetTetrahedron();
        }

        if (IsKeyDown(KEY_LEFT_CONTROL) && IsKeyPressed(KEY_THREE)) {
            graph.MakePresetDiamond();
        }

        if (IsKeyDown(KEY_LEFT_CONTROL) && IsKeyPressed(KEY_FOUR)) {
            graph.MakePresetVertex();
        }

        if (IsKeyDown(KEY_LEFT_SHIFT) && IsKeyDown(KEY_E) && IsKeyPressed(KEY_EQUAL)) {
            graph.IncreaseEpochs();
        }

        if (IsKeyDown(KEY_LEFT_SHIFT) && IsKeyDown(KEY_E) && IsKeyPressed(KEY_MINUS)) {
            graph.DecreaseEpochs();
        }

        if (IsKeyDown(KEY_LEFT_SHIFT) && IsKeyDown(KEY_W) && IsKeyPressed(KEY_EQUAL)) {
            graph.IncreasePopulations();
        }

        if (IsKeyDown(KEY_LEFT_SHIFT) && IsKeyDown(KEY_W) && IsKeyPressed(KEY_MINUS)) {
            graph.DecreasePopulations();
        }

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

        ClearBackground(colors::BACKGROUND_DEFAULT);

        graph.Draw();

        DrawFPS(poss::DEBUG_TEXT_X, poss::FPS_TEXT_Y);

        DrawText((std::string(texts::COVER_TEXT) + m_coverName).data(), poss::DEBUG_TEXT_X, poss::FRICTION_TEXT_Y, texts::MODE_FONT_SIZE, colors::MODE_TEXT);
        DrawText(std::string(texts::EPOCHS_TEXT + std::to_string(graph.GetEpochs())).data(), poss::DEBUG_TEXT_X, poss::EPOCHS_TEXT_Y, texts::MODE_FONT_SIZE, colors::MODE_TEXT);
        DrawText(std::string(texts::POPULATION_TEXT + std::to_string(graph.GetPopulation())).data(), poss::DEBUG_TEXT_X, poss::POPULATION_TEXT_Y, texts::MODE_FONT_SIZE, colors::MODE_TEXT);
        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------

    CloseWindow();			// Close window and OpenGL context
}

```


Node

```cpp

#pragma once

#include "Utils.hpp"
#include <type_traits>

class Node {
public:
    Node();
    Node(const Vector2& mouse, const int& id);

    Node(const Node& other);
    Node(Node&& other) noexcept;

    Node& operator=(const Node& other);
    Node& operator=(Node&& other) noexcept;

    ~Node() = default;

    void Update(const Color& color);

    void Draw() const;

    Vector2 GetPosition() const;

    int GetId() const;

    int GetRadius() const;

    const char* GetText() const;

    void SetText(const char* text);

    friend bool operator==(const Node& lhs, const Node& rhs);
    friend bool operator!=(const Node& lhs, const Node& rhs);
    friend std::ostream& operator<<(std::ostream& lhs, const Node& rhs);
    friend bool operator<(const Node& lsh, const Node& rhs);

private:
    int         m_id;
    int         m_radius;
    int         m_fontSize;
    const char* m_text;

    Vector2     m_pos;

    Color       m_fillColor;
    Color       m_textColor;
};

Node::Node() {
    m_id = consts::INIT_ID;
    m_radius = consts::NODE_RADIUS;
    m_fontSize = texts::NODE_FONT_SIZE;
    m_text = texts::NODE_DEFAULT;
    m_pos = poss::OFFSCREEN;
    m_fillColor = colors::NODE_FILL;
    m_textColor = colors::TEXT_DEFAULT;
}

Node::Node(const Vector2& mouse, const int& id) {
    m_id = id;
    m_radius = consts::NODE_RADIUS;
    m_fontSize = texts::NODE_FONT_SIZE;
    m_text = texts::NODE_DEFAULT;
    m_pos = mouse;
    m_fillColor = colors::NODE_FILL;
    m_textColor = colors::TEXT_DEFAULT;
}

Node::Node(const Node& other){
    *this = other;
}

Node::Node(Node&& other) noexcept {
    *this = std::move(other);
}

Node& Node::operator=(const Node& other) {
    if (this != &other) {
        m_id = other.m_id;
        m_radius = other.m_radius;
        m_fontSize = other.m_fontSize;
        m_text = other.m_text;
        m_pos = other.m_pos;
        m_fillColor = other.m_fillColor;
        m_textColor = other.m_textColor;
    }

    return *this;
}

Node& Node::operator=(Node&& other) noexcept {
    if (this != &other) {
        m_id = std::exchange(other.m_id, consts::INIT_ID);
        m_radius = std::exchange(other.m_radius, consts::NODE_RADIUS);
        m_fontSize = std::exchange(other.m_fontSize, texts::NODE_FONT_SIZE);
        m_text = std::exchange(other.m_text, texts::NODE_DEFAULT);
        m_pos = std::exchange(other.m_pos, poss::OFFSCREEN);
        m_fillColor = std::exchange(other.m_fillColor, colors::NODE_FILL);
        m_textColor = std::exchange(other.m_textColor, colors::TEXT_DEFAULT);
    }

    return *this;
}

Vector2 Node::GetPosition() const {
    return m_pos;
}

int Node::GetId() const {
    return m_id;
}

int Node::GetRadius() const {
    return m_radius;
}

const char* Node::GetText() const {
    return m_text;
}

void Node::SetText(const char* text) {
    m_text = text;
}

void Node::Update(const Color& color) {
    m_fillColor = color;
}

void Node::Draw() const {
    int textSize = MeasureText(m_text, m_fontSize);
    int offsetHorizonal = textSize / 2;
    int offsetVertical = m_radius / 4;

    DrawCircleV(m_pos, m_radius, m_fillColor);

    if (m_text == texts::NODE_DEFAULT) {
        DrawText(std::to_string(m_id).data(), m_pos.x, m_pos.y - offsetVertical, m_fontSize, m_textColor);
    }
    else {
        DrawText(m_text, m_pos.x - offsetHorizonal, m_pos.y - offsetVertical, m_fontSize, m_textColor);
    }
}

bool operator==(const Node& lhs, const Node& rhs) {
    return lhs.m_pos.x == rhs.m_pos.x && lhs.m_pos.y == rhs.m_pos.y;
}

bool operator!=(const Node& lhs, const Node& rhs) {
    return lhs.m_pos.x != rhs.m_pos.x && lhs.m_pos.y != rhs.m_pos.y;
}

std::ostream& operator<<(std::ostream& lhs, const Node& rhs) {
    lhs << "{id:" << rhs.m_id << ",x:" << rhs.m_pos.x << ",y:" << rhs.m_pos.y << "}";
    return lhs;
}

bool operator<(const Node& lhs, const Node& rhs) {
    return lhs.m_id < rhs.m_id;
}

```

Edge

```cpp

#pragma once

#include "Utils.hpp"
#include "Node.hpp"

class Edge {
public:
    Edge(const Node& start, const Node& end, const int& id);

    Edge(const Edge& other);
    Edge(Edge&& other) noexcept;

    Edge& operator=(const Edge& other);
    Edge& operator=(Edge&& other) noexcept;

    ~Edge() = default;

    void        Update(const Color& color);

    void        Draw() const;

    bool        Connects(const Node& node) const;

    const Node& GetStart() const;
    const Node& GetEnd() const;

    friend bool operator==(const Edge& lhs, const Edge& rhs);
    friend bool operator!=(const Edge& lhs, const Edge& rhs);
    friend bool operator<(const Edge& lhs, const Edge& rhs);
    friend std::ostream& operator<< (std::ostream& lhs, const Edge& rhs);

private:
    int         m_id;
    Node        m_start;
    Node        m_end;
    float       m_weight;

    Rectangle   m_rect;
    Vector2     m_startPos;
    Vector2     m_endPos;
    Color       m_fillColor;
};

Edge::Edge(const Node& start, const Node& end, const int& id) {
    m_id        = id;
    m_start     = start;
    m_end       = end;
    m_weight    = consts::WEIGHT_DEFAULT;
    m_startPos  = start.GetPosition();
    m_endPos    = end.GetPosition();
    m_rect      = {
        m_startPos.x,
        m_startPos.y,
        maths::GetDistance2V(m_endPos, m_startPos),
        consts::EDGE_THICKNESS
    };
    m_fillColor = colors::EDGE_FILL;
}

Edge::Edge(const Edge& other) {
    *this = other;
}

Edge::Edge(Edge&& other) noexcept {
    *this = std::move(other);
}

Edge& Edge::operator=(const Edge& other) {
    if (this != &other) {
        m_id = other.m_id;
        m_start = other.m_start;
        m_end = other.m_end;
        m_weight = other.m_weight;
        m_startPos = other.m_startPos;
        m_endPos = other.m_endPos;
        m_rect = other.m_rect;
        m_fillColor = other.m_fillColor;
    }

    return *this;
}

Edge& Edge::operator=(Edge&& other) noexcept {
    if (this != &other) {
        m_id = std::exchange(other.m_id, consts::INIT_ID);
        m_start = std::exchange(other.m_start, Node());
        m_end = std::exchange(other.m_end, Node());
        m_weight = std::exchange(other.m_weight, consts::WEIGHT_DEFAULT);
        m_startPos = std::exchange(other.m_startPos, poss::OFFSCREEN);
        m_endPos = std::exchange(other.m_endPos, poss::OFFSCREEN);
        m_rect = std::exchange(other.m_rect, Rectangle());
        m_fillColor = std::exchange(other.m_fillColor, colors::EDGE_FILL);
    }

    return *this;
}

void Edge::Update(const Color& color) {
    m_fillColor = color;
}

void Edge::Draw() const {
    DrawRectanglePro(m_rect, consts::ORIGIN_ZERO, maths::GetAngle2V(m_startPos, m_endPos), m_fillColor);

    DrawTextPro(GetFontDefault(), 
        std::to_string(maths::GetDistance2V(m_startPos, m_endPos)).substr(0, 0).data(), // Update the weight here
        maths::GetCenter2V(m_startPos, m_endPos),
        consts::ORIGIN_ZERO, 
        consts::DEG_0, 
        texts::EDGE_FONT_SIZE, 
        consts::WEIGHT_DEFAULT, 
        colors::WEIGHT_TEXT);
}

bool Edge::Connects(const Node& node) const {
    return m_start == node || m_end == node;
}

const Node& Edge::GetStart() const {
    return m_start;
}

const Node& Edge::GetEnd() const {
    return m_end;
}

bool operator==(const Edge& lhs, const Edge& rhs) {
    return lhs.m_start == rhs.m_start && lhs.m_end == rhs.m_end;
}

bool operator!=(const Edge& lhs, const Edge& rhs) {
    return lhs.m_start != rhs.m_start && lhs.m_end != rhs.m_end;
}

bool operator<(const Edge& lhs, const Edge& rhs) {
    return maths::GetDistance2V(lhs.m_startPos, lhs.m_endPos) < maths::GetDistance2V(rhs.m_startPos, rhs.m_endPos);
}

std::ostream& operator<<(std::ostream& lhs, const Edge& rhs) {
    return lhs << rhs.m_start << "--->" << rhs.m_end;
}

```

Chromosome

```cpp

#pragma once

#include "Utils.hpp"

class Chromosome {
public:
    Chromosome() = default;
    Chromosome(const std::vector<bool>& genes);

    Chromosome(const Chromosome& other);
    Chromosome(Chromosome&& other) noexcept;

    Chromosome& operator=(const Chromosome& other);
    Chromosome& operator=(Chromosome&& other) noexcept;

    ~Chromosome() = default;

	std::vector<bool> GetGenes() const;

    int GetFitnessValue(std::function<int(const std::vector<bool>&)> fitnessFunction) const;

    void Mutate(const size_t& pos);

    void Crossover(const size_t& pos, Chromosome& other);

    friend std::ostream& operator<<(std::ostream& lhs, const Chromosome& rhs);

private:
    std::vector<bool> m_genes;
};

Chromosome::Chromosome(const std::vector<bool>& genes) {
	m_genes = genes;
}

Chromosome::Chromosome(const Chromosome& other) {
	*this = other;
}

Chromosome::Chromosome(Chromosome&& other) noexcept {
	*this = std::move(other);
}

Chromosome& Chromosome::operator=(const Chromosome& other) {
	if (this != &other) {
		m_genes = other.m_genes;
	}

	return *this;
}

Chromosome& Chromosome::operator=(Chromosome&& other) noexcept {
	if (this != &other) {
		m_genes = std::exchange(other.m_genes, std::vector<bool>());
	}

	return *this;
}

std::vector<bool> Chromosome::GetGenes() const {
	return m_genes;
}

int Chromosome::GetFitnessValue(std::function<int(const std::vector<bool>&)> fitnessFunction) const {
	return fitnessFunction(m_genes);
}

void Chromosome::Mutate(const size_t& pos) {
	m_genes.at(pos) = !m_genes.at(pos);
}

void Chromosome::Crossover(const size_t& pos, Chromosome& other) {
	for (size_t geneIdx = pos; geneIdx < m_genes.size(); ++geneIdx) {
		swap(m_genes.at(geneIdx), other.m_genes.at(geneIdx));
	}
}

std::ostream& operator<<(std::ostream& lhs, const Chromosome& rhs) {
	for (const bool& gene : rhs.m_genes) {
		lhs << gene << ' ';
	}

	return lhs;
}


```

Chromosome Population

```cpp

#pragma once

#include "Chromosome.hpp"
#include <algorithm>

class ChromosomePopulation {
public:
    ChromosomePopulation(const size_t& populationSize, const size_t& chromosomeSize, double mutationProbability, double crossoverProbability);

    ChromosomePopulation(const ChromosomePopulation& other);
    ChromosomePopulation(ChromosomePopulation&& other) noexcept;

    ChromosomePopulation& operator=(const ChromosomePopulation& other);
    ChromosomePopulation& operator=(ChromosomePopulation&& other) noexcept;

    ~ChromosomePopulation() = default;

    std::function<int(const Chromosome&)> GetFitnessFunction() const;
    void SetFitnessFunction(const std::function<int(const Chromosome&)>& fitnessFunction);

    void Selection();
    void Mutation();
    void Crossover();

    Chromosome GetMin() const;

    std::pair<Chromosome, size_t> Run(size_t epochs, std::ostream& output);

    friend std::ostream& operator<<(std::ostream&, const ChromosomePopulation& population);

private:
    std::vector<Chromosome> m_population;

    size_t m_chromosomeSize;
    double m_mutationProbability;
    double m_crossoverProbability;

    std::function<int(const Chromosome&)> m_fitnessFunction;
};

ChromosomePopulation::ChromosomePopulation(const size_t& populationSize, const size_t& chromosomeSize, double mutationProbability, double crossoverProbability) :
    m_mutationProbability{ mutationProbability }, m_crossoverProbability{ crossoverProbability }, m_chromosomeSize{ chromosomeSize } {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, 1);

    for (size_t curr = 0; curr < populationSize; ++curr) {
        std::vector<bool> currentChromosome(m_chromosomeSize);

        for (size_t gene = 0; gene < m_chromosomeSize; ++gene) {
            currentChromosome.at(gene) = dis(gen);
        }

        m_population.emplace_back(currentChromosome);
    }

    m_fitnessFunction = [this](const Chromosome& chromosome) -> int {
        return 0;
        };
}

ChromosomePopulation::ChromosomePopulation(const ChromosomePopulation& other) {
    *this = other;
}

ChromosomePopulation::ChromosomePopulation(ChromosomePopulation&& other) noexcept {
    *this = std::move(other);
}

ChromosomePopulation& ChromosomePopulation::operator=(const ChromosomePopulation& other) {
    if (this != &other) {
        m_population = other.m_population;
        m_mutationProbability = other.m_mutationProbability;
    }

    return *this;
}

ChromosomePopulation& ChromosomePopulation::operator=(ChromosomePopulation&& other) noexcept {
    if (this != &other) {
        m_population = std::exchange(other.m_population, std::vector<Chromosome>());
        m_mutationProbability = std::exchange(other.m_mutationProbability, consts::MUTATION_DEFAULT);
    }
    return *this;
}

void ChromosomePopulation::SetFitnessFunction(const std::function<int(const Chromosome&)>& fitnessFunction) {
    m_fitnessFunction = fitnessFunction;
}

Chromosome ChromosomePopulation::GetMin() const {
    return *(std::min_element(m_population.cbegin(), m_population.cend(), [this](const Chromosome& a, const Chromosome& b) {
        return a.GetFitnessValue(m_fitnessFunction) < b.GetFitnessValue(m_fitnessFunction);
        }));
}

std::function<int(const Chromosome&)> ChromosomePopulation::GetFitnessFunction() const {
    return m_fitnessFunction;
}

std::pair<Chromosome, size_t> ChromosomePopulation::Run(size_t epochs, std::ostream& output) {
    Chromosome best;
    size_t bestEpoch = 0;

    for (size_t epoch = 0; epoch < epochs; ++epoch) {
        Selection();
        Crossover();
        Mutation();

        Chromosome minChromo = GetMin();

        if (epoch % 10 == 0) {
            std::cout << "Population :: Run [I] Epoch no.        " << epoch << '\n';
            std::cout << "Population :: Run [I] Best Chromosome: " << minChromo << '\n';
            std::cout << "Population :: Run [I] Fitness Value:   " << minChromo.GetFitnessValue(m_fitnessFunction) << '\n' << '\n';
        }

        output << "Epoch no.        " << epoch << '\n';
        output << (*this) << '\n';
        output << "Best Chromosome: " << minChromo << '\n';
        output << "Fitness Value:   " << minChromo.GetFitnessValue(m_fitnessFunction) << '\n' << '\n';

        if (epoch == 0 || minChromo.GetFitnessValue(m_fitnessFunction) < best.GetFitnessValue(m_fitnessFunction)) {
            best = minChromo;
            bestEpoch = epoch;
        }
    }

    return { best, bestEpoch };
}

void ChromosomePopulation::Selection() {
    std::vector<Chromosome> nextPopulation;
    size_t tournamentSize = m_population.size() / 10;

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, m_population.size() - 1);

    while (nextPopulation.size() < m_population.size()) {
        Chromosome bestChromosome;
        bool first = true;

        for (size_t index = 0; index < tournamentSize; ++index) {
            Chromosome candidate = m_population.at(dis(gen));
            if (first || candidate.GetFitnessValue(m_fitnessFunction) < bestChromosome.GetFitnessValue(m_fitnessFunction)) {
                bestChromosome = candidate;
                first = false;
            }
        }

        nextPopulation.emplace_back(bestChromosome);
    }

    m_population = nextPopulation;
}

void ChromosomePopulation::Crossover() {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> distValue(0.0, 1.0);
    std::uniform_int_distribution<> distPos(0, m_chromosomeSize - 1);

    std::vector<Chromosome> nextPopulation;

    for (size_t index = 0; index < m_population.size() / 2; ++index) {
        Chromosome parent1 = m_population.at(2 * index);
        Chromosome parent2 = m_population.at(2 * index + 1);

        if (distValue(gen) < m_crossoverProbability) {
            int crossoverPoint = distPos(gen);
            parent1.Crossover(crossoverPoint, parent2);
        }

        nextPopulation.emplace_back(parent1);
        nextPopulation.emplace_back(parent2);
    }

    if (nextPopulation.size() < m_population.size()) {
        nextPopulation.emplace_back(m_population.back());
    }

    m_population = nextPopulation;
}

void ChromosomePopulation::Mutation() {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> distValue(0.0, 1.0);

    for (auto& chromosome : m_population) {
        for (size_t index = 0; index < m_chromosomeSize; ++index) {
            if (distValue(gen) < m_mutationProbability) {
                chromosome.Mutate(index);
            }
        }
    }
}

std::ostream& operator<<(std::ostream& lhs, const ChromosomePopulation& rhs) {
    for (const auto& chromosome : rhs.m_population) {
        lhs <<
            "Chromosome:      " << chromosome << '\n' <<
            "Fitness Value:   " << chromosome.GetFitnessValue(rhs.GetFitnessFunction()) << '\n';
    }

    return lhs;
}


```

Particle

```cpp

#pragma once

#include "Utils.hpp"

class Particle {
public:
    Particle() = default;
    Particle(const size_t& size, std::function<int(const std::vector<bool>&)> fitnessFunction);

    Particle(const Particle& other);
    Particle(Particle&& other) noexcept;

    Particle& operator=(const Particle& other);
    Particle& operator=(Particle&& other) noexcept;

    const std::vector<bool>& GetPosition() const;

    int GetFitness() const;

    void Update(const std::vector<bool>& globalBestPosition, double w, double c1, double c2);

private:
    std::vector<bool> m_position;
    std::vector<double> m_velocity;
    std::vector<bool> m_bestPosition;
    int m_bestFitness;

    std::function<int(const std::vector<bool>&)> m_fitnessFunction;
};

Particle::Particle(const size_t& size, std::function<int(const std::vector<bool>&)> fitnessFunction) {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, 1);
    std::uniform_real_distribution<> disReal(0.0, 1.0);

    m_position.resize(size);
    m_velocity.resize(size);
    m_bestPosition.resize(size);
    m_fitnessFunction = fitnessFunction;
    m_bestFitness = std::numeric_limits<int>::max();

    for (size_t index = 0; index < size; ++index) {
        m_position.at(index) = dis(gen);
        m_velocity.at(index) = disReal(gen);
        m_bestPosition.at(index) = m_position.at(index);
    }

    m_bestFitness = m_fitnessFunction(m_position);
}

Particle::Particle(const Particle& other) {
    *this = other;
}

Particle::Particle(Particle&& other) noexcept {
    *this = std::move(other);
}

Particle& Particle::operator=(const Particle& other) {
    if (this != &other) {
        m_position = other.m_position;
        m_velocity = other.m_velocity;
        m_bestPosition = other.m_bestPosition;
        m_bestFitness = other.m_bestFitness;
        m_fitnessFunction = other.m_fitnessFunction;
    }

    return *this;
}

Particle& Particle::operator=(Particle&& other) noexcept {
    if (this != &other) {
        m_position = std::exchange(other.m_position, std::vector<bool>());
        m_velocity = std::exchange(other.m_velocity, std::vector<double>());
        m_bestPosition = std::exchange(other.m_bestPosition,std::vector<bool>());
        m_bestFitness = std::exchange(other.m_bestFitness, std::numeric_limits<int>::max());
    }

    return *this;
}

const std::vector<bool>& Particle::GetPosition() const {
    return m_position;
}

int Particle::GetFitness() const {
    return m_bestFitness;
}

void Particle::Update(const std::vector<bool>& globalBestPosition, double w, double c1, double c2) {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(0.0, 1.0);

    for (size_t index = 0; index < m_position.size(); ++index) {
        double r1 = dis(gen);
        double r2 = dis(gen);

        m_velocity.at(index) = w * m_velocity.at(index) +
            c1 * r1 * (m_bestPosition.at(index) - m_position.at(index)) +
            c2 * r2 * (globalBestPosition.at(index) - m_position.at(index));

        double sigmoid = 1.0 / (1.0 + exp(-m_velocity.at(index)));

        m_position.at(index) = dis(gen) < sigmoid ? 1 : 0;
    }

    int currentFitness = m_fitnessFunction(m_position);
    if (currentFitness < m_bestFitness) {
        m_bestFitness = currentFitness;
        m_bestPosition = m_position;
    }
}


```

ParticleSwarm

```cpp

#pragma once

#include <vector>
#include <iostream>
#include <memory>

#include "Particle.hpp"
#include "Edge.hpp"

class ParticleSwarm {
public:
    ParticleSwarm(const size_t& swarmSize, const size_t& chromosomeSize, const std::vector<Edge>& edges, 
        double w, double c1, double c2, std::function<int(const std::vector<bool>&)> fitnessFunction);

    void Update();

    const std::vector<bool>& GetBestPosition() const { return m_globalBestPosition; }
    int GetBestFitness() const { return m_globalBestFitness; }

private:
    std::vector<Particle> m_particles;
    std::vector<bool> m_globalBestPosition;
    int m_globalBestFitness;

    double m_w;
    double m_c1;
    double m_c2;
};

ParticleSwarm::ParticleSwarm(const size_t& swarmSize, const size_t& chromosomeSize, const std::vector<Edge>& edges, 
    double w, double c1, double c2, std::function<int(const std::vector<bool>&)> fitnessFunction) :
    m_particles(swarmSize, Particle(chromosomeSize, fitnessFunction)),
    m_w(w), m_c1(c1), m_c2(c2), m_globalBestFitness(std::numeric_limits<int>::max()) {

    for (Particle& particle : m_particles) {
        int fitness = particle.GetFitness();
        if (fitness < m_globalBestFitness) {
            m_globalBestFitness = fitness;
            m_globalBestPosition = particle.GetPosition();
        }
    }
}

void ParticleSwarm::Update() {
    for (auto& particle : m_particles) {
        particle.Update(m_globalBestPosition, m_w, m_c1, m_c2);

        int fitness = particle.GetFitness();
        if (fitness < m_globalBestFitness) {
            m_globalBestFitness = fitness;
            m_globalBestPosition = particle.GetPosition();
        }
    }
}


```

Utils

```cpp

#pragma once

#include <raylib.h>
#include <stdlib.h>
#include <math.h>

#include <fstream>
#include <algorithm>
#include <iostream>
#include <functional>
#include <random>
#include <sstream>
#include <iomanip>
#include <string>
#include <chrono>
#include <vector>
#include <stack>
#include <set>

namespace consts {
    static const int INIT_ID            = -1;
    static const int SCREEN_WIDTH       = 1600;
    static const int SCREEN_HEIGHT      = 900;
    static const int SCREEN_MIN         = 0;
    static const int PARTICLE_COUNT     = 1000;
    static const int VELOCITY_MIN       = -100;
    static const int VELOCITY_MAX       = 100;
    static const int NODE_RADIUS        = 25;
    static const int COMPONENTS_MIN     = 1u;
    static const int EPOCHS_DEFAULT     = 100;
    static const int POPULATION_DEFAULT = 50;
    static const int PENALTY            = 3774;
    static const int EPOCHS_MAX         = 500;
    static const int POPULATION_MAX     = 100;
    static const int FACTOR             = 10;

    static const double FRICTION              = 0.99;
    static const double DISTANCE_MIN          = 1;
    static const double MUTATION_PROBABILITY  = 0.01;
    static const double CROSSOVER_PROBABILITY = 0.01;
    
    static const float DEG_0              = 0.0f;
    static const float DEG_90             = 90.0f;
    static const float DEG_180            = 180.0f;
    static const float DEG_270            = 270.0f;
    static const float NODES_MIN_DISTANCE = 80.0f;
    static const float EDGE_THICKNESS     = 3.0f;
    static const float WEIGHT_DEFAULT     = 1.0f;
    static const float MUTATION_DEFAULT   = 0.0f;

    static const Vector2 ORIGIN_ZERO   = { 0.0f, 0.0f };
    static const Vector2 ORIGIN_SCREEN = { 800, 450 };
};

namespace colors {
    static const Color PARTICLE_DEFAULT   = { 255, 255, 255, 255 };
    static const Color BACKGROUND_DEFAULT = { 0, 0, 0, 255 };
    static const Color NODE_FILL          = { 0, 128, 255, 255 };
    static const Color TEXT_DEFAULT       = { 241, 242, 247, 255 };
    static const Color EDGE_FILL          = { 199, 218, 215, 255 };
    static const Color WEIGHT_TEXT        = { 15, 200, 54, 255 };
    static const Color MODE_TEXT          = { 0, 158, 47, 255 };
}

namespace settings {
    static const int FPS          = 144;
    static const int SEED_DEFAULT = 1;
}

namespace poss {
    static const int DEBUG_TEXT_X      = 10;
    static const int FPS_TEXT_Y        = 10;
    static const int MODE_TEXT_Y       = 30;
    static const int FRICTION_TEXT_Y   = 50;
    static const int EPOCHS_TEXT_Y     = 70;
    static const int POPULATION_TEXT_Y = 90;

    static const Vector2 OFFSCREEN = { -100.0f, -100.0f };
}

namespace texts {
    static const int NODE_FONT_SIZE = 14;
    static const int EDGE_FONT_SIZE = 24;
    static const int MODE_FONT_SIZE = 20;

    static const char* NODE_DEFAULT = "  ";
    static const char* NODE_CLICKED = "Clicked";
    static const char* FRICTION_TEXT = "FRICTION: ";
    static const char* COVER_TEXT = "COVER: ";
    static const char* MODE_TEXT = "MODE: ";
    static const char* EPOCHS_TEXT = "EPOCH: ";
    static const char* POPULATION_TEXT = "POPULATION: ";
    static const char* MODE_GRAPH = "GRAPH";
    static const char* MODE_SWARM = "SWARM";
    static const char* WINDOW_TITLE = "Vertex Cover Problem / Particle Swarm";
    static const char* COVER_BRUTEFORCE = "BRUTEFORCE";
    static const char* COVER_GA = "GA";
    static const char* COVER_DPSO = "DPSO";
}

namespace maths {
    static float GetOriginDistanceV(const Vector2& point) {
        const float x2 = point.x * point.x;
        const float y2 = point.y * point.y;
        return sqrt(x2 - y2);
    }

    static float GetDistance2V(const Vector2& start, const Vector2& end) {
        const float dx = start.x - end.x;
        const float dy = start.y - end.y;
        return sqrt((dx * dx) + (dy * dy));
    }

    static float GetAngle2V(const Vector2& start, const Vector2& end) {
        float dx = end.x - start.x;
        float dy = end.y - start.y;
        return atan2(dy, dx) * (consts::DEG_180 / PI);
    }

    static Vector2 GetCenter2V(const Vector2& start, const Vector2& end) {
        const float dx = (start.x + end.x) / 2;
        const float dy = (start.y + end.y) / 2;
        return Vector2{ dx, dy };
    }
}

namespace clocks {

    static std::string TimeNowString() {
        std::time_t now = std::time(nullptr);
        std::tm localTime;
        localtime_s(&localTime, &now);

        std::ostringstream oss;
        oss << std::put_time(&localTime, "%Y%m%d-%H%M%S");
        return oss.str();
    }

}

```

Graph

```cpp

#pragma once

#include "Utils.hpp"
#include "Node.hpp"
#include "Edge.hpp"
#include "ChromosomePopulation.hpp"
#include "ParticlesSwarm.hpp"
#include <type_traits>

class Graph {
public:
    Graph();

    Graph(const Graph& other);
    Graph(Graph&& other) noexcept;

    Graph& operator=(const Graph& other);
    Graph& operator=(Graph&& other) noexcept;

    ~Graph() = default;

    void Update(const Vector2& mousePos, std::vector<Node*>& clickedNodes);

    void Draw() const;

    void IncreaseEpochs();
    void DecreaseEpochs();
    void IncreasePopulations();
    void DecreasePopulations();

    int GetEpochs() const;
    int GetPopulation() const;

    void Clear();

    int GetNextVertexCover(int currentCover);

    void CoverVertices();

    void AddNode(const Vector2& mousePos);

    void AddEdge(const Node& start, const Node& end);

    std::vector<Node>& GetNodes();
    std::vector<Edge>& GetEdges();
    std::vector<Node>& GetWorkableComponent();

    std::vector<std::vector<bool>>& GetAdjacencyMatrix();
    std::vector<std::vector<Node>>& GetConnectedComponents();

    void ConnectRandom();

    void DebugPrint(std::ostream& os = std::cout);
    void MakePresetCube();
    void MakePresetTetrahedron();
    void MakePresetDiamond();
    void MakePresetVertex();

private:
    void _updateGraph();

    void _updateAdjacencyMatrix();
    void _updateConnectedComponents();

    std::vector<Node> _neighbors(const size_t& index);

    void _dfs(const size_t& index, std::vector<bool>& visited, std::vector<Node>& component);

    void _runBruteforce();
    void _runGeneticAlgorithm();
    void _runDiscreteParticleSwarmOptimization();

private:
    int m_coverType;
    int m_epochsCount;
    int m_populationCount;
    std::vector<Node> m_nodes;
    std::vector<Edge> m_edges;

    std::vector<std::vector<bool>> m_adjacencyMatrix;
    std::vector<std::vector<Node>> m_connectedComponents;
};

#pragma region Rule Of Fifths

Graph::Graph() : m_coverType{0}, m_epochsCount{ consts::EPOCHS_DEFAULT }, m_populationCount{ consts::POPULATION_DEFAULT }, m_nodes{}, m_edges{}, m_adjacencyMatrix{}, m_connectedComponents{} {

}

Graph::Graph(const Graph& other) {
    *this = other;
}

Graph::Graph(Graph&& other) noexcept {
    *this = std::move(other);
}

Graph& Graph::operator=(const Graph& other) {
    if (this != &other) {
        m_coverType = other.m_coverType;
        m_nodes = other.m_nodes;
        m_edges = other.m_edges;
        m_adjacencyMatrix = other.m_adjacencyMatrix;
        m_connectedComponents = other.m_connectedComponents;
    }

    return *this;
}

Graph& Graph::operator=(Graph&& other) noexcept {
    if (this != &other) {
        m_coverType = std::exchange(other.m_coverType, 0);
        m_nodes = std::exchange(other.m_nodes, std::vector<Node>());
        m_edges = std::exchange(other.m_edges, std::vector<Edge>());
        m_adjacencyMatrix = std::exchange(other.m_adjacencyMatrix, std::vector<std::vector<bool>>());
        m_connectedComponents = std::exchange(other.m_connectedComponents, std::vector<std::vector<Node>>());
    }

    return *this;
}

#pragma endregion

#pragma region Public Functions

void Graph::Update(const Vector2& mousePos, std::vector<Node*>& clickedNodes) {
    bool nodeWasClicked = false;
    bool tooCloseToNode = false;

    for (Node& curr : GetNodes()) {
        float distance = maths::GetDistance2V(mousePos, curr.GetPosition());

        if (distance < curr.GetRadius()) {

            if (curr.GetText() == texts::NODE_CLICKED) {
                curr.SetText(texts::NODE_DEFAULT);
                clickedNodes.pop_back();
            }
            else {
                curr.SetText(texts::NODE_CLICKED);
                clickedNodes.emplace_back(&curr);
            }

            nodeWasClicked = true;
            break;
        }
        else if (distance < consts::NODES_MIN_DISTANCE) {
            tooCloseToNode = true;
        }
    }

    if (!nodeWasClicked && !tooCloseToNode) {

        if (!clickedNodes.empty()) {
            clickedNodes.at(0)->SetText(texts::NODE_DEFAULT);
            clickedNodes.pop_back();
        }

        AddNode(mousePos);
    }

    if (clickedNodes.size() == 2) {
        clickedNodes.at(0)->SetText(texts::NODE_DEFAULT);
        clickedNodes.at(1)->SetText(texts::NODE_DEFAULT);
        AddEdge(*clickedNodes.at(0), *clickedNodes.at(1));
        clickedNodes.clear();
    }

    _updateGraph();
}

void Graph::Draw() const {
    for (const Edge& edge : m_edges) {
        edge.Draw();
    }

    for (const Node& node : m_nodes) {
        node.Draw();
    }
}

void Graph::IncreaseEpochs() {
    if (m_epochsCount >= consts::EPOCHS_MAX) {
        return;
    }

    m_epochsCount += consts::FACTOR;
}

void Graph::DecreaseEpochs() {
    if (m_epochsCount <= 0) {
        return;
    }

    m_epochsCount -= consts::FACTOR;
}

void Graph::IncreasePopulations() {
    if (m_populationCount >= consts::POPULATION_MAX) {
        return;
    }

    m_populationCount += consts::FACTOR;
}

void Graph::DecreasePopulations() {
    if (m_populationCount <= 0) {
        return;
    }

    m_populationCount -= consts::FACTOR;
}

int Graph::GetEpochs() const {
    return m_epochsCount;
}

int Graph::GetPopulation() const {
    return m_populationCount;
}

void Graph::AddNode(const Vector2& mousePos) {
    const int id = m_nodes.size();
    m_nodes.emplace_back(Node(mousePos, m_nodes.size()));
}

void Graph::AddEdge(const Node& start, const Node& end) {
    if (start.GetId() == end.GetId()) {
        return;
    }

    std::vector<Edge>::iterator it = std::find(m_edges.begin(), m_edges.end(), Edge(start, end, -1));

    if (it != m_edges.end()) {
        return;
    }

    const int id = m_edges.size();
    m_edges.emplace_back(Edge(start, end, id));
}

void Graph::Clear() {
    m_nodes.clear();
    m_edges.clear();
    m_adjacencyMatrix.clear();
    m_connectedComponents.clear();
}

int Graph::GetNextVertexCover(int currentCover) {
    switch (currentCover) {

    case 0:
        m_coverType = 1;
        break;

    case 1:
        m_coverType = 0;
        break;

    default:
        break;
    }

    return m_coverType;
}

void Graph::CoverVertices() {

    if (m_connectedComponents.empty() || m_connectedComponents.size() > consts::COMPONENTS_MIN) {
        std::cout << "Graph :: CoverVertices [W] There must be a single connected component to perform vertex cover. Returning" << '\n';
        return;
    }

    for (Node& node : m_nodes) {
        node.Update(colors::NODE_FILL);
    }

    for (Edge& edge : m_edges) {
        edge.Update(colors::EDGE_FILL);
    }

    switch (m_coverType) {

    case 0:
        _runGeneticAlgorithm();
        break;

    case 1:
        _runDiscreteParticleSwarmOptimization();
        break;

    case 2:
        _runBruteforce();
        break;

    default:
        break;

    }

}

std::vector<Node>& Graph::GetNodes() {
    return m_nodes;
}

std::vector<Edge>& Graph::GetEdges() {
    return m_edges;
}

std::vector<Node>& Graph::GetWorkableComponent() {
    return m_connectedComponents.at(0);
}

std::vector<std::vector<Node>>& Graph::GetConnectedComponents() {
    return m_connectedComponents;
}

std::vector<std::vector<bool>>& Graph::GetAdjacencyMatrix() {
    return m_adjacencyMatrix;
}

void Graph::ConnectRandom() {

    if (m_nodes.empty()) {
        return;
    }

    for (Node& node : m_nodes) {
        node.Update(colors::NODE_FILL);
    }

    m_edges.clear();
    _updateConnectedComponents();

    while (m_connectedComponents.size() != consts::COMPONENTS_MIN) {
        AddEdge(
            m_nodes.at(static_cast<size_t>(GetRandomValue(0, m_nodes.size() - 1))),
            m_nodes.at(static_cast<size_t>(GetRandomValue(0, m_nodes.size() - 1))));

        _updateConnectedComponents();
    }

    _updateGraph();
}

#pragma endregion

#pragma region Private Functions

void Graph::_updateGraph() {
    _updateAdjacencyMatrix();
    _updateConnectedComponents();
}

void Graph::_updateAdjacencyMatrix() {
    m_adjacencyMatrix.clear();

    if (m_nodes.empty()) {
        return;
    }

    for (size_t row = 0; row < m_nodes.size(); ++row) {
        m_adjacencyMatrix.emplace_back(std::vector<bool>(m_nodes.size(), false));
    }

    for (const Edge& edge : m_edges) {
        size_t startIdx = edge.GetStart().GetId();
        size_t endIdx = edge.GetEnd().GetId();

        if (startIdx < m_nodes.size() && endIdx < m_nodes.size()) {
            m_adjacencyMatrix.at(startIdx).at(endIdx) = m_adjacencyMatrix.at(endIdx).at(startIdx) = true;
        }
    }
}

void Graph::_updateConnectedComponents() {
    m_connectedComponents.clear();

    if (m_nodes.empty() || m_edges.empty()) {
        return;
    }

    std::vector<bool> visited(m_nodes.size(), false);

    for (size_t index = 0; index < m_nodes.size(); ++index) {
        if (!visited.at(index)) {
            std::vector<Node> component;
            _dfs(index, visited, component);
            m_connectedComponents.emplace_back(component);
        }
    }
}

std::vector<Node> Graph::_neighbors(const size_t& index) {
    std::vector<Node> neighbors;

    for (const Edge& edge : m_edges) {
        if (edge.GetStart().GetId() == index) {
            neighbors.emplace_back(edge.GetEnd());
        }
        else if (edge.GetEnd().GetId() == index) {
            neighbors.emplace_back(edge.GetStart());
        }
    }

    return neighbors;
}

void Graph::_dfs(const size_t& index, std::vector<bool>& visited, std::vector<Node>& component) {
    std::stack<size_t> stack;
    stack.push(index);
    visited.at(index) = true;

    while (!stack.empty()) {
        size_t current = stack.top();
        stack.pop();
        component.emplace_back(m_nodes.at(current));

        for (const Node& neighbor : _neighbors(current)) {
            size_t neighborIndex = neighbor.GetId();

            if (!visited.at(neighborIndex)) {
                stack.push(neighborIndex);
                visited.at(neighborIndex) = true;
            }
        }
    }
}

#pragma endregion

#pragma region Bruteforce Minimization

bool IsVertexCover(const std::vector<Edge>& edges, const std::set<Node>& vertices, size_t& callsCount);
std::set<Node> BruteforceMinSet(std::vector<Node>& nodes, std::vector<Edge>& edges);
void GenerateAllPossibleSubsets(std::vector<Node>& nodes, std::vector<std::set<Node>>& subsets, std::set<Node>& curr, size_t index, size_t& callsCount);

void Graph::_runBruteforce() {
    std::vector<Node> nodes = m_nodes;
    std::vector<Edge> edges = m_edges;

    for (const Node& node : BruteforceMinSet(nodes, edges)) {
        m_nodes.at(node.GetId()).Update(RED);

        for (Edge& edge : m_edges) {
            if (edge.Connects(node)) {
                edge.Update(BLUE);
            }
        }
    }
}

bool IsVertexCover(const std::vector<Edge>& edges, const std::set<Node>& vertices, size_t& callsCount) {
    for (const Edge& edge : edges) {
        if (vertices.find(edge.GetStart()) == vertices.end() &&
            vertices.find(edge.GetEnd()) == vertices.end()) {
            return false;
        }
    }

    return true;
}

void GenerateAllPossibleSubsets(std::vector<Node>& nodes, std::vector<std::set<Node>>& subsets, std::set<Node>& curr, size_t index, size_t& callsCount) {
    if (index == nodes.size()) {
        subsets.emplace_back(curr);
        return;
    }

    GenerateAllPossibleSubsets(nodes, subsets, curr, index + 1, ++callsCount);
    curr.insert(nodes.at(index));
    GenerateAllPossibleSubsets(nodes, subsets, curr, index + 1, ++callsCount);
    curr.erase(nodes.at(index));
}

std::set<Node> BruteforceMinSet(std::vector<Node>& nodes, std::vector<Edge>& edges) {

    std::cout << "Graph :: _bruteforce [D] Started." << '\n';
    std::vector<std::set<Node>> subsets;

    std::set<Node> curr;
    std::set<Node> minim{};

    size_t callsCount{};
    size_t reassignCount{};
    size_t usedSubsets{};

    std::chrono::steady_clock::time_point before = std::chrono::high_resolution_clock::now();

    GenerateAllPossibleSubsets(nodes, subsets, curr, 0, callsCount);

    std::chrono::steady_clock::time_point after = std::chrono::high_resolution_clock::now();
    std::chrono::milliseconds duration = std::chrono::duration_cast<std::chrono::milliseconds>(after - before);
    std::cout << "Graph :: _bruteforce [D] Generated subsets. Took: " << duration.count() << "ms" << '\n';

    usedSubsets = subsets.size();

    for (const std::set<Node>& subset : subsets) {
        if (IsVertexCover(edges, subset, ++callsCount)) {
            --usedSubsets;

            if (minim.empty() || subset.size() < minim.size()) {
                ++reassignCount;
                minim = subset;
            }
        }
    }

    std::cout << "Graph :: _bruteforce [D] Minimum found." << '\n';
    std::cout << "Graph :: _bruteforce [D] Unused Subsets Count= " << usedSubsets << '\n';
    std::cout << "Graph :: _bruteforce [D] Minim reassinment Count= " << reassignCount << '\n';
    std::cout << "Graph :: _bruteforce [D] Function calls count= " << callsCount << '\n';

    return minim;
}

#pragma endregion

#pragma region GA Minimization

int vertexCoverFitness(const Chromosome& chromosome, const std::vector<Edge>& edges) {
    const std::vector<bool>& genes = chromosome.GetGenes();
    int uncoveredEdges = 0;
    int selectedNodes = 0;

    for (const Edge& edge : edges) {
        if (!genes[edge.GetStart().GetId()] && !genes[edge.GetEnd().GetId()]) {
            ++uncoveredEdges;
        }
    }

    for (bool gene : genes) {
        if (gene) {
            ++selectedNodes;
        }
    }

    return (uncoveredEdges * consts::PENALTY) + selectedNodes;
}

void Graph::_runGeneticAlgorithm() {
    std::vector<Edge> edges = m_edges;
    size_t chromoSize = m_nodes.size();

    std::string fileName = "out/test-ga_" + clocks::TimeNowString() + ".txt";
    std::ofstream output(fileName);
    output << "#start\n";
    DebugPrint(output);

    std::chrono::steady_clock::time_point before = std::chrono::high_resolution_clock::now();

    auto fitnessFunction = [&edges](const Chromosome& chromo) -> int {
        return vertexCoverFitness(chromo, edges);
        };

    ChromosomePopulation population(m_populationCount, chromoSize, consts::MUTATION_PROBABILITY, consts::CROSSOVER_PROBABILITY);

    population.SetFitnessFunction(fitnessFunction);

    std::pair<Chromosome, size_t> result = population.Run(m_epochsCount, output);

    std::chrono::steady_clock::time_point after = std::chrono::high_resolution_clock::now();
    std::chrono::milliseconds duration = std::chrono::duration_cast<std::chrono::milliseconds>(after - before);
    
    output << "Best Chromosome: " << result.first << '\n';
    output << "Best Solution:   " << result.first.GetFitnessValue(fitnessFunction) << '\n';
    output << "Best Epoch:      " << result.second << '\n';
    output << "Time Taken:      " << duration.count() << "ms" << '\n';
    output << "#end";

    std::vector<bool> chromo = result.first.GetGenes();

    for (size_t geneIdx = 0; geneIdx < chromoSize; ++geneIdx) {
        if (chromo.at(geneIdx)) {
            m_nodes.at(geneIdx).Update(RED);

            for (Edge& edge : m_edges) {
                if (edge.Connects(m_nodes.at(geneIdx))) {
                    edge.Update(BLUE);
                }
            }
        }
    }

    std::cout << "Graph :: GA [I] Best Chromosome:       " << result.first << '\n';
    std::cout << "Graph :: GA [I] Best Epoch:            " << result.second << '\n';
    std::cout << "Graph :: GA [I] Best Fit:              " << result.first.GetFitnessValue(fitnessFunction) << '\n';
    std::cout << "Graph :: GA [I] Took:                  " << duration.count() << "ms" << '\n';
}

#pragma endregion

#pragma region DPSO Minimization

void Graph::_runDiscreteParticleSwarmOptimization() {
    std::vector<Edge> edges = m_edges;
    size_t chromosomeSize = m_nodes.size(); 
    double w = 0.5;  
    double c1 = 1.0; 
    double c2 = 1.0; 

    std::string fileName = "out/test-dpso_" + clocks::TimeNowString() + ".txt";
    std::ofstream output(fileName);

    auto fitnessFunction = [&](const std::vector<bool>& solution) -> int {
        int uncoveredEdges = 0;
        int selectedNodes = 0;
        for (const auto& edge : edges) {
            if (!solution[edge.GetStart().GetId()] && !solution[edge.GetEnd().GetId()]) {
                ++uncoveredEdges;
            }
        }
        for (bool gene : solution) {
            if (gene) {
                ++selectedNodes;
            }
        }
        return (uncoveredEdges * consts::PENALTY) + selectedNodes;
        };

    output << "#start\n";
    DebugPrint(output);

    std::chrono::steady_clock::time_point before = std::chrono::high_resolution_clock::now();

    ParticleSwarm swarm(m_populationCount, chromosomeSize, edges, w, c1, c2, fitnessFunction);

    for (size_t epoch = 0; epoch < m_epochsCount; ++epoch) {
        swarm.Update();

        if (epoch % 10 == 0) {
            std::cout << "Swarm :: Run [I] Epoch no.             " << epoch << '\n';
            std::cout << "Swarm :: Run [I] Best Chromosome:      " << swarm.GetBestPosition() << '\n';
            std::cout << "Swarm :: Run [I] Fitness Value:        " << swarm.GetBestFitness() << '\n' << '\n';
        }

        output << "Epoch no.        " << epoch << '\n';
        output << "Best Chromosome: " << swarm.GetBestPosition() << '\n';
        output << "Fitness Value:   " << swarm.GetBestFitness() << '\n' << '\n';
    }

    std::chrono::steady_clock::time_point after = std::chrono::high_resolution_clock::now();
    std::chrono::milliseconds duration = std::chrono::duration_cast<std::chrono::milliseconds>(after - before);

    const std::vector<bool>& bestSolution = swarm.GetBestPosition();
    int bestFitness = swarm.GetBestFitness();

    for (bool gene : bestSolution) {
        output << gene << ' ';
    }
    output << '\n';
    output << "Best fitness:    " << bestFitness << std::endl;
    output << "#end";

    for (size_t geneIdx = 0; geneIdx < bestSolution.size(); ++geneIdx) {
        if (bestSolution.at(geneIdx)) {
            m_nodes.at(geneIdx).Update(RED);

            for (Edge& edge : m_edges) {
                if (edge.Connects(m_nodes.at(geneIdx))) {
                    edge.Update(BLUE);
                }
            }
        }
    }

    std::cout << "Graph :: DPSO [I] Best Solution:       ";
    for (bool gene : bestSolution) {
        std::cout << gene << ' ';
    }
    std::cout << '\n';
    std::cout << "Graph :: DPSO [I] Best Fit:            " << bestFitness << '\n';
    std::cout << "Graph :: DPSO [I] Took:                " << duration.count() << "ms" << '\n';

}

#pragma endregion

#pragma region Presets

void Graph::MakePresetCube() {
    Clear();

    const Vector2 node0 = { 485, 800 };
    const Vector2 node1 = { 970, 800 };
    const Vector2 node2 = { 485, 315 };
    const Vector2 node3 = { 970, 315 };
    const Vector2 node4 = { 720, 70 };
    const Vector2 node5 = { 1205, 70 };
    const Vector2 node6 = { 720, 555 };
    const Vector2 node7 = { 1205, 555 };

    AddNode(node0);
    AddNode(node1);
    AddNode(node2);
    AddNode(node3);
    AddNode(node4);
    AddNode(node5);
    AddNode(node6);
    AddNode(node7);

    AddEdge(m_nodes.at(0), m_nodes.at(1));
    AddEdge(m_nodes.at(0), m_nodes.at(2));
    AddEdge(m_nodes.at(0), m_nodes.at(6));
    AddEdge(m_nodes.at(1), m_nodes.at(3));
    AddEdge(m_nodes.at(1), m_nodes.at(7));
    AddEdge(m_nodes.at(2), m_nodes.at(3));
    AddEdge(m_nodes.at(2), m_nodes.at(4));
    AddEdge(m_nodes.at(3), m_nodes.at(5));
    AddEdge(m_nodes.at(4), m_nodes.at(5));
    AddEdge(m_nodes.at(4), m_nodes.at(6));
    AddEdge(m_nodes.at(5), m_nodes.at(7));
    AddEdge(m_nodes.at(6), m_nodes.at(7));

    _updateGraph();
}

void Graph::MakePresetTetrahedron() {
    Clear();

    const Vector2 node0 = { 500, 665 };
    const Vector2 node1 = { 1020, 656 };
    const Vector2 node2 = { 750, 180 };
    const Vector2 node3 = { 820, 515 };

    AddNode(node0);
    AddNode(node1);
    AddNode(node2);
    AddNode(node3);

    AddEdge(m_nodes.at(0), m_nodes.at(1));
    AddEdge(m_nodes.at(0), m_nodes.at(2));
    AddEdge(m_nodes.at(0), m_nodes.at(3));
    AddEdge(m_nodes.at(1), m_nodes.at(2));
    AddEdge(m_nodes.at(1), m_nodes.at(3));
    AddEdge(m_nodes.at(2), m_nodes.at(3));

    _updateGraph();
}

void Graph::MakePresetDiamond() {
    Clear();

    const Vector2 node0 = { 800, 800 };
    const Vector2 node1 = { 300, 400 };
    const Vector2 node2 = { 500, 400 };
    const Vector2 node3 = { 700, 400 };
    const Vector2 node4 = { 900, 400 };
    const Vector2 node5 = { 1100, 400 };
    const Vector2 node6 = { 1300, 400 };
    const Vector2 node7 = { 500, 130 };
    const Vector2 node8 = { 700, 130 };
    const Vector2 node9 = { 900, 130 };
    const Vector2 node10 = { 1100, 130 };

    AddNode(node0);
    AddNode(node1);
    AddNode(node2);
    AddNode(node3);
    AddNode(node4);
    AddNode(node5);
    AddNode(node6);
    AddNode(node7);
    AddNode(node8);
    AddNode(node9);
    AddNode(node10);

    AddEdge(m_nodes.at(0), m_nodes.at(1));
    AddEdge(m_nodes.at(0), m_nodes.at(2));
    AddEdge(m_nodes.at(0), m_nodes.at(3));
    AddEdge(m_nodes.at(0), m_nodes.at(4));
    AddEdge(m_nodes.at(0), m_nodes.at(5));
    AddEdge(m_nodes.at(0), m_nodes.at(6));
    AddEdge(m_nodes.at(1), m_nodes.at(2));
    AddEdge(m_nodes.at(1), m_nodes.at(7));
    AddEdge(m_nodes.at(2), m_nodes.at(3));
    AddEdge(m_nodes.at(2), m_nodes.at(8));
    AddEdge(m_nodes.at(3), m_nodes.at(4));
    AddEdge(m_nodes.at(3), m_nodes.at(7));
    AddEdge(m_nodes.at(3), m_nodes.at(9));
    AddEdge(m_nodes.at(4), m_nodes.at(5));
    AddEdge(m_nodes.at(4), m_nodes.at(8));
    AddEdge(m_nodes.at(4), m_nodes.at(10));
    AddEdge(m_nodes.at(5), m_nodes.at(6));
    AddEdge(m_nodes.at(5), m_nodes.at(9));
    AddEdge(m_nodes.at(6), m_nodes.at(10));
    AddEdge(m_nodes.at(7), m_nodes.at(8));
    AddEdge(m_nodes.at(8), m_nodes.at(9));
    AddEdge(m_nodes.at(9), m_nodes.at(10));

    _updateGraph();
}

void Graph::MakePresetVertex() {
    Clear();

    const Vector2 node0 = { 250, 150 };
    const Vector2 node1 = { 695, 80 };
    const Vector2 node2 = { 710, 325 };
    const Vector2 node3 = { 905, 500 };
    const Vector2 node4 = { 1205, 605 };
    const Vector2 node5 = { 1290, 330 };
    const Vector2 node6 = { 1540, 370 };
    const Vector2 node7 = { 970, 270 };
    const Vector2 node8 = { 580, 605 };
    const Vector2 node9 = { 295, 480 };
    const Vector2 node10 = { 95, 330 };

    AddNode(node0);
    AddNode(node1);
    AddNode(node2);
    AddNode(node3);
    AddNode(node4);
    AddNode(node5);
    AddNode(node6);
    AddNode(node7);
    AddNode(node8);
    AddNode(node9);
    AddNode(node10);

    AddEdge(m_nodes.at(0), m_nodes.at(1));
    AddEdge(m_nodes.at(0), m_nodes.at(2));
    AddEdge(m_nodes.at(0), m_nodes.at(8));
    AddEdge(m_nodes.at(0), m_nodes.at(9));
    AddEdge(m_nodes.at(2), m_nodes.at(3));
    AddEdge(m_nodes.at(2), m_nodes.at(7));
    AddEdge(m_nodes.at(3), m_nodes.at(4));
    AddEdge(m_nodes.at(3), m_nodes.at(7));
    AddEdge(m_nodes.at(4), m_nodes.at(5));
    AddEdge(m_nodes.at(5), m_nodes.at(6));
    AddEdge(m_nodes.at(7), m_nodes.at(5));
    AddEdge(m_nodes.at(10), m_nodes.at(9));
    AddEdge(m_nodes.at(10), m_nodes.at(0));

    _updateGraph();
}

#pragma endregion

#pragma region Debugging

void Graph::DebugPrint(std::ostream& os) {
    os << "Graph Information" << '\n';

    os << "Nodes: " << '\n';
    for (size_t nodeIdx = 0; nodeIdx < m_nodes.size(); ++nodeIdx) {
        os << "  " << m_nodes.at(nodeIdx) << '\n';
    }

    os << "Edges: " << '\n';
    for (size_t edgeIdx = 0; edgeIdx < m_edges.size(); ++edgeIdx) {
        os << "  " << m_edges.at(edgeIdx) << '\n';
    }

    os << "Nodes Count: " << m_nodes.size() << '\n';
    os << "Edges Count: " << m_edges.size() << '\n';
    os << "Adjacency Matrix: " << '\n';
    for (size_t rowIdx = 0; rowIdx < m_adjacencyMatrix.size(); ++rowIdx) {
        for (size_t colIdx = 0; colIdx < m_adjacencyMatrix[0].size(); ++colIdx) {
            os << m_adjacencyMatrix.at(rowIdx).at(colIdx) << ' ';
        }
        os << '\n';
    }

    os << "Connected Components: " << '\n';
    for (size_t compIdx = 0; compIdx < m_connectedComponents.size(); ++compIdx) {
        os << "CompIdx=" << compIdx << ", CompSize=" << m_connectedComponents[compIdx].size() << ", CompNodesV=[ " << '\n';
        for (size_t nodeIdx = 0; nodeIdx < m_connectedComponents[compIdx].size(); ++nodeIdx) {
            os << "  " << m_connectedComponents.at(compIdx).at(nodeIdx) << ",\n";
        }
        os << " ]" << '\n';
    }

    os << "Epochs: " << m_epochsCount << '\n';
    os << "Population:" << m_populationCount << '\n';

    std::string vertCoverName = (m_coverType == 0) ? "GA" : "DPSO";

    os << "Cover Type: " << vertCoverName << '\n';
}

#pragma endregion


```


