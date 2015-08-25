//
//  MatrixTests.swift
//  AlgebraicCircumscriptions
//
//  Created by James William Graham on 8/24/15.
//  Copyright (c) 2015 Circumscribing. All rights reserved.
//

import UIKit
import XCTest
import AlgebraicCircumscriptions

class MatrixTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testColsAndRowsTransposeForSquareMatrix() {
        var matrix1: ACMatrix = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
        let rowsM1 = matrix1.rows!;
        let colsM1 = matrix1.columns!;
        matrix1.transpose()
        let rowsM1T = matrix1.rows!;
        let colsM1T = matrix1.columns!;
        
        for i in 0..<matrix1.rows!.count {
            if (rowsM1[i] != colsM1T[i] && colsM1[i] != rowsM1T[i]){
                XCTAssert(false, "not equal")
            }
        }
        XCTAssert(true)
    }
    
    func testMatrixAddition() {
        var matrix = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
        var matrix1 = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
        println(matrix + matrix1)
    }
    
    func testMatrixVectorMultiplication() {
        var matrix = ACMatrix([[2, -1, 5], [1, 3, 1]])
        var vector = ACVector([5, 1, 5])
        println(matrix * vector)
    }
}