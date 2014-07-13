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
    
    func testAddNodes() {
        graph.addNode("a")
        graph.addNode("b")
        graph.addNode("c")
        graph["d"] = NodeData()
        
        XCTAssert(self.graph["d"], "Subcripting error when adding node.")
        XCTAssert(self.graph.nodes["a"], "Node \"a\" was not found in the graph.")
        XCTAssert(!self.graph.nodes["b"]?["a"], "Edge was found were no edge should be.")
    }
    
    func testUndirectedEdges() {
        graph.addUndirectedEdge(u: "a", v: "b")
        var edge = graph.nodes["b"] --> ["a"]

        XCTAssert(edge, "Edge was not found.")
        XCTAssert(self.graph.nodes["b"]?["a"], "Edge was not found.")
        XCTAssert(graph.hasEdgeFromNode("b", toNode: "a"), "Graph has no such edge!")
    }
    
    func testRemoveNodes() {
        graph.removeNode("a")
        graph["b"] = nil
        
        XCTAssert(!graph["b"], "Problem removing node with subscript.")
        XCTAssert(!graph.nodes["a"], "Problem removing node with remove method.")
    }
    
    func testAddNodesPerformance() {
        self.measureBlock() {
            
        }
    }
    
}
