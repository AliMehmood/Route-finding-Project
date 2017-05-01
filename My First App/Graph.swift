//
//  Graph.swift
//  My First App
//
//  Created by Ali Mehmood on 03/04/2017.
//  Copyright © 2017 Ali Mehmood. All rights reserved.
//

import UIKit

class Graph: NSObject {
    

    
//    public var isDirected  = false
    
    //create a new vertex
    func addVertex(key: String, coordinates: CGPoint!, endpoints: CGPoint) -> Node {
        
        //set the key
        let childVertex: Node = Node(nodeName: key, point: coordinates, heuristic: Utility.findDistance(a: coordinates, b: endpoints))
        return childVertex
    }
    
    
    //add an edge to source vertex
    func addEdge(source: Node, neighbor: Node, weight: Int) {
        
        //create a new edge
        let newEdge = Edge(w: weight, endNode: neighbor)
        source.edges?.append(newEdge)
        
        //create a new reversed edge
        let reverseEdge = Edge(w: weight, endNode: source)
        neighbor.edges?.append(reverseEdge)

    }
    
}
