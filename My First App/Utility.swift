//
//  Utility.swift
//  My First App
//
//  Created by Ali Mehmood on 16/04/2017.
//  Copyright © 2017 Ali Mehmood. All rights reserved.
//

import Foundation
import UIKit
class Utility{
    static func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
        let (c1, c2) = v
        for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
        return false
    }
    
    
    static func rowMinimum(rowArray : [Int?], column: Int) -> Int {
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
    
    static func transpose(mat: [[Int?]]) -> [[Int?]] {
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
    
    
    static func findMinimum(matrix:[Int?]) -> Int? {
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

    
    
    static func findDistance(a: CGPoint, b: CGPoint) -> Int {
        let xDist = a.x - b.x
//        print(xDist)
        let yDist = a.y - b.y
//        print(Int(sqrt((xDist * xDist) + (yDist * yDist))))
        return Int(sqrt((xDist * xDist) + (yDist * yDist)))
    }
}
