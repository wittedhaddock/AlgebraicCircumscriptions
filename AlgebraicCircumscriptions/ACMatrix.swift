//
//  ACMatrix.swift
//  AlgebraicCircumscriptions
//
//  Created by James William Graham on 8/24/15.
//  Copyright (c) 2015 Circumscribing. All rights reserved.
//

import Foundation

public struct Size {
    public var m: Int! = 0
    public var n: Int! = 0
}

public class ACMatrix : Euclidean, Printable {
    
    private var elements: [[Double]]? = [[Double]]()
    
    public var rows: [ACVector]? = [ACVector]()
    public var columns: [ACVector]? = [ACVector]()
    
//TODO: optimization and permututational testing of size/dimensionality for initializers -- remember to be wary of caches
//Premature optimization is the root of all evil. - DK
    
    public var size: Size = Size()

    public var dimension: Int! {
        get {
            return 0
        }
    }
    
    public init(_ elements: [[Double]]) {
        //row-wise
        self.elements = elements
        updateRowsAndColumnsRepresentation()
    }
    
    public init(_ size: (Int, Int)) {
        for i in 0..<size.0 {
            self.rows?.append(ACVector(size.1))
        }
        updateElementRepresentation()
    }
    
    public init(_ rowVecs: [ACVector]) {
       populateElements(fromRows: rowVecs)
    }
    
    private func populateElements(fromRows rows: [ACVector]) {
        self.elements?.removeAll(keepCapacity: false)
        for i in 0..<rows.count {
            self.elements!.append(rows[i].elementArray!)
        }
        updateRowsAndColumnsRepresentation()
    }
    
    private func updateRowsAndColumnsRepresentation() {
        self.rows = Array(count: self.elements!.count, repeatedValue: ACVector())
        self.columns = Array(count: self.elements!.first!.count, repeatedValue: ACVector(self.elements!.count))
        for i in 0..<self.columns!.count {
            self.columns![i] = ACVector(self.elements!.count); // seems as if Array's count:repeatedValue: passes same repeated value reference
        }
        for i in 0..<self.elements!.count {
            self.rows![i] = ACVector(self.elements![i])
            for j in 0..<self.elements![i].count {
                self.columns![j][i] = self.rows![i][j]
            }
        }
        self.size = Size(m: rows!.count, n: columns!.count)
    }
    
    private func updateElementRepresentation() {
        populateElements(fromRows: self.rows!)
    }
    
    public func transpose() {
        let tempHolder = self.rows;
        self.rows = self.columns;
        self.columns = tempHolder
        updateElementRepresentation()
    }
    
    public func eliminate() {
        //TODO: row exchanges
        
        /*
        -- first we loop through cols, and then rows (starting with a row whose index is the current col)
        then, we determine the factor of an element whose column is the same as the pivot's column, and we do this row by row 
        In each row, we multiply the determined factor with every corresponding row's column entry (resulting in one less calculation each time), 
        and subtract that from each corresponding column entry in the row greater the current (i + 1).
        Assuming nonzero pivots, this element-wise operation makes zero the elements whose indices i or j are both less than j, j (the pivot diagonal)
        While writing this algo, I referred to http://circumscribing.com/creating-zero-from-a-sequence-of-six/
        
        */
        for j in 0..<self.columns!.count {
            if j + 1 >= self.rows!.count {
                break;
            }
            for i in j..<self.rows!.count {
                let factor = self[i + 1][j] / self[j][j]
                for k in j..<self.columns!.count {
                    self[i + 1][k] -= factor * self[j][k]
                }
                if i + 1 >= self.rows!.count - 1 {
                    break
                }
            }
        }
    }
    
    public final subscript(index: Int) -> ACVector {
        get {
            return self.rows![index]
        }
    }
    public var description : String {
        return "\n".join(self.rows!.map {"\($0)"})
    }
}

public func +(left: ACMatrix, right: ACMatrix) -> ACMatrix {
    assert(left.rows!.count == right.rows!.count && left.columns!.count == right.columns!.count, "Summed matricies must have equal sizes. \n\(left) \nunequal to\n\(right)")
    var rowVecs = [ACVector]()
    for i in 0..<left.rows!.count {
        rowVecs.append(left.rows![i] + right.rows![i])
    }
    return ACMatrix(rowVecs)
}

public func *(left: ACMatrix, right: Double) -> ACMatrix {
    var rowVecs = [ACVector]()
    for vec in left.rows! {
        rowVecs.append(vec * right)
    }
    return ACMatrix(rowVecs)
}

public func *(right: Double, left: ACMatrix) -> ACMatrix {
    return left * right
}

public func *(right: ACMatrix, left: ACVector) -> ACVector {
    assert(right.columns!.count == left.dimension, "matrix-vector multiplication must be dimensionally correct")
    var vec = ACVector(right.rows!.count)
    for i in 0..<right.rows!.count {
        vec[i] = right.rows![i] * left
    }
    return vec
}

infix operator == {precedence 130}
public func ==(right: ACMatrix, left: ACMatrix) -> Bool {
    
    if right.size != left.size {
        return false
    }
    
    for (idx, rightRowVec) in enumerate(right.rows!) {
        if (rightRowVec != left.rows![idx]) {
            return false;
        }
    }
    return true;
}

public func *(left: ACMatrix, right: ACMatrix) -> ACMatrix {
    var newMat = ACMatrix((left.size.m, right.size.n))
    for (idxr, rowVec) in enumerate(left.rows!) {
        for (idxc, colVec) in enumerate(right.columns!) {
            newMat[idxr][idxc] = rowVec * colVec;
        }
    }
    return newMat
}

public func != (right: ACMatrix, left: ACMatrix) -> Bool {
    return !(right == left)
}

public func ==(right: Size, left: Size) -> Bool {
    return right.m == left.m && right.n == left.n
}

public func != (right: Size, left: Size) -> Bool {
    return !(right == left)
}
