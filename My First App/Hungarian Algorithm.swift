
import UIKit

class Hungarian_Algorithm: NSObject {
    
    //  var matrix = [[Int]]()
    var nodesRow = [Node]()
    var nodesCol = [Node]()
    
    func iteration(nodes: Node... ) -> [Node]{
         print(#function)
        //        print(nodes)
        nodesRow = nodes
        nodesCol = nodes
        var assignments  = [Node : Node]()
        var nodesArray  = [[Int?]].init(repeating: [Int?].init(repeating: nil, count: nodes.count), count: nodes.count)
        
        for row in 0..<nodes.count{     //fill the matrix with weights
            for col in 0..<nodes.count {
                nodesArray[row][col] = Utility.findDistance(a: CGPoint(x: nodes[row].x, y: nodes[row].y), b: CGPoint(x: nodes[col].x, y: nodes[col].y))
            }
        }
        
        
        for row in 0..<nodes.count{     //fill the diagonals with nil
            nodesArray[row][row] = nil
        }
        
        var d = nodesArray
        var x = 0
        var y = 0
        
        while d.count > 1 {
            d = self.rowMinimization(mat: d)
            d  = self.columnMinimization(mat: d)
            let c = self.Penalty(mat: d)
            print(c)
            ((x,y),d) = strikeOff(mat: d, panelties: c)
            assignments[nodesRow[x]] = nodesCol[y]
            print("Assignment ",nodesRow[x].name, nodesCol[y].name)
            nodesRow.remove(at: x)
            nodesCol.remove(at: y)
            
        }
        assignments[nodesRow.popLast()!] = nodesCol.popLast()
        var sequence = [Node]()
        print("Assignments are \(assignments)")
//        for (key, val) in assignments {
//            if key == nodes.first{
//                sequence.append(key)
//                sequence.append(val)
//                assignments.removeValue(forKey: key)
//                break
//            }
//        }
        for i in 0..<assignments.count {
            
            if i == 0 {
                for (key, val) in assignments {
                    if key == nodes.first{
                        sequence.append(key)
                        sequence.append(val)
                        assignments.removeValue(forKey: key)
                        break
                    }
                }
            }
            else{
                for (key, val) in assignments {
                    if sequence[i] == key{
//                        sequence.append(key)
                        sequence.append(val)
                        assignments.removeValue(forKey: key)
                        break
                    }
                }
            }
            
        }
        
        
        return sequence
    }
    
    
    func rowMinimization(mat: [[Int?]]) -> [[Int?]]{
        var matrix  = mat
        for row in 0..<matrix.count{
            let min = Utility.findMinimum(matrix: matrix[row])
            for col in 0..<matrix.count {
                if matrix[row][col] != nil{
                    matrix[row][col] = matrix[row][col]! - min!
                }
            }
        }
        return matrix
    }
    
    
    func columnMinimization(mat: [[Int?]]) -> [[Int?]]{
        //        print(#function)
        let tr = Utility.transpose(mat: mat)
        let minMat = self.rowMinimization(mat: tr)
        let final  = Utility.transpose(mat: minMat)
        
        return final
        
    }
    
    
    func Penalty(mat: [[Int?]]) -> [CGPoint: Int] {
        //        print(#function)
        typealias mytuple = (row: Int, column: Int)
        var penalties = [CGPoint: Int]()
        var visited = [mytuple]()
        
        for row in 0..<mat.count{
            var min :Int
            var colMat = [Int?]()                                                   //to save the column of the zero
            
            for col in 0..<mat[row].count {
                
                if mat[row][col] == 0 &&                            //select the column no containing 0
                    !Utility.contains(a: visited, v: (row, col)){          //AND also check if zero is already visited or not
                    
                    min = Utility.rowMinimum(rowArray: mat[row],column: col)
                    visited.append((row: row, column: col))
                    
                    for r in 0..<mat.count {
                        colMat.append(mat[r][col])
                    }
                    
                    min += Utility.rowMinimum(rowArray: colMat, column: row)
                    penalties[CGPoint.init(x: row, y: col)] = min
                }
            }
        }
        //        print(mat.count)
        
        return penalties
    }
    
    func strikeOff(mat: [[Int?]], panelties: [CGPoint: Int]) -> ((Int, Int),[[Int?]]) {
        //        print(#function)
        var matrix = mat
        var max =  panelties.values.first
        var points  = panelties.keys.first
        
        for (key,value) in panelties {                  //calculate highest panelty to delete its row & column
            if max! < value  {
                max = value
                points = key
            }
        }
        matrix[Int((points?.y)!)][Int((points?.x)!)] = nil              //if we make assignment from x -> y and we cannot come back y -> x
        matrix.remove(at: Int((points?.x)!))                //remove the row of selected zero
        for row in 0..<matrix.count {
            matrix[Int(row)].remove(at: Int((points?.y)!))               //remove the col of selected zero
        }
        
        
        return ((Int(points!.x), Int(points!.y)), matrix)
    }
    
    
    //MARK: Helping functions
    
}
extension CGPoint: Hashable {
    public var hashValue: Int {
        //This expression can be any of the arbitrary expression which fulfills the axiom above.
        return x.hashValue ^ y.hashValue
    }
}
