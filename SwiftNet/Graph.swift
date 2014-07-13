//
//  Graph.swift
//  SwiftNet
//
//  Created by Tyler Fleming Cloutier on 7/12/14.
//  Copyright (c) 2014 Starfire, LP. All rights reserved.
//

import Foundation

//var __g: Generator = mySequence.generate()
//while let x = __g.next() {
//    // iterations here
//}

extension String: Node{}
extension Int: Node{}
extension Double: Node{}
extension Float: Node{}

protocol Node:Hashable {
    
}

//Operators to be considered in the future.
operator infix-->{}

@infix func --><T:Node>(var fromNodeData:NodeData<T>?, dummy: [T]) -> Edge<T>? {
    return fromNodeData?.outgoingEdges[dummy[0]]
}

operator infix<--{}

@infix func <--<T:Node>(var fromNodeData:NodeData<T>?, dummy: [T]) -> Edge<T>? {
    return fromNodeData?.incomingEdges[dummy[0]]
}

operator infix<->{}

@infix func <-><T:Node>(var fromNodeData:NodeData<T>?, dummy: [T]) -> Edge<T>? {
    return fromNodeData?.undirectedEdges[dummy[0]]
}

class NodeData<T:Node> {
    var neighbors = [T:NodeData<T>]()
    var incomingEdges = [T:Edge<T>]()
    var outgoingEdges = [T:Edge<T>]()
    var undirectedEdges:[T:Edge<T>] {
    return outgoingEdges;
    }
    var props = [:]
    subscript(n: T) -> NodeData<T>? {
        get {
            return neighbors[n]
        }
        set {
            neighbors[n] = newValue
        }
    }
}

struct Edge<T:Node> {
    unowned let toNode, fromNode: NodeData<T>
    var weight = 0
    var props = [:]
    
    init(fromNode: NodeData<T>, toNode: NodeData<T>) {
        self.toNode = toNode
        self.fromNode = fromNode
    }
}

class Graph<T:Node> {
    var nodes = [T:NodeData<T>]()
    subscript(n: T) -> NodeData<T>? {
        get {
            return nodes[n]
        }
        set {
            nodes[n] = newValue
        }
    }
    
    func count() -> Int {
        return self.nodes.count
    }
    
    func order() -> Int {
        return self.count()
    }
    
    func addNode(n: T) {
        self.nodes[n] = NodeData()
    }
    
    func removeNode(n: T) {
        self.nodes[n] = nil
    }
    
    func addNodeIfDoesNotExist(n: T) {
        if !self.nodes[n] {
            self.nodes[n] = NodeData()
        }
    }
    
    func addDirectedEdgeFromNode(u: T, toNode v: T) {
        self.addNodeIfDoesNotExist(u)
        self.addNodeIfDoesNotExist(v)
        
        self.nodes[u]![v] = self.nodes[u]
    }
    
    func addUndirectedEdge(#u: T, v: T) {
        self.addNodeIfDoesNotExist(u)
        self.addNodeIfDoesNotExist(v)
        
        self.nodes[u]![v] = self.nodes[v]
        self.nodes[v]![u] = self.nodes[u]
        let u_to_v = Edge(fromNode:self.nodes[u]!, toNode: self.nodes[v]!)
        let v_to_u = Edge(fromNode:self.nodes[v]!, toNode: self.nodes[v]!)
        self.nodes[u]!.incomingEdges[v] = u_to_v;
        self.nodes[u]!.outgoingEdges[v] = v_to_u;
        self.nodes[v]!.incomingEdges[u] = u_to_v;
        self.nodes[v]!.outgoingEdges[u] = v_to_u;
    }
    
    func hasEdgeFromNode(u: T, toNode v: T) -> Bool {
        if self.nodes[u]?[v]? {
            return true
        }
        return false
    }
}