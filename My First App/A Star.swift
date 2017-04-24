

import UIKit

class A_Star: NSObject {
    
    var openList  = [Node]()
    var closeList = [Node]()
    
    
    func iterate(start: Node, end : Node)  {
        //        start.heuristic =  Utility.findDistance(a: CGPoint(x: start.x, y: start.y), b: CGPoint(x: end.x, y: end.y))
        
        
        start.totalCost = start.heuristic
        var openQueue = [Node]()
        openQueue.append(start)
        var successor_current_cost = 0
        
        
        
        while !openQueue.isEmpty {
            //Take from the open list the node node_current with the lowest f(node_current) = g(node_current) + h(node_current)
            var min  = 0
            for i in 0..<openQueue.count {
                if openQueue[min].heuristic > openQueue[i].heuristic {
                    min = i
                }
            }
            let selectedNode = openQueue[min]
            //if node_current is node_goal we have found the solution; break
            if selectedNode == end{
                break;
            }
            
//            var neighbouringNodes = [Node]()
            
            for edge in selectedNode.edges! {
                successor_current_cost = edge.weight + selectedNode.weight
                
                if openQueue.contains(edge.neighbor) {
                    if edge.weight <= successor_current_cost {
                        continue
                    }
                    
                }
                else{
                    if closeList.contains(edge.neighbor) {
                        if edge.weight <= successor_current_cost {
                            continue
                        }
                        openQueue.append(closeList.remove(at: closeList.index(of: edge.neighbor)!))
                    }
                    else{
                        openQueue.append(edge.neighbor)
//                        edge.neighbor.heuristic = Utility.findDistance(a: CGPoint(x: edge.neighbor.x, y: edge.neighbor.y), b: CGPoint(x: end.x, y: end.y))
                    }
                    edge.neighbor.weight = successor_current_cost
                    
                    
                }
                closeList.append(selectedNode)
            }
//            if selectedNode != end {
//                let alert = UIAlertController(title: "Error", message: "Open list is empty", preferredStyle: .alert)
//                alert.show(alert, sender: nil)
//            }
        }
    }
    
    
}
