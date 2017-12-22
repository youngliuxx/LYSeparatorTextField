//
//  LYSeparatorTextFieldTests.swift
//  LYSeparatorTextFieldTests
//
//  Created by youngliuxx on 20/12/2017.
//  Copyright © 2017 youngliuxx. All rights reserved.
//

import XCTest
@testable import LYSeparatorTextField

class LYSeparatorTextFieldTests: XCTestCase {
    
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
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetSeparatorLength() {
        let textField = LYSeparatorTextField.init(frame: CGRect.zero, formatStr: "^^^^-^^-^^")
        textField.text = "2017-12-20"
        
        let result1 = textField.getSeparatorLength(with: 8, sequence: .reverse)
        XCTAssertEqual(result1, 1)

        let result2 = textField.getSeparatorLength(with: 9, sequence: .reverse)
        XCTAssertEqual(result2, 0)
        
        let result3 = textField.getSeparatorLength(with: 5, sequence: .reverse)
        XCTAssertEqual(result3, 1)
        
        let result4 = textField.getSeparatorLength(with: 3, sequence: .foward)
        XCTAssertEqual(result4, 1)
        
        let result5 = textField.getSeparatorLength(with: 3, sequence: .reverse)
        XCTAssertEqual(result5, 0)
        
        let result6 = textField.getSeparatorLength(with: 4, sequence: .reverse)
        XCTAssertEqual(result6, 0)
        
        let textField2 = LYSeparatorTextField.init(frame: CGRect.zero, formatStr: "Day:^^ Month:^^ Year:^^")
        textField2.text = "Day:12 Month:05 Year:2017"
        
        let forwardSeprateLength = textField2.getSeparatorLength(with: 4, sequence: .foward)
        XCTAssertEqual(forwardSeprateLength, 0)
        
        let forwardSeprateLength2 = textField2.getSeparatorLength(with: 5, sequence: .foward)
        XCTAssertEqual(forwardSeprateLength2, 7)
        
        let forwardSeprateLength3 = textField2.getSeparatorLength(with: -1, sequence: .foward)
        XCTAssertEqual(forwardSeprateLength3, 4)
        
        let forwardSeprateLength4 = textField2.getSeparatorLength(with: 4, sequence: .reverse)
        XCTAssertEqual(forwardSeprateLength4, 4)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
