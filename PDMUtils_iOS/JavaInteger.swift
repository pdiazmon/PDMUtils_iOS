//
//  Integer.swift
//  PDMUtils_iOS
//
//  Created by Pedro L. Diaz Montilla on 16/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

/*
** Port to Swift languaje of most of the Integer class methods in Java
** If you're moving from Java to Swift it could be useful in order to have a more readable and Java-like Swift code
*/

/*
** Some of the Java Integer methods are not ported yet:
*
	static int bitCount​(int i) Returns the number of one-bits in the two's complement binary representation of the specified int value.
	byte byteValue​() Returns the value of this Integer as a byte after a narrowing primitive conversion.
	static Integer getInteger​(String nm) - Determines the integer value of the system property with the specified name.
	static Integer getInteger​(String nm, int val) - Determines the integer value of the system property with the specified name.
	static Integer getInteger​(String nm, Integer val) - Returns the integer value of the system property with the specified name.
	static int highestOneBit​(int i) - Returns an int value with at most a single one-bit, in the position of the highest-order ("leftmost") one-bit in the specified int value.
	int intValue​() - Returns the value of this Integer as an int.
	long longValue​() - Returns the value of this Integer as a long after a widening primitive conversion.
	static int lowestOneBit​(int i) - Returns an int value with at most a single one-bit, in the position of the lowest-order ("rightmost") one-bit in the specified int value.
	static int numberOfLeadingZeros​(int i) - Returns the number of zero bits preceding the highest-order ("leftmost") one-bit in the two's complement binary representation of the specified int value.
	static int numberOfTrailingZeros​(int i) - Returns the number of zero bits following the lowest-order ("rightmost") one-bit in the two's complement binary representation of the specified int value.
	static int reverse​(int i) - Returns the value obtained by reversing the order of the bits in the two's complement binary representation of the specified int value.
	static int reverseBytes​(int i) - Returns the value obtained by reversing the order of the bytes in the two's complement representation of the specified int value.
	static int rotateLeft​(int i, int distance) - Returns the value obtained by rotating the two's complement binary representation of the specified int value left by the specified number of bits.
	static int rotateRight​(int i, int distance) - Returns the value obtained by rotating the two's complement binary representation of the specified int value right by the specified number of bits.
	short shortValue​() - Returns the value of this Integer as a short after a narrowing primitive conversion.
	static int signum​(int i) - Returns the signum function of the specified int value.
	static String toBinaryString​(int i) - Returns a string representation of the integer argument as an unsigned integer in base 2.
	static String toHexString​(int i) - Returns a string representation of the integer argument as an unsigned integer in base 16.
	static String toOctalString​(int i) - Returns a string representation of the integer argument as an unsigned integer in base 8.
	static long toUnsignedLong​(int x) - Converts the argument to a long by an unsigned conversion.
	static String toUnsignedString​(int i) - Returns a string representation of the argument as an unsigned decimal value.
	static String toUnsignedString​(int i, int radix) - Returns a string representation of the first argument as an unsigned integer value in the radix specified by the second argument.
*/

import Foundation

extension Int {
	
	enum IntError: Error {
		case NumberFormatError
        case IndexOutOfBoundsError
		case InvalidRadix
		case DividedByZero
	}
	
    /// Compares two int values numerically. The value returned is identical to what would be returned by:
    ///
    ///     Integer.valueOf(x).compareTo(Integer.valueOf(y))
    ///
    /// - Returns: the value 0 if x == y; a value less than 0 if x < y; and a value greater than 0 if x > y
    /// - Parameter x: the first int to compare
    /// - Parameter y: the second int to compare
	static func java_compare​(x: Int, y: Int) -> Int {
		if (x == y) { return 0 }
		else if (x < y) { return -1 }
		else { return 1 }
	}
	
    /// Compares two Integer objects numerically.
    ///
    /// - Returns: the value 0 if this Integer is equal to the argument Integer; a value less than 0 if this Integer is numerically less than the argument Integer; and a value greater than 0 if this Integer is numerically greater than the argument Integer (signed comparison).the value 0 if x == y; a value less than 0 if x < y as unsigned values; and a value greater than 0 if x > y as unsigned values
    /// - Parameter anotherInteger: the Integer to be compared.
	func java_compareTo​(_ anotherInteger: Int) -> Int {
		if (self == anotherInteger) { return 0 }
		else if (self < anotherInteger) { return -1 }
		else { return 1 }
	}
	
    /// Compares two int values numerically treating the values as unsigned.
    ///
    /// - Returns: the value 0 if x == y; a value less than 0 if x < y as unsigned values; and a value greater than 0 if x > y as unsigned values
    /// - Parameter x: the first int to compare
    /// - Parameter y: the second int to compare
	static func java_compareUnsigned​(x: Int, y: Int) -> Int {
		let ux: Int = x * (x<0 ? -1 : 1)
		let uy: Int = y * (y<0 ? -1 : 1)
		
		if (ux == uy) { return 0 }
		else if (ux < uy) { return -1 }
		else { return 1 }
	}

    /// Decodes a String into an Integer. Accepts decimal, hexadecimal, and octal numbers given by the following grammar:
    ///
    /// **DecodableString:**
    /// * Signopt DecimalNumeral
    /// *  Signopt 0x HexDigits
    /// *  Signopt 0X HexDigits
    /// *  Signopt # HexDigits
    /// *  Signopt 0 OctalDigits
    /// *  Sign: minus and plus
    ///
    /// DecimalNumeral, HexDigits, and OctalDigits are as defined in section 3.10.1 of The Java™ Language Specification, except that underscores are not accepted between digits.
    ///
    /// The sequence of characters following an optional sign and/or radix specifier ("0x", "0X", "#", or leading zero) is parsed as by the Integer.parseInt method with the indicated radix (10, 16, or 8). This sequence of characters must represent a positive value or a NumberFormatException will be thrown. The result is negated if first character of the specified String is the minus sign. No whitespace characters are permitted in the String.
    ///
    /// - Returns: an Integer object holding the int value represented by nm
    /// - Parameter nm: the String to decode.
    /// - Throws: IntError.NumberFormatError - if the String does not contain a parsable integer.
	static func java_decode​(_ nm: String) throws -> Int {
		var sign: Bool = true // false: minus; true: plus
		var wnm: String = nm
		
		if (wnm.hasPrefix("+")) {
			sign = true;
			wnm = String(wnm.dropFirst())
		}
		if (wnm.hasPrefix("-")) {
			sign = false;
			wnm = String(wnm.dropFirst())
		}
		
		// If it is an hexadecimal number
		if (wnm.uppercased().hasPrefix("0X")) {
			wnm = String(wnm.dropFirst().dropFirst())
			if (wnm.pdmIsHexadecimal()) {
				return Int(wnm, radix: 16)! * (!sign ? -1 : 1)
			}
			else {
				throw IntError.NumberFormatError
			}
		}
		// If it is an octal number
		else if (wnm.hasPrefix("#")) {
			wnm = String(wnm.dropFirst())
			if (wnm.pdmIsOctal()) {
				return Int(wnm, radix: 8)!  * (!sign ? -1 : 1)
			}
			else {
				throw IntError.NumberFormatError
			}
		}
		// If it is a decimal number
		else if (wnm.pdmIsNumeric()) {
			return wnm.pdmToInt()! * (!sign ? -1 : 1)
		}
		else {
			throw IntError.NumberFormatError
		}
	}
	
    /// Returns the unsigned quotient of dividing the first argument by the second where each argument and the result is interpreted as an unsigned value.
    ///
    /// Note that in two's complement arithmetic, the three other basic arithmetic operations of add, subtract, and multiply are bit-wise identical if the two operands are regarded as both being signed or both being unsigned. Therefore separate addUnsigned, etc. methods are not provided.
    ///
    /// - Returns: the unsigned quotient of the first argument divided by the second argumentthe value 0 if x == y; a value less than 0 if x < y as unsigned values; and a value greater than 0 if x > y as unsigned values
    /// - Parameter dividend: the value to be divided
    /// - Parameter divisor: the value doing the dividing
    /// - Throws: IntError.DividedByZero - if divisor is zero
	static func java_divideUnsigned​(dividend: Int, divisor: Int) throws -> UInt {
		guard (divisor != 0) else { throw IntError.DividedByZero }
		
		var div: Int
		
		div = dividend / divisor
		
		return UInt((div > 0 ? div : -div))
	}
	
    /// Returns the value of this Integer as a double after a widening primitive conversion.
    ///
    /// - Returns: the numeric value represented by this object after conversion to type double.
	func java_doubleValue​() -> Double { return Double(self) }
	
    /// Compares this object to the specified object. The result is true if and only if the argument is not null and is an Integer object that contains the same int value as this object.
    ///
    /// - Returns: true if the objects are the same; false otherwise.
    /// - Parameter obj: the object to compare with.
	func java_equals​(_ obj: Any) -> Bool {
		if (obj is Int) {
			return ((obj as! Int) == self)
		}
		else if (obj is Double) {
			return (Int((obj as! Double)) == self)
		}
		else if (obj is Float) {
			return (Int((obj as! Float)) == self)
		}
		else if (obj is String) {
			if ((obj as! String).pdmIsNumeric()) { return (obj as! String).pdmToInt()! == self }
			else { return false }
		}
		else {
			return false
		}
	}
	
    /// Returns the value of this Integer as a float after a widening primitive conversion.
    ///
    /// - Returns: the numeric value represented by this object after conversion to type float.
	func java_floatValue​() -> Float {
		return Float(self)
	}
	
    /// Returns a hash code for this Integer.
    ///
    /// - Returns: a hash code value for this object, equal to the primitive int value represented by this Integer object.
	func java_hashCode​() -> Int {
		return self.hashValue
	}
	
    /// Returns a hash code for a int value; compatible with Integer.hashCode().
    ///
    /// - Returns: a hash code value for a int value.
    /// - Parameter value - the value to hash
	static func java_hashCode​(_ value: Int) -> Int {
		return value.java_hashCode​()
	}
	
    /// Returns the greater of two int values as if by calling Swift.max.
    ///
    /// - Returns: the greater of a and b
    /// - Parameter a: the first operand
    /// - Parameter b: the second operand
	static func java_max​(_ a: Int, _ b: Int) -> Int {
		return Swift.max(a, b)
	}
	
    /// Returns the smaller of two int values as if by calling Swift.min.
    ///
    /// - Returns: the smaller of a and b
    /// - Parameter a: the first operand
    /// - Parameter b: the second operand
	static func java_min​(_ a: Int, _ b: Int) -> Int {
		return Swift.min(a, b)
	}
	
    /// Parses the String argument as a signed int in the specified radix, beginning at the specified beginIndex and extending to endIndex - 1.
    ///
    /// The method does not take steps to guard against the String being mutated while parsing.
    ///
    /// - Returns: The signed int represented by the subsequence in the specified radix.
    /// - Parameter s: The String containing the int representation to be parsed
    /// - Parameter beginIndex: The beginning index, inclusive.
    /// - Parameter endIndex: The ending index, exclusive.
    /// - Parameter radix: The radix to be used while parsing s.
    /// - Throws: NumberFormatError - if the CharSequence does not contain a parsable int in the specified radix
	static func java_parseInt​(s: String, beginIndex: Int, endIndex: Int, radix: Int) throws -> Int? {
		guard (s.count > 0)            else { return nil }
		guard (beginIndex >= 0)        else { return nil }
		guard (beginIndex < s.count)   else { return nil }
		guard (beginIndex <= endIndex) else { return nil }
		guard (endIndex >= 0)          else { return nil }
		guard (endIndex < s.count)     else { return nil }

		if let ws = s.pdmSubstring(fromIndex: beginIndex, numberOfCharacters: endIndex-beginIndex+1) {
            if let i = Int(ws, radix: radix) {
                return i
            }
            else {
                throw IntError.NumberFormatError
            }
		}
		else {
            throw IntError.NumberFormatError
        }
	}
	
    /// Parses the string argument as a signed decimal integer. The characters in the string must all be decimal digits, except that the first character may be an ASCII minus sign '-' ('\u002D') to indicate a negative value or an ASCII plus sign '+' ('\u002B') to indicate a positive value. The resulting integer value is returned, exactly as if the argument and the radix 10 were given as arguments to the parseInt(java.lang.String, int) method.
    ///
    /// - Returns: The integer value represented by the argument in decimal.
    /// - Parameter s: A String containing the int representation to be parsed
    /// - Throws: NumberFormatError - if the String does not contain a parsable int.
	static func java_parseInt​(_ s: String) throws -> Int {
        guard (s.count > 0) else { throw IntError.NumberFormatError }
        
        if let i = Int(s, radix: 10) { return i }
        else { throw IntError.NumberFormatError }
	}
	
    /// Parses the string argument as a signed integer in the radix specified by the second argument. The characters in the string must all be digits of the specified radix (as determined by whether Character.digit(char, int) returns a nonnegative value), except that the first character may be an ASCII minus sign '-' ('\u002D') to indicate a negative value or an ASCII plus sign '+' ('\u002B') to indicate a positive value. The resulting integer value is returned.
    ///
    /// An exception of type NumberFormatException is thrown if any of the following situations occurs:
    ///
    /// * The first argument is null or is a string of length zero.
    /// * The radix is either smaller than Character.MIN_RADIX or larger than Character.MAX_RADIX.
    /// * Any character of the string is not a digit of the specified radix, except that the first character may be a minus sign '-' ('\u002D') or plus sign '+' ('\u002B') provided that the string is longer than length 1.
    /// * The value represented by the string is not a value of type int.
    ///
    /// Examples:
    /// * parseInt("0", 10) returns 0
    /// * parseInt("473", 10) returns 473
    /// * parseInt("+42", 10) returns 42
    /// * parseInt("-0", 10) returns 0
    /// * parseInt("-FF", 16) returns -255
    /// * parseInt("1100110", 2) returns 102
    /// * parseInt("2147483647", 10) returns 2147483647
    /// * parseInt("-2147483648", 10) returns -2147483648
    /// * parseInt("2147483648", 10) throws a NumberFormatException
    /// * parseInt("99", 8) throws a NumberFormatException
    /// * parseInt("Kona", 10) throws a NumberFormatException
    /// * parseInt("Kona", 27) returns 411787
    ///
    /// - Returns: The integer represented by the string argument in the specified radix.
    /// - Parameter s: The String containing the integer representation to be parsed
    /// - Parameter radix: The radix to be used while parsing s.
    /// - Throws: NumberFormatError - if the String does not contain a parsable int.
	static func java_parseInt​(s: String, radix: Int) throws -> Int {
		guard (s.count > 0) else { throw IntError.NumberFormatError }
        
        if let i = Int(s, radix: radix) { return i }
        else { throw IntError.NumberFormatError }
	}
	
    /// Parses the String argument as an unsigned int in the specified radix, beginning at the specified beginIndex and extending to endIndex - 1.
    ///
    /// The method does not take steps to guard against the CharSequence being mutated while parsing.
    ///
    /// - Returns: The unsigned int represented by the subsequence in the specified radix.
    /// - Parameter s: the CharSequence containing the unsigned int representation to be parsed
    /// - Parameter beginIndex: the beginning index, inclusive.
    /// - Parameter endIndex: the ending index, exclusive.
    /// - Parameter radix: the radix to be used while parsing s.
    /// - Throws: IndexOutOfBoundsError - if beginIndex is negative, or if beginIndex is greater than endIndex or if endIndex is greater than s.length().
    /// NumberFormatEror - if the String does not contain a parsable unsigned int in the specified radix.
	static func java_parseUnsignedInt​(s: String, beginIndex: Int, endIndex: Int, radix: Int) throws -> UInt? {
		guard (s.count > 0)            else { return nil }
		guard (beginIndex >= 0)        else { throw IntError.IndexOutOfBoundsError }
		guard (beginIndex < s.count)   else { return nil }
		guard (beginIndex <= endIndex) else { throw IntError.IndexOutOfBoundsError }
		guard (endIndex >= 0)          else { return nil }
		guard (endIndex < s.count)     else { throw IntError.IndexOutOfBoundsError }
		
		if let ws = s.pdmSubstring(fromIndex: beginIndex, numberOfCharacters: endIndex-beginIndex+1) {
            if let i = UInt(ws, radix: radix) { return i }
            else { throw IntError.NumberFormatError }
		}
		else { return nil }

	}
	
    /// Parses the string argument as an unsigned decimal integer. The characters in the string must all be decimal digits, except that the first character may be an ASCII plus sign '+' ('\u002B'). The resulting integer value is returned, exactly as if the argument and the radix 10 were given as arguments to the parseUnsignedInt(java.lang.String, int) method.
    ///
    /// - Returns: the unsigned integer value represented by the argument in decimal.
    /// - Parameter s: a String containing the unsigned int representation to be parsed
    /// - Throws: NumberFormatEror - if the String does not contain a parsable unsigned int in the specified radix.
	static func java_parseUnsignedInt​(_ s: String) throws -> UInt {
		return try UInt(java_parseInt​(s))
	}
	
    /// Parses the string argument as an unsigned integer in the radix specified by the second argument. An unsigned integer maps the values usually associated with negative numbers to positive numbers larger than MAX_VALUE. The characters in the string must all be digits of the specified radix (as determined by whether Character.digit(char, int) returns a nonnegative value), except that the first character may be an ASCII plus sign '+' ('\u002B'). The resulting integer value is returned.
    ///
    /// An exception of type NumberFormatError is thrown if any of the following situations occurs:
    /// * The first argument is null or is a string of length zero.
    /// * Any character of the string is not a digit of the specified radix, except that the first character may be a plus sign '+' ('\u002B') provided that the string is longer than length 1.
    /// * The value represented by the string is larger than the largest unsigned int, 232-1.
    ///
    /// - Returns: the integer represented by the string argument in the specified radix.
    /// - Parameter s: the String containing the unsigned int representation to be parsed
    /// - Parameter radix: the radix to be used while parsing s.
    /// - Throws: NumberFormatEror - if the String does not contain a parsable int.
	static func java_parseUnsignedInt​(s: String, radix: Int) throws -> UInt {
        return try UInt(java_parseInt​(s: s, radix: radix))
	}
	
    /// Returns the unsigned remainder from dividing the first argument by the second where each argument and the result is interpreted as an unsigned value.
    ///
    /// - Returns: the unsigned remainder of the first argument divided by the second argument
    /// - Parameter dividend: the value to be divided
    /// - Parameter divisor: the value doing the dividing
    /// - Throws: DividedByZero - if divisor is zero
	static func java_remainderUnsigned​(dividend: Int, divisor: Int) throws -> UInt {
		guard (divisor != 0) else { throw IntError.DividedByZero }
		
		let wDividend = UInt(dividend * ((dividend > 0) ? 1 : -1))
		let wDivisor = UInt(divisor * ((divisor > 0) ? 1 : -1))

		return UInt(wDividend % wDivisor)
	}
	
    /// Adds two integers together as per the + operator.
    ///
    /// - Returns: the sum of a and b
    /// - Parameter a: the first operand
    /// - Parameter b: the second operand
	static func java_sum​(_ a: Int, _ b: Int) -> Int {
		return a + b
	}
	
    /// Returns a String object representing this Integer's value. The value is converted to signed decimal representation and returned as a string, exactly as if the integer value were given as an argument to the toString(int) method.
    ///
    /// - Returns: a string representation of the value of this object in base 10.
    func java_toString() -> String {
		return String(self)
	}
	
    /// Returns a String object representing the specified integer. The argument is converted to signed decimal representation and returned as a string, exactly as if the argument and radix 10 were given as arguments to the toString(int, int) method.
    ///
    /// - Returns: a string representation of the value of this object in base 10.
    /// Parameter i: an integer to be converted.
	static func java_toString​(_ i: Int) -> String {
		return String(i)
	}
	
    /// Returns a string representation of the first argument in the radix specified by the second argument.
    ///
    /// If the first argument is negative, the first element of the result is the ASCII minus character '-' ('\u002D'). If the first argument is not negative, no sign character appears in the result.
    ///
    /// The remaining characters of the result represent the magnitude of the first argument. If the magnitude is zero, it is represented by a single zero character '0' ('\u0030'); otherwise, the first character of the representation of the magnitude will not be the zero character. The following ASCII characters are used as digits:
    ///
    ///     0123456789abcdefghijklmnopqrstuvwxyz
    /// These are '\u0030' through '\u0039' and '\u0061' through '\u007A'. If radix is N, then the first N of these characters are used as radix-N digits in the order shown. Thus, the digits for hexadecimal (radix 16) are 0123456789abcdef. If uppercase letters are desired, the String.toUpperCase() method may be called on the result:
    ///
    ///     Integer.toString(n, 16).toUpperCase()
    ///
    /// - Returns: a string representation of the argument in the specified radix.
    /// - Parameter i: an integer to be converted to a string.
    /// - Parameter radix: the radix to use in the string representation.
	static func java_toString​(i: Int, radix: Int) -> String {
		return String(UInt(i), radix: radix)
	}
	
    /// Returns an Integer object holding the value of the specified String. The argument is interpreted as representing a signed decimal integer, exactly as if the argument were given to the parseInt(java.lang.String) method. The result is an Integer object that represents the integer value specified by the string.
    ///
    /// In other words, this method returns an Integer object equal to the value of:
    ///
    ///     new Integer(Integer.parseInt(s))
    ///
    /// - Returns: an Integer object holding the value represented by the string argument.
    /// - Parameter s: the string to be parsed.
	static func java_valueOf​(_ s: String) throws -> Int {
        guard (s.count > 0) else { throw IntError.NumberFormatError }
        
        if let i = Int(s, radix: 10) { return i }
        else { throw IntError.NumberFormatError }
	}
	
    /// Returns an Integer object holding the value extracted from the specified String when parsed with the radix given by the second argument. The first argument is interpreted as representing a signed integer in the radix specified by the second argument, exactly as if the arguments were given to the parseInt(java.lang.String, int) method. The result is an Integer object that represents the integer value specified by the string.
    ///
    /// In other words, this method returns an Integer object equal to the value of:
    ///
    ///     new Integer(Integer.parseInt(s, radix))
    ///
    /// - Returns: an Integer object holding the value represented by the string argument in the specified radix.
    /// - Parameter s: the string to be parsed.
    /// - Parameter radix: the radix to be used in interpreting s
    /// - Throws: NumberFormatEror - if the String does not contain a parsable number.
	static func java_valueOf​(s: String, radix: Int) throws -> Int {
		return try Int.java_parseInt​(s: s, radix: radix)
	}

}
