//
//  ACMatrix.swift
//  AlgebraicCircumscriptions
//
//  Created by James William Graham on 8/24/15.
//  Copyright (c) 2015 Circumscribing. All rights reserved.
//

import Foundation

public class ACMatrix : Euclidean {
    
    private var elements: [[Double]]? = [[Double]]()

    public var dimension: Int! {
        get {
            return 0
        }
    }
    
    public init() {}
    
    public init(_ elements: [[Double]]) {
        self.elements = elements
    }
    
}