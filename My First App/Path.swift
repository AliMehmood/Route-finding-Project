import UIKit

class Path: UIView {

    let graph = Graph()
    var initialX : CGFloat{
        get{
            return self.frame.origin.x + self.frame.width/2 - 103
        }
    }
    var pointA : CGPoint{
        get{
            return CGPoint(x: initialX , y: self.frame.origin.y + self.frame.height)
        }
    }
    var pointC : CGPoint{
        get{
            return CGPoint(x: initialX, y: 460)
        }
    }
    var pointB : CGPoint{
        get{
            return CGPoint(x: initialX - 30, y: 460)
        }
    }

    var pointP : CGPoint{
        get{
            return CGPoint(x: initialX, y: 150)
        }
    }

    var pointQ : CGPoint{
        get{
            return CGPoint(x: initialX, y: 57)
        }
    }

    var pointS: CGPoint{
        get{
            return CGPoint(x: initialX - 62, y: 57)
        }
    }
    var pointR : CGPoint{
        get{
            return CGPoint(x: initialX, y: 0)
        }
    }
    var pointO : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 - 40, y: 150)
        }
    }
    var pointN : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 - 40, y: 110)
        }
    }
    var pointK : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 20, y: 150)
        }
    }
    var pointL : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 20, y: 100)
        }
    }

    var pointM : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 20, y: 0)
        }
    }
    var pointD  : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 20, y: 460)
        }
    }
    var pointE : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 20, y: self.frame.origin.y + self.frame.height)        }
    }
 
    var pointG : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 105, y: 460)
        }
    }
 
    var pointH : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 130, y: 460)
        }
    }
    var pointF  : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 130, y: self.frame.origin.y + self.frame.height)
        }
    }

    var pointI  : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 130, y: 400)
        }
    }

    var pointJ : CGPoint{
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.width/2 + 105, y: 100)
        }
    }
    
    
    var nodeA : Node{
        get{
            return graph.addVertex(key: "A", coordinates: self.pointA)
        }
    }
    var nodeB : Node{
        get{
            return graph.addVertex(key: "B", coordinates: self.pointB)
        }
    }
    var nodeC : Node{
        get{
            return graph.addVertex(key: "C", coordinates: self.pointC)
        }
    }
    var nodeD : Node{
        get{
            return graph.addVertex(key: "D", coordinates: self.pointD)
        }
    }
    var nodeE : Node{
        get{
            return graph.addVertex(key: "E", coordinates: self.pointE)
        }
    }
    var nodeF : Node{
        get{
            return graph.addVertex(key: "F", coordinates: self.pointF)
        }
    }
    var nodeG : Node{
        get{
            return graph.addVertex(key: "G", coordinates: self.pointG)
        }
    }
    var nodeH : Node{
        get{
            return graph.addVertex(key: "H", coordinates: self.pointH)
        }
    }
    var nodeI : Node{
        get{
            return graph.addVertex(key: "I", coordinates: self.pointI)
        }
    }
    var nodeJ : Node{
        get{
            return graph.addVertex(key: "J", coordinates: self.pointJ)
        }
    }
    var nodeK : Node{
        get{
            return graph.addVertex(key: "K", coordinates: self.pointK)
        }
    }
    var nodeL : Node{
        get{
            return graph.addVertex(key: "L", coordinates: self.pointL)
        }
    }
    var nodeM : Node{
        get{
            return graph.addVertex(key: "M", coordinates: self.pointM)
        }
    }
    var nodeN : Node{
        get{
            return graph.addVertex(key: "N", coordinates: self.pointN)
        }
    }
    var nodeO : Node{
        get{
            return graph.addVertex(key: "O", coordinates: self.pointO)
        }
    }
    var nodeP : Node{
        get{
            return graph.addVertex(key: "P", coordinates: self.pointP)
        }
    }
    var nodeQ : Node{
        get{
            return  graph.addVertex(key: "Q", coordinates: self.pointQ)
        }
    }
    var nodeR : Node{
        get{
            return graph.addVertex(key: "R", coordinates: self.pointR)
        }
    }
    var nodeS : Node{
        get{
            return graph.addVertex(key: "G", coordinates: self.pointS)
        }
    }


    
    
    override func draw(_ rect: CGRect) {
        print(#function)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(3.0)
        context?.setStrokeColor(UIColor.purple.cgColor)
        
        let pointsArray = [pointA , pointC, pointB, pointC, pointP, pointQ, pointS, pointQ, pointR, pointQ, pointP
                    , pointO, pointN, pointO, pointK, pointL, pointM, pointD, pointE, pointG, pointH, pointF, pointI, pointH, pointG, pointJ, pointL]
        context?.addLines(between: pointsArray)
        context?.strokePath()
        
        makeGraph()
        
        
        var hungarian  =  Hungarian_Algorithm()
        hungarian.iteration(nodes: nodeA, nodeF, nodeH, nodeM, nodeN)
        
    }
    
    
    func makeGraph()  {
        
        graph.addEdge(source: nodeA, neighbor: nodeC, weight: Path.findDistance(a: pointA, b: pointC))
        graph.addEdge(source: nodeB, neighbor: nodeC, weight: Path.findDistance(a: pointB, b: pointC))
        graph.addEdge(source: nodeC, neighbor: nodeP, weight: Path.findDistance(a: pointC, b: pointP))
        graph.addEdge(source: nodeC, neighbor: nodeD, weight: Path.findDistance(a: pointC, b: pointD))
        graph.addEdge(source: nodeP, neighbor: nodeQ, weight: Path.findDistance(a: pointP, b: pointQ))
        graph.addEdge(source: nodeQ, neighbor: nodeS, weight: Path.findDistance(a: pointQ, b: pointS))
        graph.addEdge(source: nodeQ, neighbor: nodeR, weight: Path.findDistance(a: pointQ, b: pointR))
        graph.addEdge(source: nodeP, neighbor: nodeO, weight: Path.findDistance(a: pointP, b: pointO))
        graph.addEdge(source: nodeD, neighbor: nodeK, weight: Path.findDistance(a: pointD, b: pointK))
        graph.addEdge(source: nodeD, neighbor: nodeE, weight: Path.findDistance(a: pointD, b: pointE))
        graph.addEdge(source: nodeK, neighbor: nodeO, weight: Path.findDistance(a: pointK, b: pointO))
        graph.addEdge(source: nodeK, neighbor: nodeL, weight: Path.findDistance(a: pointK, b: pointL))
        graph.addEdge(source: nodeD, neighbor: nodeG, weight: Path.findDistance(a: pointD, b: pointG))
        graph.addEdge(source: nodeG, neighbor: nodeJ, weight: Path.findDistance(a: pointG, b: pointJ))
        graph.addEdge(source: nodeG, neighbor: nodeH, weight: Path.findDistance(a: pointG, b: pointH))
        graph.addEdge(source: nodeH, neighbor: nodeF, weight: Path.findDistance(a: pointH, b: pointF))
        graph.addEdge(source: nodeH, neighbor: nodeI, weight: Path.findDistance(a: pointH, b: pointI))
        graph.addEdge(source: nodeJ, neighbor: nodeL, weight: Path.findDistance(a: pointJ, b: pointL))
        graph.addEdge(source: nodeL, neighbor: nodeM, weight: Path.findDistance(a: pointL, b: pointM))
        graph.addEdge(source: nodeN, neighbor: nodeO, weight: Path.findDistance(a: pointN, b: pointO))
        
    }
    
    
    
    static func findDistance(a: CGPoint, b: CGPoint) -> Int {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return Int(sqrt((xDist * xDist) + (yDist * yDist)))
    }
}
