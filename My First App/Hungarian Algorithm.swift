
import UIKit

class Hungarian_Algorithm: NSObject {

    var matrix = [[Int]]()
    
    
    init(nodes: Node... ) {
        super.init()
        print(nodes)
        var nodesArray  = [[Int?]].init(repeating: [Int?].init(repeating: nil, count: nodes.count), count: nodes.count)
        
        for row in 0..<nodes.count{     //fill the matrix with weights
            for col in 0..<nodes.count {
                nodesArray[row][col] = Path.findDistance(a: CGPoint(x: nodes[row].x, y: nodes[row].y), b: CGPoint(x: nodes[col].x, y: nodes[col].y))
            }
        }
        for row in 0..<nodes.count{     //fill the diagonals with nil
            nodesArray[row][row] = nil
        }
        print(nodesArray)
        var a = self.rowMinimization(mat: nodesArray)
        print("booyah!!")
        print(a)
    }
    
    func findMinimum(matrix:[Int?]) -> Int {
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
        //}
        return matrix[min]!
    }
    
    
    func rowMinimization(mat: [[Int?]]) -> [[Int?]]{
        var matrix  = mat
        for row in 0..<matrix.count{
            let min = findMinimum(matrix: matrix[row])
            for col in 0..<matrix.count {
                if matrix[row][col] != nil{
                    matrix[row][col] = matrix[row][col]! - min
                }
            }
        }
//        print(matrix)
        return matrix
        
    }
    
    func transpose(mat: [[Int?]]) -> [[Int?]] {
        var transpose = [[Int?]]()
        for row in 0..<matrix.count{
            for col in 0..<matrix[row].count {
                transpose[col][row] = matrix[row][col]
            }
        }
        print("transpose")
        print(transpose)
        return transpose
    }
    
    func columnMinimization(mat: [[Int?]]) -> [[Int?]]{
        
        let tr = self.transpose(mat: mat)
        let minMat = self.rowMinimization(mat: tr)
        let final  = self.transpose(mat: minMat)
        
        return final
        
    }

    
}
