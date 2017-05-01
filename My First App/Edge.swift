//
//  Edge.swift
//  My First App
//
//  Created by Ali Mehmood on 03/04/2017.
//  Copyright © 2017 Ali Mehmood. All rights reserved.
//

import UIKit

class Edge: NSObject {

    var neighbor: Node
    var weight: Int!
    init(w: Int!, endNode: Node) {
        weight = w
        self.neighbor = endNode
    }
}
 
