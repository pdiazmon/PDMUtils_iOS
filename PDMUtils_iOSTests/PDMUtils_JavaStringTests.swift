//
//  PDMUtils_StringJavaTests.swift
//  PDMUtils_iOSTests
//
//  Created by Pedro L. Diaz Montilla on 17/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import XCTest
@testable import PDMUtils_iOS


class PDMUtils_StringJavaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStringJava() {
        // String.charAt()
        try XCTAssertEqual("ABCDEF".java_charAt(1), "B")
        try XCTAssertThrowsError("ABCDEF".java_charAt(100))
        try XCTAssertThrowsError("ABCDEF".java_charAt(-1))
        
        // String.concat()
        XCTAssertEqual("ABCDEF".java_concat("HIJK"), "ABCDEFHIJK")
        XCTAssertNotEqual("ABCDEF".java_concat("HIJK"), "ABCDEFHIJKLM")
        
        // String.contentEquals()
        XCTAssertTrue("ABCDEF".java_contentEquals("ABCDEF"))
        XCTAssertFalse("ABCDEF".java_contentEquals("ABCDEFHIJK"))
        
        // String.copyValueOf()
        XCTAssertEqual(String.java_copyValueOf(["A", "B", "C"]), "ABC")
        XCTAssertNotEqual(String.java_copyValueOf(["A", "B", "C"]), "A")
        
        try XCTAssertEqual(String.java_copyValueOf(data: ["A", "B", "C", "D", "E", "F"], offset: 1, count: 2), "BC")
        try XCTAssertThrowsError(String.java_copyValueOf(data: ["A", "B", "C", "D", "E", "F"], offset: -1, count: 2))
        try XCTAssertThrowsError(String.java_copyValueOf(data: ["A", "B", "C", "D", "E", "F"], offset: 1, count: -2))
        try XCTAssertThrowsError(String.java_copyValueOf(data: ["A", "B", "C", "D", "E", "F"], offset: 1, count: 7))
        try XCTAssertThrowsError(String.java_copyValueOf(data: ["A", "B", "C", "D", "E", "F"], offset: 7, count: 3))
        try XCTAssertThrowsError(String.java_copyValueOf(data: ["A", "B", "C", "D", "E", "F"], offset: 5, count: 2))
        
        // String.endsWith()
        XCTAssertTrue("ABCDEF".java_endsWith("DEF"))
        XCTAssertFalse("ABCDEF".java_endsWith("DE"))
        
        // String.equals()
        XCTAssertTrue("ABCDEF".java_equals("ABCDEF"))
        XCTAssertFalse("ABCDEF".java_equals("ABCDE"))
        XCTAssertTrue("2".java_equals(2))
        XCTAssertFalse("2".java_equals(1))
        XCTAssertTrue("2.0".java_equals(2.0))
        XCTAssertFalse("2.0".java_equals(1.0))
        XCTAssertFalse("ABC".java_equals(["A","B","C"]))
        
        // String.equalsIgnoreCase
        XCTAssertTrue("ABC".java_equalsIgnoreCase("abc"))
        XCTAssertTrue("ABC".java_equalsIgnoreCase("ABC"))
        XCTAssertFalse("ABC".java_equalsIgnoreCase("ab"))
        
        // String.getChars
        var myArray: [Character] = ["A","B","C","D","E","F"]
        let myString = "0123456"
        try? myString.java_getChars(srcBegin: 1, srcEnd: 3, dst: &myArray, dstBegin: 1)
        XCTAssertEqual(myArray.description, ["A","1","2","D","E","F"].description)
        try XCTAssertThrowsError(myString.java_getChars(srcBegin: -1, srcEnd: 3, dst: &myArray, dstBegin: 1))
        try XCTAssertThrowsError(myString.java_getChars(srcBegin: 4, srcEnd: 3, dst: &myArray, dstBegin: 1))
        try XCTAssertThrowsError(myString.java_getChars(srcBegin: 1, srcEnd: 3, dst: &myArray, dstBegin: -1))
        try XCTAssertThrowsError(myString.java_getChars(srcBegin: 1, srcEnd: 3, dst: &myArray, dstBegin: 5))
        
        // String.indexOf()
        XCTAssertEqual("ABCDEF".java_indexOf(ch: "C"), 2)
        XCTAssertEqual("ABCDEF".java_indexOf(ch: "A"), 0)
        XCTAssertEqual("ABCDEF".java_indexOf(ch: "F"), 5)
        XCTAssertNil("ABCDEF".java_indexOf(ch: "X"))
        
        XCTAssertEqual("ABCABCABC".java_indexOf(ch: "A", fromIndex: 1), 3)
        XCTAssertEqual("ABC".java_indexOf(ch: "B", fromIndex: -1), 1)
        XCTAssertNil("ABCABCABC".java_indexOf(ch: "X", fromIndex: 1))
        XCTAssertNil("ABC".java_indexOf(ch: "C", fromIndex: 3))
        
        XCTAssertEqual("ABCDEF".java_indexOf(str: "ABC"), 0)
        XCTAssertEqual("ABCDEF".java_indexOf(str: "CDE"), 2)
        XCTAssertEqual("ABCDEF".java_indexOf(str: "F"), 5)
        XCTAssertNil("ABCDEF".java_indexOf(str: "FG"))
        XCTAssertNil("ABCDEF".java_indexOf(str: "XX"))
        XCTAssertNil("ABCDEF".java_indexOf(str: ""))

        XCTAssertEqual("ABCABCABC".java_indexOf(str: "ABC", fromIndex: 1), 3)
        XCTAssertNil("ABCABCABC".java_indexOf(str: "XXX", fromIndex: 1))
        XCTAssertNil("ABC".java_indexOf(str: "CD", fromIndex: 3))
        XCTAssertNil("ABC".java_indexOf(str: "AB", fromIndex: -1))
        XCTAssertNil("".java_indexOf(str: "AB", fromIndex: 1))

        XCTAssertEqual("ABABAB".java_lastIndexOf(ch: "A"), 4)
        XCTAssertEqual("ABABAB".java_lastIndexOf(ch: "B"), 5)
        XCTAssertEqual("ABABABX".java_lastIndexOf(ch: "X"), 6)
        XCTAssertNil("ABABAB".java_lastIndexOf(ch: "X"))
        XCTAssertNil("".java_lastIndexOf(ch: "A"))
        
        XCTAssertEqual("ABABAB".java_lastIndexOf(ch: "A", fromIndex: 2), 4)
        XCTAssertEqual("ABABAB".java_lastIndexOf(ch: "A", fromIndex: 1), 4)
        XCTAssertEqual("ABABABX".java_lastIndexOf(ch: "X", fromIndex: 2), 6)
        XCTAssertEqual("ABABABX".java_lastIndexOf(ch: "X", fromIndex: 8), 6)
        XCTAssertNil("ABABAB".java_lastIndexOf(ch: "X", fromIndex: 2))
        XCTAssertNil("ABABAB".java_lastIndexOf(ch: "A", fromIndex: -1))
        XCTAssertNil("ABABAB".java_lastIndexOf(ch: "A", fromIndex: 6))
        XCTAssertNil("".java_lastIndexOf(ch: "X", fromIndex: 0))
        XCTAssertNil("".java_lastIndexOf(ch: "X", fromIndex: 1))
        XCTAssertNil("".java_lastIndexOf(ch: "X", fromIndex: -1))
        
        XCTAssertEqual("ABABAB".java_lastIndexOf(str: "AB"), 4)
        XCTAssertEqual("ABABAB".java_lastIndexOf(str: "BA"), 3)
        XCTAssertEqual("ABABABXX".java_lastIndexOf(str: "XX"), 6)
        XCTAssertNil("ABABAB".java_lastIndexOf(str: "XX"))
        XCTAssertNil("ABABAB".java_lastIndexOf(str: ""))
        XCTAssertNil("".java_lastIndexOf(str: "AB"))

        XCTAssertEqual("ABABAB".java_lastIndexOf(str: "AB", fromIndex: 2), 4)
        XCTAssertEqual("ABABAB".java_lastIndexOf(str: "AB", fromIndex: 1), 4)
        XCTAssertEqual("ABABABX".java_lastIndexOf(str: "BX", fromIndex: 2), 5)
        XCTAssertNil("ABABAB".java_lastIndexOf(str: "XX", fromIndex: 2))
        XCTAssertNil("".java_lastIndexOf(str: "X", fromIndex: 0))
        XCTAssertNil("".java_lastIndexOf(str: "X", fromIndex: 1))
        XCTAssertNil("".java_lastIndexOf(str: "X", fromIndex: -1))
        
        // String.length()
        XCTAssertEqual("12345".java_length(), 5)
        XCTAssertEqual("".java_length(), 0)
        
        // String.regionMatches()
        XCTAssertTrue("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: 1, other: "AABcd", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: false, toffset: 1, other: "AABcd", ooffset: 2, len: 3))
        XCTAssertTrue("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: 1, other: "AABCD", ooffset: 2, len: 3))
        XCTAssertTrue("ABCDEFGHIJK".java_regionMatches(ignoreCase: false, toffset: 1, other: "AABCD", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: false, toffset: 1, other: "AAABCD", ooffset: 2, len: 3))
        XCTAssertFalse("".java_regionMatches(ignoreCase: false, toffset: 1, other: "AAABCD", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: -1, other: "AABcd", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: 1, other: "AABcd", ooffset: 2, len: 30))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: 1, other: "AABcd", ooffset: -2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: 1, other: "AABcd", ooffset: 2, len: 30))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: 1, other: "AABcd", ooffset: 2, len: -3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: 12, other: "AABcd", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: 1, other: "AABcd", ooffset: 6, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(ignoreCase: true, toffset: 1, other: "AABcd", ooffset: 2, len: 6))

        XCTAssertTrue("ABCDEFGHIJK".java_regionMatches(toffset: 1, other: "AABCD", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(toffset: 1, other: "AABcd", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(toffset: 1, other: "AAABCD", ooffset: 2, len: 3))
        XCTAssertFalse("".java_regionMatches(toffset: 1, other: "AAABCD", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(toffset: -1, other: "AABcd", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(toffset: 1, other: "AABcd", ooffset: -2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(toffset: 1, other: "AABcd", ooffset: 2, len: -3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(toffset: 12, other: "AABcd", ooffset: 2, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(toffset: 1, other: "AABcd", ooffset: 6, len: 3))
        XCTAssertFalse("ABCDEFGHIJK".java_regionMatches(toffset: 1, other: "AABcd", ooffset: 2, len: 6))

        // String.replace()
        XCTAssertEqual("ABCDEF".java_replace(oldChar: "C", newChar: "X"), "ABXDEF")
        XCTAssertEqual("ABCDEF".java_replace(oldChar: "A", newChar: "X"), "XBCDEF")
        XCTAssertEqual("ABCDEF".java_replace(oldChar: "F", newChar: "X"), "ABCDEX")
        XCTAssertNotEqual("ABCDEF".java_replace(oldChar: "C", newChar: "X"), "ABCDEF")
        XCTAssertNil("ABCDEF".java_replace(oldChar: "X", newChar: "Y"))
        XCTAssertNil("".java_replace(oldChar: "X", newChar: "Y"))

        XCTAssertEqual("ABCDEF".java_replace(target: "CD", replacement: "XX"), "ABXXEF")
        XCTAssertEqual("ABCDEF".java_replace(target: "AB", replacement: "XX"), "XXCDEF")
        XCTAssertEqual("ABCDEF".java_replace(target: "EF", replacement: "XX"), "ABCDXX")
        XCTAssertNotEqual("ABCDEF".java_replace(target: "CD", replacement: "XX"), "ABCDEF")
        XCTAssertNil("ABCDEF".java_replace(target: "XX", replacement: "YY"))
        XCTAssertNil("".java_replace(target: "XX", replacement: "YY"))

        // String.startsWith()
        XCTAssertTrue("ABCDEF".java_startsWith("AB"))
        XCTAssertFalse("ABCDEF".java_startsWith("XX"))
        XCTAssertFalse("ABCDEF".java_startsWith(""))
        XCTAssertFalse("".java_startsWith("AB"))
        
        XCTAssertTrue("ABCDEF".java_startsWith(prefix: "BC", toffset: 1))
        XCTAssertFalse("ABCDEF".java_startsWith(prefix: "", toffset: 1))
        XCTAssertFalse("ABCDEF".java_startsWith(prefix: "XX", toffset: 1))
        XCTAssertFalse("ABCDEF".java_startsWith(prefix: "BC", toffset: 7))
        XCTAssertFalse("ABCDEF".java_startsWith(prefix: "BC", toffset: -1))
        XCTAssertFalse("".java_startsWith(prefix: "BC", toffset: 1))
        
        // String.substring()
        try XCTAssertEqual("ABCDEF".java_substring(beginIndex: 1), "BCDEF")
        try XCTAssertEqual("ABCDEF".java_substring(beginIndex: 0), "ABCDEF")
        try XCTAssertEqual("ABCDEF".java_substring(beginIndex: 5), "F")
        try XCTAssertNotEqual("ABCDEF".java_substring(beginIndex: 1), "CDEF")
        try XCTAssertThrowsError("ABCDEF".java_substring(beginIndex: 6))
        try XCTAssertThrowsError("ABCDEF".java_substring(beginIndex: -1))
        try XCTAssertThrowsError("".java_substring(beginIndex: 0))

        try XCTAssertEqual("hamburger".java_substring(beginIndex: 4, endIndex: 8), "urge")
        try XCTAssertEqual("smiles".java_substring(beginIndex: 1, endIndex: 5), "mile")
        try XCTAssertEqual("ABCDEF".java_substring(beginIndex: 1, endIndex: 4), "BCD")
        try XCTAssertEqual("ABCDEF".java_substring(beginIndex: 0, endIndex: 6), "ABCDEF")
        try XCTAssertEqual("ABCDEF".java_substring(beginIndex: 5, endIndex: 6), "F")
        try XCTAssertThrowsError("ABCDEF".java_substring(beginIndex: 7, endIndex: 7))
        try XCTAssertThrowsError("ABCDEF".java_substring(beginIndex: -1, endIndex: 5))
        try XCTAssertThrowsError("ABCDEF".java_substring(beginIndex: 0, endIndex: -5))
        try XCTAssertThrowsError("ABCDEF".java_substring(beginIndex: 5, endIndex: 1))
        try XCTAssertThrowsError("".java_substring(beginIndex: 0, endIndex: 0))

        // String.toCharArray()
        XCTAssertEqual("ABC".java_toCharArray(), ["A","B","C"])
        XCTAssertEqual("".java_toCharArray(), [])
        
        // String.toLowerCase()
        XCTAssertEqual("ABCDE".java_toLowerCase(), "abcde")
        XCTAssertEqual("AbcdE".java_toLowerCase(), "abcde")
        XCTAssertEqual("".java_toLowerCase(), "")
    
        // String.toString()
        XCTAssertEqual("ABCDE".java_toString(), "ABCDE")
        XCTAssertEqual("".java_toString(), "")
        
        // String.toUpperCase()
        XCTAssertEqual("abcde".java_toUpperCase(), "ABCDE")
        XCTAssertEqual("aBCDe".java_toUpperCase(), "ABCDE")
        XCTAssertEqual("".java_toUpperCase(), "")

        // String.trim()
        XCTAssertEqual("  ABC  ".java_trim(), "ABC")
        XCTAssertEqual("  ABC".java_trim(), "ABC")
        XCTAssertEqual("ABC  ".java_trim(), "ABC")
        XCTAssertEqual("  A  B  C  ".java_trim(), "A  B  C")
        XCTAssertEqual("".java_trim(), "")

        // String.valueOf()
        XCTAssertEqual(String.java_valueOf(true), "true")
        XCTAssertEqual(String.java_valueOf(false), "false")
        
        XCTAssertEqual(String.java_valueOf(Character("A")), "A")
        
        let myArray2: [Character] = ["A","B","C"]
        XCTAssertEqual(String.java_valueOf(myArray2), "[\"A\", \"B\", \"C\"]")
    
        try XCTAssertEqual(String.java_valueOf(data: myArray2, offset: 1, count: 2), "[\"B\", \"C\"]")
        try XCTAssertThrowsError(String.java_valueOf(data: myArray2, offset: -1, count: 2))
        try XCTAssertThrowsError(String.java_valueOf(data: myArray2, offset: -1, count: 2))
        try XCTAssertThrowsError(String.java_valueOf(data: myArray2, offset: 4, count: 2))
        try XCTAssertThrowsError(String.java_valueOf(data: myArray2, offset: 1, count: -2))
        try XCTAssertThrowsError(String.java_valueOf(data: myArray2, offset: 1, count: 4))
        try XCTAssertThrowsError(String.java_valueOf(data: myArray2, offset: 1, count: 3))

        XCTAssertEqual(String.java_valueOf(Double(2.3)), "2.3")
        
        XCTAssertEqual(String.java_valueOf(Float(2.3)), "2.3")
        
        XCTAssertEqual(String.java_valueOf(Int(100)), "100")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
