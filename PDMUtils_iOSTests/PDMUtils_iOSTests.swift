//
//  PDMUtils_iOSTests.swift
//  PDMUtils_iOSTests
//
//  Created by Pedro L. Diaz Montilla on 16/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import XCTest
@testable import PDMUtils_iOS

class PDMUtils_iOSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testPDMString() {
		var myString: String
		
		// Subscript
		myString = "ABCDEF"
		XCTAssertEqual(myString[2], "C")
		XCTAssertNotEqual(myString[2], "X")
		XCTAssertNil(myString[20])
		XCTAssertNil(myString[-1])
		
		// String.isNumeric()
		XCTAssertTrue("1234567890".pdmIsNumeric())
		XCTAssertFalse("1234567890a".pdmIsNumeric())
		
		// String.isHexadecimal()
		XCTAssertTrue("1234567890ABCDEF".pdmIsHexadecimal())
		XCTAssertFalse("1234567890ABCDEFJ".pdmIsHexadecimal())
		
		// String.isOctal()
		XCTAssertTrue("12345670".pdmIsOctal())
		XCTAssertFalse("12345670a".pdmIsOctal())
		
		// String.toInt()
		XCTAssertEqual("1234".pdmToInt(), 1234)
		XCTAssertNotEqual("1234".pdmToInt(), 123)
		XCTAssertNil("1234a".pdmToInt())
		
		// String.substring()
		XCTAssertEqual("0123456789".pdmSubstring(fromIndex: 2, numberOfCharacters: 2), "23")
		XCTAssertNil("0123456789".pdmSubstring(fromIndex: -1, numberOfCharacters: 1))
		XCTAssertNil("0123456789".pdmSubstring(fromIndex: 10, numberOfCharacters: 1))
		XCTAssertNil("0123456789".pdmSubstring(fromIndex: 1, numberOfCharacters: -1))
		XCTAssertNil("0123456789".pdmSubstring(fromIndex: 0, numberOfCharacters: 11))
		XCTAssertNil("0123456789".pdmSubstring(fromIndex: 8, numberOfCharacters: 3))
		
	}
    

     
}
