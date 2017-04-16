
import UIKit

class Hungarian_Algorithm: NSObject {
    
    //  var matrix = [[Int]]()
    var nodesRow = [Node]()
    var nodesCol = [Node]()
    
    func iteration(nodes: Node... ) -> Void{
//        print(nodes)
        nodesRow = nodes
        nodesCol = nodes
        var assignments  = [Node : Node]()
        var nodesArray  = [[Int?]].init(repeating: [Int?].init(repeating: nil, count: nodes.count), count: nodes.count)
        
        for row in 0..<nodes.count{     //fill the matrix with weights
            for col in 0..<nodes.count {
                nodesArray[row][col] = Path.findDistance(a: CGPoint(x: nodes[row].x, y: nodes[row].y), b: CGPoint(x: nodes[col].x, y: nodes[col].y))
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
        
        print("Assignments are \(assignments)")
    }
    
    
    func rowMinimization(mat: [[Int?]]) -> [[Int?]]{
        var matrix  = mat
        for row in 0..<matrix.count{
            let min = findMinimum(matrix: matrix[row])
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
        let tr = self.transpose(mat: mat)
        let minMat = self.rowMinimization(mat: tr)
        let final  = self.transpose(mat: minMat)
        
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
                    !self.contains(a: visited, v: (row, col)){          //AND also check if zero is already visited or not
                    
                    min = self.rowMinimum(rowArray: mat[row],column: col)
                    visited.append((row: row, column: col))
                    
                    for r in 0..<mat.count {
                        colMat.append(mat[r][col])
                    }
                    
                    min += self.rowMinimum(rowArray: colMat, column: row)
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
    
    
    func checkZero(matrix: [[Int?]]) -> Bool {
        var mat = matrix
        var count = 0
        for row in 0..<mat.count{
            
            for col in 0..<mat[row].count {
                if mat[row][col] == 0{
                    count += 1
                }
            }
            if count == 0{
                let min = findMinimum(matrix: mat[row])
                for col in 0..<mat.count {
                    if mat[row][col] != nil{
                        mat[row][col] = mat[row][col]! - min!
                    }
                }
            }
        }
        return true
    }
    
    
    //MARK: Helping functions
    func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
        let (c1, c2) = v
        for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
        return false
    }
    
    
    func rowMinimum(rowArray : [Int?], column: Int) -> Int {
        var min: Int = 0
        
        for i in 0..<rowArray.count{                    //initally set minimum
            if rowArray[i] != nil{
                min = i
                break
            }
        }
        for col in min..<rowArray.count{
            if rowArray[col] != nil && col != column {
                if rowArray[col]! < rowArray[min]! {
                    min = col                   //minimum value of row but not nil
                }
            }
        }
        return rowArray[min]!
    }
    
    func transpose(mat: [[Int?]]) -> [[Int?]] {
        var transpose = [[Int?]]()
        for row in 0..<mat.count{
            var rowArray = [Int?]()
            for col in 0..<mat[row].count {
                rowArray.append(mat[col][row])
            }
            transpose.append(rowArray)
        }
        return transpose
    }
    
    
    func findMinimum(matrix:[Int?]) -> Int? {
        var min: Int
        //for row in 0..<matrix.count{
        if matrix[0] != nil{
            min  = 0
        }
        else{
            min = 1
        }
        for col in 0..<matrix.count{
            if matrix[col] != nil && matrix[col]! < matrix[min]!{
                min = col                   //minimum value of row but not nil
            }
        }
        return matrix[min]
    }
    
}
extension CGPoint: Hashable {
    public var hashValue: Int {
        //This expression can be any of the arbitrary expression which fulfills the axiom above.
        return x.hashValue ^ y.hashValue
    }
}
