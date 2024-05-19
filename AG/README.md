# AG


```cpp
std::vector<Edge> Graph::Kruskal() {

	if (m_directed) {
		// throw "Graph is directed";
		std::cout << "Graph::Kruskal >>> Graph is directed." << std::endl;
		return {};
	}

	if (!m_weighted) {
		//throw "Graph is not weighted";
		std::cout << "Graph::Kruskal >>> Graph is NOT weighted." << std::endl;
		return {};
	}

	if (m_nodes.size() < 2) {
		//throw "Graph has less than 2 nodes.";
		std::cout << "Graph::Kruskal >>> Graph is has less than 2 nodes." << std::endl;
		return {};
	}

	if (m_connectedComponents.size() != 1) {
		//throw "Graph is not connected";
		std::cout << "Graph::Kruskal >>> Graph is NOT connected." << std::endl;
		return {};
	}

	std::sort(m_edges.begin(), m_edges.end(), [&](const Edge& e1, const Edge& e2) { return e1.Weight() < e2.Weight(); }); // O(e log e) | e = no. of edges

	std::vector<Edge> kruskalMST; // O(1)
	std::vector<Node> components(m_nodes.size()); // O(n) | n = no. of nodes

	for (const auto& node : m_connectedComponents[0]) { // O(n) | n = no. of edges
		components[_IndexOf(node)] = node;
	}

	for (const auto& edge : m_edges) { // O(e) | e = no. of edges
		size_t startIdx = _IndexOf(edge.Start()); 
		size_t endIdx = _IndexOf(edge.End()); 

		if (components[startIdx] != components[endIdx]) { // O(log n) 
			kruskalMST.emplace_back(edge);

			Node oldComponentNode = components[endIdx];
			Node newComponentNode = components[startIdx];

			for (size_t i = 0; i < m_nodes.size(); ++i) { // O(e log n)
				if (components[i] == oldComponentNode) {
					components[i] = newComponentNode;
				}
			}
		}
	}

	// Complexity: O(e log n) | e = no. of edges n = no.of nodes

	return kruskalMST;
}
```