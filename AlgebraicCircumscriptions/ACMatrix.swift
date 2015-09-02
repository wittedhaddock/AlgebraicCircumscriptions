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
    private var pivotColCount: Int = 1
    
    public var rows: [ACVector]? = [ACVector]()
    public var columns: [ACVector]? = [ACVector]()
    
//TODO: optimization and permututational testing of size/dimensionality for initializers -- remember to be wary of caches
//Premature optimization is the root of all evil. - DK
    
    public var size: Size = Size()

    public var dimension: Int! {
        //TODO: separate elimation, pivot col determination, and then dimension into class-based invocations
        get {
            if !self.echelonForm {
                self.eliminate()
            }
            if self.echelonForm {
                return self.pivotColCount
            }
            return 0
        }
    }
    
    public var echelonForm: Bool {
        //TODO: optimization: search need not filter all elements
        get {
            for (idxr, row) in enumerate(self.rows!) {
                if idxr < self.rows!.count - 1 && idxr < self.columns!.count - 1{
                    if row[idxr] != 0 {
                        for idxc in idxr + 1..<self.rows!.count {
                            println(row[idxc])
                            if self[idxc][idxr] != 0 {
                                return false
                            }
                        }
                        self.pivotColCount++
                    }
                }
            }
            return true
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
    
    public init(identityOfDimension dimension:  Int) {
        assert(dimension >= 0, "dimension cannot be negative")
        for i in 0..<dimension {
            var rowVec = ACVector(dimension)
            rowVec[i] = 1
            self.rows?.append(rowVec)
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
        ACMatrix.eliminate(self)
    }
    
    public class func eliminate(matrix: ACMatrix)  {
        //TODO: row exchanges
        
        /*
        -- first we loop through cols, and then rows (starting with a row whose index is the current col)
        then, we determine the factor of an element whose column is the same as the pivot's column, and we do this row by row
        In each row, we multiply the determined factor with every corresponding row's column entry (resulting in one less calculation each time),
        and subtract that from each corresponding column entry in the row greater the current (i + 1).
        Assuming nonzero pivots, this element-wise operation makes zero the elements whose indices i or j are both less than j, j (the pivot diagonal)
        While writing this algo, I referred to http://circumscribing.com/creating-zero-from-a-sequence-of-six/
        
        */
        for j in 0..<matrix.columns!.count {
            if j + 1 >= matrix.rows!.count {
                break;
            }
            for i in j..<matrix.rows!.count {
                let factor = matrix[i + 1][j] / matrix[j][j]
                for k in j..<matrix.columns!.count {
                    matrix[i + 1][k] -= factor * matrix[j][k]
                }
                if i + 1 >= matrix.rows!.count - 1 {
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

//column * row = m * m size
public func *(left: ACMatrix, right: ACVector) -> ACMatrix {
    assert(left.columns!.count == 1, "matrix-vector multiplication must be dimensionally correct")
    var mat = ACMatrix((left.rows!.count, right.dimension))
    for (i, rowVec) in enumerate(left.rows!) {
        for (j, colElement) in enumerate(right.elementArray!) {
            mat[i][j] = rowVec[0] * colElement
        }
    }
    return mat
}

//row * column = 1 * 1 size
public func *(left: ACVector, right: ACMatrix) -> ACVector {
    assert(right.columns!.count == 1, "vector-matrix multiplication must be dimensionally correct")
    
    return ACVector([left * right.columns!.first!])
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
