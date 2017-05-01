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
    
    
    init(nodeName: String!, point: CGPoint!, heuristic: Int) {
        name = nodeName
        self.x =  point.x
        self.y = point.y
        self.heuristic = heuristic
        self.edges = Array<Edge>()
    }
    
    
        
}
