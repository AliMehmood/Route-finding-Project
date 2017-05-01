import UIKit

class Path: UIView {

    let graph = Graph()
    var endpoints =  CGPoint()
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
    
    
    var nodeA : Node!
    var nodeB : Node!
    var nodeC : Node!
    var nodeD : Node!
    var nodeE : Node!
    var nodeF : Node!
    var nodeG : Node!
    var nodeH : Node!
    var nodeI : Node!
    var nodeJ : Node!
    var nodeK : Node!
    var nodeL : Node!
    var nodeM : Node!
    var nodeN : Node!
    var nodeO : Node!
    var nodeP : Node!
    var nodeQ : Node!
    var nodeR : Node!
    var nodeS : Node!
    

    
    
    override func draw(_ rect: CGRect) {
//        print(#function)
        
//        let arr :Array<Node> = []
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(3.0)
        context?.setStrokeColor(UIColor.blue.cgColor)
        
        var pointsArray: [CGPoint] = []
        
        
        
        initializeNodes()
        makeGraph()
        
        print(#function)
        let hungarian  =  Hungarian_Algorithm()
        var sequence = hungarian.iteration(nodes: nodeK, nodeH, nodeD, nodeJ)
        sequence.removeLast()
        
        
//        let array : Array<Node> = [self.nodeA,self.nodeB, self.nodeC, self.nodeD, self.nodeE, self.nodeF, self.nodeG, self.nodeH, self.nodeI, self.nodeJ,self.nodeK, self.nodeL, self.nodeM,self.nodeN, self.nodeP, self.nodeQ, self.nodeR, self.nodeS]
//        
        var count = 0
        for i in 0..<sequence.count-1{
            count += 1
            var label = UILabel(frame: CGRect(origin: CGPoint(x: sequence[i].x-10, y: sequence[i].y), size: CGSize(width: 20, height: 20)))
            if sequence[i].name == "A" || sequence[i].name == "F"{
                label = UILabel(frame: CGRect(origin: CGPoint(x: sequence[i].x-10, y: sequence[i].y-90), size: CGSize(width: 20, height: 20)))
            }
            label.textColor =  UIColor.black
            label.text = String(i+1)
            self.addSubview(label)
            let aStar = A_Star()
            self.endpoints = CGPoint(x: sequence[i+1].x, y: sequence[i+1].y)            //  har baar heuristic change hoga q k destiny change hogi
            let array = initializeNodes()                                                           // value of node would be change bcz heuristic will be change
            makeGraph()
            
            //seeking for the recomputed start and end node with new heuristic
            var start : Node!
            for node in array{
                if sequence[i].name == node.name{
                    start  = node
                    break
                }
            }
            var end : Node!
            for node in array{
                if sequence[i+1].name == node.name{
                    end = node
                    break
                }
            }
            let closeQueue = aStar.iterate(start: start, end: end)      //Path between two nodes is obtained here
            
            for node in closeQueue {
                pointsArray.append(CGPoint(x: node.x, y: node.y))
            }
            //            context?.addLines(between: closeQueue)
            
        }
        let lastNode = sequence.removeLast()
        var label = UILabel(frame: CGRect(origin: CGPoint(x: lastNode.x-10, y: lastNode.y), size: CGSize(width: 20, height: 20)))
        if lastNode.name == "A" || lastNode.name == "F"{
            label = UILabel(frame: CGRect(origin: CGPoint(x: lastNode.x-10, y: lastNode.y-90), size: CGSize(width: 20, height: 20)))
        }
        label.textColor =  UIColor.black
        label.text = String(count+1)
        self.addSubview(label)

        pointsArray.append(CGPoint(x: lastNode.x, y: lastNode.y))
        context?.addLines(between: pointsArray)
        context?.strokePath()

        
        
        
        
        
    }
    
    
    
    func initializeNodes() -> Array<Node> {
        self.nodeA = graph.addVertex(key: "A", coordinates: self.pointA, endpoints: endpoints)
        nodeB = graph.addVertex(key: "B", coordinates: self.pointB, endpoints: endpoints)
        nodeC = graph.addVertex(key: "C", coordinates: self.pointC , endpoints: endpoints)
        nodeD = graph.addVertex(key: "D", coordinates: self.pointD, endpoints: endpoints)
        nodeE = graph.addVertex(key: "E", coordinates: self.pointE, endpoints: endpoints)
        nodeF = graph.addVertex(key: "F", coordinates: self.pointF, endpoints: endpoints)
        nodeG = graph.addVertex(key: "G", coordinates: self.pointG, endpoints: endpoints)
        nodeH = graph.addVertex(key: "H", coordinates: self.pointH, endpoints: endpoints)
        nodeI = graph.addVertex(key: "I", coordinates: self.pointI, endpoints: endpoints)
        nodeJ = graph.addVertex(key: "J", coordinates: self.pointJ, endpoints: endpoints)
        nodeK = graph.addVertex(key: "K", coordinates: self.pointK, endpoints: endpoints)
        nodeL = graph.addVertex(key: "L", coordinates: self.pointL, endpoints: endpoints)
        nodeM = graph.addVertex(key: "M", coordinates: self.pointM, endpoints: endpoints)
        nodeN = graph.addVertex(key: "N", coordinates: self.pointN, endpoints: endpoints)
        nodeO = graph.addVertex(key: "O", coordinates: self.pointO, endpoints: endpoints)
        nodeP = graph.addVertex(key: "P", coordinates: self.pointP, endpoints: endpoints)
        nodeQ = graph.addVertex(key: "Q", coordinates: self.pointQ, endpoints: endpoints)
        nodeR = graph.addVertex(key: "R", coordinates: self.pointR, endpoints: endpoints)
        nodeS = graph.addVertex(key: "G", coordinates: self.pointS, endpoints: endpoints)
        
        let array : Array<Node> = [nodeA,nodeB, nodeC, nodeD, nodeE, nodeF, nodeG, nodeH, nodeI, nodeJ,nodeK, nodeL, nodeM,nodeN, nodeP, nodeQ, nodeR, nodeS]
        return array
    }
    
    
    func makeGraph()  {
        
        graph.addEdge(source: nodeA, neighbor: nodeC, weight: Utility.findDistance(a: pointA, b: pointC))
        graph.addEdge(source: nodeB, neighbor: nodeC, weight: Utility.findDistance(a: pointB, b: pointC))
        graph.addEdge(source: nodeC, neighbor: nodeP, weight: Utility.findDistance(a: pointC, b: pointP))
        graph.addEdge(source: nodeC, neighbor: nodeD, weight: Utility.findDistance(a: pointC, b: pointD))
        graph.addEdge(source: nodeP, neighbor: nodeQ, weight: Utility.findDistance(a: pointP, b: pointQ))
        graph.addEdge(source: nodeQ, neighbor: nodeS, weight: Utility.findDistance(a: pointQ, b: pointS))
        graph.addEdge(source: nodeQ, neighbor: nodeR, weight: Utility.findDistance(a: pointQ, b: pointR))
        graph.addEdge(source: nodeP, neighbor: nodeO, weight: Utility.findDistance(a: pointP, b: pointO))
        graph.addEdge(source: nodeD, neighbor: nodeK, weight: Utility.findDistance(a: pointD, b: pointK))
        graph.addEdge(source: nodeD, neighbor: nodeE, weight: Utility.findDistance(a: pointD, b: pointE))
        graph.addEdge(source: nodeK, neighbor: nodeO, weight: Utility.findDistance(a: pointK, b: pointO))
        graph.addEdge(source: nodeK, neighbor: nodeL, weight: Utility.findDistance(a: pointK, b: pointL))
        graph.addEdge(source: nodeD, neighbor: nodeG, weight: Utility.findDistance(a: pointD, b: pointG))
        graph.addEdge(source: nodeG, neighbor: nodeJ, weight: Utility.findDistance(a: pointG, b: pointJ))
        graph.addEdge(source: nodeG, neighbor: nodeH, weight: Utility.findDistance(a: pointG, b: pointH))
        graph.addEdge(source: nodeH, neighbor: nodeF, weight: Utility.findDistance(a: pointH, b: pointF))
        graph.addEdge(source: nodeH, neighbor: nodeI, weight: Utility.findDistance(a: pointH, b: pointI))
        graph.addEdge(source: nodeJ, neighbor: nodeL, weight: Utility.findDistance(a: pointJ, b: pointL))
        graph.addEdge(source: nodeL, neighbor: nodeM, weight: Utility.findDistance(a: pointL, b: pointM))
        graph.addEdge(source: nodeN, neighbor: nodeO, weight: Utility.findDistance(a: pointN, b: pointO))
    }
    
    
    
    
    
}
