//
//  ACVector.swift
//  AlgebraicCircumscriptions
//
//  Created by James William Graham on 8/20/15.
//  Copyright (c) 2015 Circumscribing. All rights reserved.
//

import Foundation

public protocol VectorDataSource {
    func elementValueChanged(#sender:ACVector, indexOfChange index:Int, newElementValue val: Double)
}

public class ACVector: Euclidean, Printable {
    private var elements: [Double]? = [Double]()
    
    public var dataSource: VectorDataSource?
    
    public var elementArray: [Double]? {
        get {
            return self.elements
        }
    }

    public var dimension: Int! {
        get {
            if self.elements != nil {
                return self.elements!.count
            }
            else {
                return 0
            }
        }
    }
    
    private var elementsSquared: [Double]? {
        get {
            return self.elements?.map({ (var item) -> Double in
                return item * item
            })
        }
    }
    
    public var magnitude: Double! {
        get {
            if self.elements == nil {
                return 0
            } 
            else {
                return sqrt(self.elementsSquared!.reduce(0, combine: +))
            }
        }
        set (newValue){
            self.normalize()
            for i in 0..<self.dimension {
                self[i] = self[i] * newValue
            }
        }
    }
    
    public init (_ elementsToComposeVector: [Double]) {
        self.elements = elementsToComposeVector
    }
    
    public init (_ dimensionOfEmptyVector: Int) {
        self.elements = [Double](count: dimensionOfEmptyVector, repeatedValue: 0)
    }
    public init() {}
    
    // change double to dynamic type of elements
    final public subscript(index: Int) -> Double {
        get {
            return self.elements![index]
        }
        
        set(newValue){
            self.dataSource?.elementValueChanged(sender: self, indexOfChange: index, newElementValue: newValue)
            self.elements![index] = newValue
        }
    }
    
    public func normalize () {
        let immunitableMagnitude = self.magnitude
        for i in 0..<self.dimension {
            self[i] /= immunitableMagnitude
        }
    }
    
     public var description: String {
        return "\(self.elements!)"
    }
}

public func +(left: ACVector, right: ACVector) -> ACVector! {
    var newVec: ACVector = ACVector(left.dimension)
    for var i = 0; i < left.dimension; i++ {
        newVec[i] = left[i] + right[i]
    }
    return newVec
}

public func *(left: ACVector, right: ACVector) -> Double! {
    var summedComponents = [Double](count: left.dimension, repeatedValue: 0)
    for var i = 0; i < left.dimension; i++ {
        summedComponents[i] = left[i] * right[i]
    }
    return summedComponents.reduce(0, combine: +)
}

public func *(left: ACVector, right: Double) -> ACVector! {
    var vec: ACVector = ACVector(left.dimension)
    for i in 0..<vec.dimension {
        vec[i] = left[i] * right
    }
    return vec
}

public func *(left: Double, right: ACVector) -> ACVector! {
    return right * left
}

public func /(left: ACVector, right: Double) -> ACVector! {
    return left * (1.0/right)
}

public func ==(left: ACVector, right: ACVector) -> Bool {
    if left.dimension! != right.dimension! {
        return false
    }
    for i in 0..<left.dimension {
        if left[i] != right[i] {
            return false
        }
    }
    return true
}

public func !=(left: ACVector, right: ACVector) -> Bool{
    return !(left == right)
}

