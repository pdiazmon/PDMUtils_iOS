//
//  PDMUtils_JavaIntegerTests.swift
//  PDMUtils_iOSTests
//
//  Created by Pedro L. Diaz Montilla on 18/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import XCTest
@testable import PDMUtils_iOS

class PDMUtils_JavaIntegerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIntegerJava() {
        
        // Int.compare()
        XCTAssertEqual(Int.java_compare​(x: 2, y: 2), 0)
        XCTAssertLessThan(Int.java_compare​(x: 2, y: 3), 0)
        XCTAssertGreaterThan(Int.java_compare​(x: 3, y: 2), 0)
        
        // Int.compareTo()
        var myInt = Int(2)
        XCTAssertEqual(myInt.java_compareTo​(2), 0)
        XCTAssertLessThan(myInt.java_compareTo​(3), 0)
        XCTAssertGreaterThan(myInt.java_compareTo​(1), 0)
        
        // Int.compareUnsigned()
        XCTAssertEqual(Int.java_compareUnsigned​(x: -2, y: -2), 0)
        XCTAssertLessThan(Int.java_compareUnsigned​(x: -2, y: -3), 0)
        XCTAssertLessThan(Int.java_compareUnsigned​(x: -2, y: 3), 0)
        XCTAssertLessThan(Int.java_compareUnsigned​(x: 2, y: -3), 0)
        XCTAssertLessThan(Int.java_compareUnsigned​(x: 2, y: 3), 0)
        XCTAssertGreaterThan(Int.java_compareUnsigned​(x: -3, y: -2), 0)
        XCTAssertGreaterThan(Int.java_compareUnsigned​(x: -3, y: 2), 0)
        XCTAssertGreaterThan(Int.java_compareUnsigned​(x: 3, y: -2), 0)
        XCTAssertGreaterThan(Int.java_compareUnsigned​(x: 3, y: 2), 0)
        
        // Int.decode()
        try XCTAssertEqual(Int.java_decode​("0xF"), 15)
        try XCTAssertEqual(Int.java_decode​("0XF"), 15)
        try XCTAssertEqual(Int.java_decode​("+0xF"), 15)
        try XCTAssertEqual(Int.java_decode​("-0xF"), -15)
        try XCTAssertEqual(Int.java_decode​("#15"), 13)
        try XCTAssertEqual(Int.java_decode​("+#15"), 13)
        try XCTAssertEqual(Int.java_decode​("-#15"), -13)
        try XCTAssertEqual(Int.java_decode​("15"), 15)
        try XCTAssertEqual(Int.java_decode​("-15"), -15)
        try XCTAssertThrowsError(Int.java_decode​("0xT"))
        try XCTAssertThrowsError(Int.java_decode​("-0xT"))
        try XCTAssertThrowsError(Int.java_decode​("#19"))
        try XCTAssertThrowsError(Int.java_decode​("-#19"))
        try XCTAssertThrowsError(Int.java_decode​("1W"))
        try XCTAssertThrowsError(Int.java_decode​("-1W"))
        
        // Int.divideUnsigned​()
        try XCTAssertEqual(Int.java_divideUnsigned​(dividend: 10, divisor: 2), 5)
        try XCTAssertEqual(Int.java_divideUnsigned​(dividend: 10, divisor: -2), 5)
        try XCTAssertEqual(Int.java_divideUnsigned​(dividend: -10, divisor: 2), 5)
        try XCTAssertThrowsError(Int.java_divideUnsigned​(dividend: 10, divisor: 0))
        
        // Int.doubleValue()
        myInt = 2
        XCTAssertEqual(myInt.java_doubleValue​(), 2.0)
        myInt = -2
        XCTAssertEqual(myInt.java_doubleValue​(), -2.0)
        myInt = 0
        XCTAssertEqual(myInt.java_doubleValue​(), 0.0)
        
        // Int.equals()
        myInt = 2
        XCTAssertTrue(myInt.java_equals​(Int(2)))
        XCTAssertTrue(myInt.java_equals​(Double("2.0")!))
        XCTAssertTrue(myInt.java_equals​(Float("2.0")!))
        XCTAssertTrue(myInt.java_equals​("2"))
        XCTAssertFalse(myInt.java_equals​(Int(1)))
        XCTAssertFalse(myInt.java_equals​(Double("1.0")!))
        XCTAssertFalse(myInt.java_equals​(Float("1.0")!))
        XCTAssertFalse(myInt.java_equals​("1"))
        XCTAssertFalse(myInt.java_equals​("foo"))
        
        // Int.floatValue()
        myInt = 2
        XCTAssertEqual(myInt.java_floatValue​(), Float("2.0"))
        XCTAssertNotEqual(myInt.java_floatValue​(), Float("1.0"))
        
        // Int.hashCode()
        myInt = 2
        XCTAssertEqual(myInt.java_hashCode​(), Int.java_hashCode​(myInt))
        
        // Int.max()
        XCTAssertEqual(Int.java_max​(2, 3), 3)
        XCTAssertNotEqual(Int.java_max​(2, 3), 2)
        
        // Int.min()
        XCTAssertEqual(Int.java_min​(2, 3), 2)
        XCTAssertNotEqual(Int.java_min​(2, 3), 3)
        
        // Int.parseInt()
        try XCTAssertEqual(Int.java_parseInt​(s: "abc+1234def", beginIndex: 3, endIndex: 6, radix: 10), 123)
        try XCTAssertEqual(Int.java_parseInt​(s: "abc-1234def", beginIndex: 3, endIndex: 6, radix: 10), -123)
        try XCTAssertNotEqual(Int.java_parseInt​(s: "abc+1234def", beginIndex: 3, endIndex: 6, radix: 10), 1234)
        try XCTAssertThrowsError(Int.java_parseInt​(s: "abc+1234def", beginIndex: 2, endIndex: 6, radix: 10))
        try XCTAssertThrowsError(Int.java_parseInt​(s: "abc+1234def", beginIndex: 3, endIndex: 10, radix: 10))
        try XCTAssertNil(Int.java_parseInt​(s: "abc+1234def", beginIndex: -1, endIndex: 6, radix: 10))
        try XCTAssertNil(Int.java_parseInt​(s: "abc+1234def", beginIndex: 1, endIndex: -6, radix: 10))
        try XCTAssertNil(Int.java_parseInt​(s: "abc+1234def", beginIndex: 11, endIndex: 6, radix: 10))
        try XCTAssertNil(Int.java_parseInt​(s: "abc+1234def", beginIndex: 1, endIndex: 11, radix: 10))
        try XCTAssertNil(Int.java_parseInt​(s: "abc+1234def", beginIndex: 6, endIndex: 1, radix: 10))
        try XCTAssertNil(Int.java_parseInt​(s: "", beginIndex: 6, endIndex: 1, radix: 10))
        
        // Int.parseInt()
        try XCTAssertEqual(Int.java_parseInt​("2"), 2)
        try XCTAssertEqual(Int.java_parseInt​("+2"), 2)
        try XCTAssertEqual(Int.java_parseInt​("-2"), -2)
        try XCTAssertThrowsError(Int.java_parseInt​("abc"))
        try XCTAssertThrowsError(Int.java_parseInt​(""))
        
        // Int.parseInt()
        try XCTAssertEqual(Int.java_parseInt​(s: "0", radix: 10), 0)
        try XCTAssertEqual(Int.java_parseInt​(s: "473", radix: 10), 473)
        try XCTAssertEqual(Int.java_parseInt​(s: "+42", radix: 10), 42)
        try XCTAssertEqual(Int.java_parseInt​(s: "-0", radix: 10), 0)
        try XCTAssertEqual(Int.java_parseInt​(s: "-FF", radix: 16), -255)
        try XCTAssertEqual(Int.java_parseInt​(s: "1100110", radix: 2), 102)
        try XCTAssertEqual(Int.java_parseInt​(s: "2147483647", radix: 10), 2147483647)
        try XCTAssertEqual(Int.java_parseInt​(s: "-2147483647", radix: 10), -2147483647)
        try XCTAssertThrowsError(Int.java_parseInt​(s: "99", radix: 8))
        try XCTAssertThrowsError(Int.java_parseInt​(s: "Kona", radix: 10))
        try XCTAssertEqual(Int.java_parseInt​(s: "Kona", radix: 27), 411787)
       
        // Int.parseUnsignedInt​()
        try XCTAssertEqual(Int.java_parseUnsignedInt​(s: "abc1234def", beginIndex: 3, endIndex: 6, radix: 10), 1234)
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "abc1234def", beginIndex: 2, endIndex: 6, radix: 10))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "abc1234def", beginIndex: 3, endIndex: 9, radix: 10))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "abc1234def", beginIndex: -1, endIndex: 9, radix: 10))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "abc1234def", beginIndex: 3, endIndex: -9, radix: 10))
        try XCTAssertNil(Int.java_parseUnsignedInt​(s: "abc1234def", beginIndex: 10, endIndex: 10, radix: 10))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "abc1234def", beginIndex: 3, endIndex: 10, radix: 10))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "abc1234def", beginIndex: 9, endIndex: 3, radix: 10))
        try XCTAssertNil(Int.java_parseUnsignedInt​(s: "", beginIndex: 3, endIndex: 9, radix: 10))
        
        // Int.parseUnsignedInt()
        try XCTAssertEqual(Int.java_parseUnsignedInt​("2"), 2)
        try XCTAssertNotEqual(Int.java_parseUnsignedInt​("2"), 3)
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​("abc"))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(""))
        
        // Int.parseUnsignedInt​()
        try XCTAssertEqual(Int.java_parseUnsignedInt​(s: "1234", radix: 10), 1234)
        try XCTAssertEqual(Int.java_parseUnsignedInt​(s: "F", radix: 16), 15)
        try XCTAssertEqual(Int.java_parseUnsignedInt​(s: "15", radix: 8), 13)
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "1234", radix: 3))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "123a", radix: 10))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "J", radix: 16))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "8", radix: 8))
        try XCTAssertThrowsError(Int.java_parseUnsignedInt​(s: "", radix: 10))
        
        // Int.remainderUnsigned​()
        try XCTAssertEqual(Int.java_remainderUnsigned​(dividend: 10, divisor: 3), 1)
        try XCTAssertEqual(Int.java_remainderUnsigned​(dividend: -10, divisor: 3), 1)
        try XCTAssertEqual(Int.java_remainderUnsigned​(dividend: 10, divisor: -3), 1)
        try XCTAssertNotEqual(Int.java_remainderUnsigned​(dividend: 10, divisor: 3), 0)
        try XCTAssertThrowsError(Int.java_remainderUnsigned​(dividend: 10, divisor: 0))
        
        // Int.sum()
        XCTAssertEqual(Int.java_sum​(2, 2), 4)
        XCTAssertNotEqual(Int.java_sum​(2, 2), 5)
        
        // Int.toString()
        myInt = 1234
        XCTAssertEqual(myInt.java_toString(), "1234")
        XCTAssertNotEqual(myInt.java_toString(), "123")
        
        XCTAssertEqual(Int.java_toString​(myInt), "1234")
        XCTAssertEqual(Int.java_toString​(-myInt), "-1234")
        
        XCTAssertEqual(Int.java_toString​(i: myInt, radix: 10), "1234")
        XCTAssertEqual(Int.java_toString​(i: myInt, radix: 16), "4d2")
        XCTAssertEqual(Int.java_toString​(i: myInt, radix: 8), "2322")
        XCTAssertNotEqual(Int.java_toString​(i: myInt, radix: 10), "12345")
        XCTAssertNotEqual(Int.java_toString​(i: myInt, radix: 16), "4d22")
        XCTAssertNotEqual(Int.java_toString​(i: myInt, radix: 8), "23222")
        
        // Int.valueOf()
        try XCTAssertEqual(Int.java_valueOf​("1234"), 1234)
        try XCTAssertNotEqual(Int.java_valueOf​("1234"), 123)
        try XCTAssertThrowsError(Int.java_valueOf​("abcd"))
        try XCTAssertThrowsError(Int.java_valueOf​("123a"))
        try XCTAssertThrowsError(Int.java_valueOf​(""))
        
        try XCTAssertEqual(Int.java_valueOf​(s: "1234", radix: 10), 1234)
        try XCTAssertEqual(Int.java_valueOf​(s: "FF", radix: 16), 255)
        try XCTAssertEqual(Int.java_valueOf​(s: "77", radix: 8), 63)
        try XCTAssertNotEqual(Int.java_valueOf​(s: "1234", radix: 10), 12345)
        try XCTAssertNotEqual(Int.java_valueOf​(s: "FF", radix: 16), 2555)
        try XCTAssertNotEqual(Int.java_valueOf​(s: "77", radix: 8), 633)
        try XCTAssertThrowsError(Int.java_valueOf​(s: "123a", radix: 10))
        try XCTAssertThrowsError(Int.java_valueOf​(s: "FJ", radix: 16))
        try XCTAssertThrowsError(Int.java_valueOf​(s: "88", radix: 8))
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
