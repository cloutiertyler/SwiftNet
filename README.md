SwiftNet
========

A network/graph framework implemented in Swift and inspired by NetworkX.

The API is very straigtforward and super easy to use. SwiftNet does not assume anything about what type of object you should use for your graph, except that implement the hashable protocol. That means that the basic types like Strings, Ints, Floats, and Doubles work right of of the shelf.

```swift
var graph = Graph<String>()

//Adding nodes is very simple.
graph.addNode("a")
graph.addNode("b")

//Or add by subscripting
graph["c"] = NodeData()

//Add a new edge to the graph.
graph.addUndirectedEdge(u: "a", v: "b")
graph.addUndirectedEdge(u: "a", v: "c")

//Access the edge with subscripting
var edge = graph["a", "b"]

//Access the neighbors of "a"
var neighbors = graph["a"].neighbors
println(neighbors["b"])

//Or alternatively...
println(graph["a"]?["b"])
```
