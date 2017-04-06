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
    var neighbors: Array<Edge>?             // Edge are associate with a node
    let x: CGFloat!
    let y: CGFloat!
    
    
    init(nodeName: String!, point: CGPoint!) {
        name = nodeName
        self.x =  point.x
        self.y = point.y
        self.neighbors = Array<Edge>()
    }
    
}
