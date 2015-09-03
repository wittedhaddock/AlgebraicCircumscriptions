//
//  AlgebraicCircumscriptionsTests.swift
//  AlgebraicCircumscriptionsTests
//
//  Created by James William Graham on 8/20/15.
//  Copyright (c) 2015 Circumscribing. All rights reserved.
//

import UIKit
import XCTest
import AlgebraicCircumscriptions

class AlgebraicCircumscriptionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testVectorSubscripting() {
        let firstElement = 1.0
        let thirdElement = 3.0
        var vec: ACVector = ACVector([firstElement,2,thirdElement])
        XCTAssert(vec[0] == firstElement && vec[2] == thirdElement)
    }
    
    func testVectorMagnitude() {
        let vec = ACVector([3.0, 4.0, 5.0])
        vec.normalize()
        println(vec)
        
    }
    
    func testVectorDimensionality() {
        var components = [5.5, M_PI, 2, 10, -10]
        var vec :ACVector = ACVector(components)
        XCTAssert(vec.dimension == components.count)

    }
    
    func testVectorZeroDimensionality() {
        var vec = ACVector();
        XCTAssert(vec.dimension == 0)
    }
    
    func testSquaring() {
        let elements = [1, 2, 3, -10] as [Double]
        var vec = ACVector(elements)
        var squaredElements = elements.map({ (var item) -> Double in
                return item * item
            })
        XCTAssert(vec.magnitude == sqrt(squaredElements.reduce(0, combine: +)))
    }
    
    func testSquaringOnNone() {
        var vec = ACVector([])
        var vec2 = ACVector()
        XCTAssert(vec.magnitude == 0 && vec2.magnitude == 0)
    }
    
    func testVectorAddition() {
        var vec1: ACVector = ACVector([1, 2, 3, 4, 5])
        var vec2 : ACVector = ACVector([1, 2, 3, 4, 5])
        println(vec1 + vec2)
        var vec3 = ACVector(vec1.dimension)
        
        let vecSum : ACVector = (vec1 + vec2)!
        for var i = 0; i < vec1.dimension; i++ {
            vec3[i] = vec1[i] + vec2[i]
            if vec3[i] != vecSum[i] {
                XCTAssert(false, "unequal additions")
            }
        }
    }
    
    func testDotProduct() {
        var vec1: ACVector = ACVector([30, 20, 10]);
        var vec2: ACVector = ACVector([15, 30, 45]);
        println(vec1 * vec2)
        var cumsum: Double = 0
        for i in 0..<vec1.dimension {
            cumsum += vec1[i] * vec2[i] as Double
        }
        XCTAssert(cumsum == vec1 * vec2)
    }
    
    func testScalar() {
        var vec1: ACVector = ACVector([1, 2, 3, 4, 5])
        var vec2: ACVector = ACVector(vec1.dimension)
        let scalar = 4
        for i in 0..<vec1.dimension {
            vec2[i] = vec1[i] * Double(scalar)
        }
        XCTAssert(vec1 * Double(scalar) == vec2)
        
    }
    
    func testNormalization() {
        var vec1: ACVector = ACVector([3, 4, 5])
        vec1.normalize()

        println("vec \(vec1[0]) \(vec1[1]) \(vec1[2]) mag \(vec1.magnitude - 1))")

        XCTAssert(Float(vec1.magnitude) == 1)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
