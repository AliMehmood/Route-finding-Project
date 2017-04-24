//
//  Node.swift
//  My First App
//
//  Created by Ali Mehmood on 03/04/2017.
//  Copyright © 2017 Ali Mehmood. All rights reserved.
//

import UIKit

class Node: NSObject {

    var name: String!
    var edges: Array<Edge>?             // Edges associate with a node
    let x: CGFloat!
    let y: CGFloat!
    var heuristic = 0

    var weight: Int!
    var totalCost: Int!
    
    
    init(nodeName: String!, point: CGPoint!) {
        name = nodeName
        self.x =  point.x
        self.y = point.y
        self.edges = Array<Edge>()
    }
    
    
    func heuristicCalculate(end: Node) -> Int {
        return Utility.findDistance(a: CGPoint(x: self.x, y: self.y), b: CGPoint(x: end.x, y: end.y))
    }
    
}
