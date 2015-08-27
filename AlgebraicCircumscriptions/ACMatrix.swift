//
//  ACMatrix.swift
//  AlgebraicCircumscriptions
//
//  Created by James William Graham on 8/24/15.
//  Copyright (c) 2015 Circumscribing. All rights reserved.
//

import Foundation

public struct Size {
    var m: Int! = 0
    var n: Int! = 0
}

public class ACMatrix : Euclidean, Printable {
    
    private var elements: [[Double]]? = [[Double]]()
    
    public var rows: [ACVector]? = [ACVector]()
    public var columns: [ACVector]? = [ACVector]()
    

    
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
    
    public init(_ rowVecs: [ACVector]) {
        for i in 0..<rowVecs.count {
            self.elements!.append(rowVecs[i].elementArray!)
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
    
    public func transpose() {
        let tempHolder = self.rows;
        self.rows = self.columns;
        self.columns = tempHolder
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

public func != (right: ACMatrix, left: ACMatrix) -> Bool {
    return !(right == left)
}

public func ==(right: Size, left: Size) -> Bool {
    return right.m == left.m && right.n == left.n
}

public func != (right: Size, left: Size) -> Bool {
    return !(right == left)
}