//
//  Graph.swift
//  SwiftNet
//
//  Created by Tyler Fleming Cloutier on 7/12/14.
//  Copyright (c) 2014 Starfire, LP. All rights reserved.
//

import Foundation

extension String: NodeKey{}
extension Int: NodeKey{}
extension Double: NodeKey{}
extension Float: NodeKey{}

protocol NodeKey:Hashable {}

class Edge<T:NodeKey> {
    //Public
    var weight = 0
    var properties = [String:Any]()
    //Private
    var toNode: T! = nil
    var fromNode: T! = nil
    subscript(name: String) -> Any? {
        get {
            return properties[name]
        }
        set {
            properties[name] = newValue
        }
    }
    
    init(){}
    init(weight: Int) {
        self.weight = weight
    }
    
}

class Node<T:NodeKey> {
    //Public
    var properties = [String:Any]()
    //Private
    var edges = [T:Edge<T>]()
    var incomingEdges = [T:Edge<T>]()
    var neighbors = [T:Node<T>]()
    subscript(name: String) -> Any? {
        get {
            return properties[name]
        }
        set {
            properties[name] = newValue
        }
    }
}

extension Node: Sequence {
    func generate() -> DictionaryGenerator<T, Node<T>> {
        return self.neighbors.generate()
    }
}

class Graph<T:NodeKey> {
    //Private
    var nodes = [T:Node<T>]()
    var edges = [T:[T:Edge<T>]]()
    var count: Int {
    return self.nodes.count
    }
    subscript(n: T) -> Node<T>? {
        get {
            return nodes[n]
        }
        set {
            nodes[n] = newValue
        }
    }
    subscript(u: T, v: T) -> Edge<T>? {
        get {
            return self[u]?.edges[v]
        }
        set {
            if (!newValue) {
                if self[u] {
                    self[u]!.edges[v] = nil
                    self[u]!.neighbors[v] = nil
                    self[v]!.incomingEdges[u] = nil
                }
            } else {
                if !self[u] {
                    self[u] = Node()
                }
                if !self[v]{
                    self[v] = Node()
                }
                newValue!.fromNode = u
                newValue!.toNode = v
                self[u]!.neighbors[v] = self[v]
                self[u]!.edges[v] = newValue
                self[v]!.incomingEdges[u] = newValue
            }
        }
    }
    
    func addNode(n: T) {
        self[n] = Node()
    }
    
    func removeNode(n: T) {
        self[n] = nil
    }
    
    func addEdgeFromNode(u: T, toNode v: T) {
        self[u, v] = Edge()
    }
    
    func removeEdgeFromNode(u: T, toNode v: T) {
        self[u, v] = nil
    }
    
    func addEdgeUndirected(#u: T, toNode v: T) {
        self[u, v] = Edge()
        self[v, u] = Edge()
    }
    
    func removeEdgeUndirected(#u: T, toNode v: T) {
        self[u, v] = nil
        self[v, u] = nil
    }
    
    func getEdgeFromNode(u: T, toNode v: T) -> Edge<T>? {
        return self[u, v]
    }
    
    func hasEdgeFromNode(u: T, toNode v: T) -> Bool {
        if self[u, v] {
            return true
        }
        return false
    }
}

extension Graph: Sequence {
    func generate() -> DictionaryGenerator<T, Node<T>> {
        return self.nodes.generate()
    }
}
