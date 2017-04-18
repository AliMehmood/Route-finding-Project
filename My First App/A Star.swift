

import UIKit

class A_Star: NSObject {
    
    var openList  = [Node]()
    var closeList = [Node]()
    
    func iterate(start: Node, end : Node)  {
        start.heuristic =  Utility.findDistance(a: CGPoint(x: start.x, y: start.y), b: CGPoint(x: end.x, y: end.y))
        var weight = 0
        
        start.f_n = start.heuristic + weight
        var openQueue = [Node]()
        openQueue.append(start)
     
        while !openQueue.isEmpty {
            
        }
    }
    
    
}
