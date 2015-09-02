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
        var matrix1: ACMatrix = ACMatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        
        println(matrix1)
        matrix1.transpose()
        println(matrix1)
        
        let rowsM1 = matrix1.rows!;
        let colsM1 = matrix1.columns!;
        matrix1.transpose()
        let rowsM1T = matrix1.rows!;
        let colsM1T = matrix1.columns!;
        
        for i in 0..<matrix1.rows!.count {
            if (rowsM1[i] != colsM1T[i] || colsM1[i] != rowsM1T[i]){
                XCTAssert(false, "not equal")
            }
        }
        XCTAssert(true)
    }
    
    func testMatrixEquality() {
        let mat1 = ACMatrix([[10, -10, 20], [90, 100, 30]]);
        let mat2 = mat1
        for i in 0..<mat1.rows!.count {
            for j in 0..<mat1.columns!.count {
                if mat1[i][j] != mat2[i][j] {
                    XCTAssert(false, "\(mat1) not equal to \(mat2)!");
                }
            }
        }
        XCTAssert(true, "matrices are equal")
    }
    
    func testMatrixInequality() {
        let mat1 = ACMatrix([[10, 20]])
        let mat2 = ACMatrix([[10], [20]])
        let mat3 = ACMatrix([[10, 10, 20], [20, 10, 10]])
        let mat4 = ACMatrix([[11, 10, 20], [20, 10, 11]])
        let matArr = [mat1, mat2, mat3, mat4]
        for (idx, i) in enumerate(matArr) {
            for (idx2, j) in enumerate(matArr) {
                if i == j && idx != idx2{
                    XCTAssert(false, "all matrices should be unequal!, failed with \(i) and \(j)")
                }
            }
        }
        XCTAssert(true, "all unequal matrices represented as such")
    }
    
    func testMatrixSizeEqual() {
        let matrix = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
        XCTAssert(matrix.size.m == matrix.size.n)
    }
    
    func testMatrixSizeUnequal() {
        let matrix = ACMatrix([[1, 2, 3, 4], [1, 2, 3, 4]])
        let matSize = matrix.size
        matrix.transpose()
        let matTSize = matrix.size
        XCTAssert(matSize.m == matTSize.n && matSize.n == matTSize.m, "transposed dimensions of \(matrix) should be reversely equal!")
    }
    
    func testMatrixSubscript() {
        let firstVal = 1 as Double
        let secondVal = 2 as Double
        let matrix = ACMatrix([[firstVal, 2, 3, 4], [1, secondVal, 3, 4]])
        XCTAssert(matrix[0][0] == firstVal && matrix[1][1] == secondVal)
    }
    
    func testMatrixAddition() {
        let matrix = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
        let matrix1 = ACMatrix([[1, 2, 3], [2, 3, 4], [5, 6, 7]])
        
        println(matrix + matrix1)
        var vecArray = [ACVector]();
        for (idx, vecOfMat) in enumerate(matrix.rows!) {
            vecArray.append(matrix1.rows![idx] + vecOfMat)
        }
        XCTAssert(ACMatrix(vecArray) == matrix + matrix1, "alert")
    }
    
    func testEliminate(){
        let matrix = ACMatrix([[40, 50, 60, -200, 101],
                               [39, 50, 60, -200, 101],
                               [1, 3, 9, 10, 11],
                               [90, 10, -30, 33, 34],
                               [100, 1, -9, 3, 4]])
        
        println(matrix)
        matrix.eliminate()
        println(matrix)
    }
    
    func testEchelonForm() {
        let matrix = ACMatrix([[50, 50, 60, -200, 101], [39, 50, 60, -200, 101]])
        let mat1Ech = matrix.echelonForm
        matrix.eliminate()
        let mat2Ech = matrix.echelonForm
        println(matrix.echelonForm)

        XCTAssert(!mat1Ech && mat2Ech)
    }
    
    func testIdentityMatrix() {
        let mat4ID = ACMatrix(identityOfDimension: 4)
        for i in 0..<mat4ID.rows!.count {
            if mat4ID[i][i] != 1 {
                XCTAssert(false, "\(mat4ID) not an identity matrix")
            }
        }
        XCTAssert(true)
    }
    
    func testMatrixDimension(){
        let matrix = ACMatrix([[10, 20, 30]])
        let matrix2 = ACMatrix ([[2, 3, 4], [7, 6, 13]])
        XCTAssert(matrix.dimension == 1 && matrix2.dimension == 2)
    }
    
    func testMatrixVectorMultiplication() {
        var matrix = ACMatrix([[2], [-1], [5]])
        var vector = ACVector([5, 1, 5])
        println(matrix * vector)
        println(vector * matrix)
    }
    
    func testMatrixMatrixMultiplication() {
        var mat = ACMatrix([[1, 2, 3], [2, 3, 4]])
        var mat2 = ACMatrix([[1, 2], [2, 3], [3, 4]])
        println(mat * mat2)
        println("\n")
        println(mat2 * mat)
        let matMat2 = ACMatrix([[14, 20], [20, 29]])
        let mat2Mat = ACMatrix([[5, 8, 11], [8, 13, 18], [11, 18, 25]])
        XCTAssert(mat * mat2 == matMat2 && mat2 * mat == mat2Mat)
    }
    
}