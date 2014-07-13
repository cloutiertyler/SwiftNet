//
//  SwiftNetTests.swift
//  SwiftNetTests
//
//  Created by Tyler Fleming Cloutier on 7/12/14.
//  Copyright (c) 2014 Starfire, LP. All rights reserved.
//

import XCTest
import SwiftNet

class SwiftNetTests: XCTestCase {
    var graph = Graph<String>()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNodes() {
        graph.addNode("a")
        graph.addNode("b")
        graph["c"] = Node()
        graph["d"] = Node()
        
        XCTAssert(self.graph["a"], "Error when adding node.")
        XCTAssert(self.graph["d"], "Subcripting error when adding node.")

        graph["c", "a"] = nil
        graph["a"]?.neighbors["b"]
        graph["a"]?.edges["b"]
        for (key, _) in graph.nodes["a"]!.edges {
            key
        }
        
        graph["a", "b"]!["distance"] = 4
        
        XCTAssert(self.graph.nodes["a"], "Node \"a\" was not found in the graph.")
        XCTAssert(!self.graph.nodes["b"]?.edges["a"], "Edge was found were no edge should be.")
    }
    
    func testNodeProperties() {
        graph["a"]!["prop1"] = 4
        
        XCTAssert(graph["a"]!["prop1"])
    }
    
    func testEdges() {
        graph["a", "b"] = Edge()
        graph["b", "a"] = Edge()
        
        XCTAssert(graph["a", "b"], "Error when adding edge.")
        
        graph["a", "b"]!.weight = 5
        
        XCTAssert(graph["a", "b"]?.weight == 5)
        
        XCTAssert(graph.hasEdgeFromNode("a", toNode: "b"))
    }
    
    func testEdgeProperties() {
    
    }
    
    func testRemoveNodes() {
        graph.removeNode("a")
        graph["b"] = nil
        
        XCTAssert(!graph["b"], "Problem removing node with subscript.")
        XCTAssert(!graph.nodes["a"], "Problem removing node with remove method.")
    }
    
    func testEnumeration() {
        
    }
    
    func testRemoveEdges() {
        graph["b", "a"] = nil
        
        XCTAssert(!graph["b", "a"])
    }
    
    func testAddNodesPerformance() {
        self.measureBlock() {
            
        }
    }
    
}
