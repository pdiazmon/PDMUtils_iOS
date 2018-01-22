//
//  PDMString.swift
//  PDMUtils_iOS
//
//  Created by Pedro L. Diaz Montilla on 16/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

import Foundation

extension String {
	
	/// New subscript to get the nth character in a string
	///
	/// - Returns: the nth character of the string
	/// - Parameter index: the index of the character to get (zero-based)
    subscript (index: Int) -> Character? {
        get {
			if (index >= self.count && index >= 0) { return nil }
			else { return self.prefix(index+1).last }
        }
    }
	
	/// Checks if an string is numeric and all its characters are digits
	///
	/// - Returns: true if the string is numeric; false otherwise
	func pdmIsNumeric() -> Bool {
		for c in self {
			if (c < "0" || c > "9") { return false }
		}
		return true
	}
	

	/// Checks if an string is an hexadecimal number
	///
	/// - Returns: true if the string is hexadecimal; false otherwise
	func pdmIsHexadecimal() -> Bool {
		for c in self {
			if ((c < "0" || c > "9") && (c < "A" || c > "F")) { return false }
		}
		return true
	}
	
	/// Checks if an string is an octal number
	///
	/// - Returns: true if the string is octal; false otherwise
	func pdmIsOctal() -> Bool {
		for c in self {
			if (c < "0" || c > "7") { return false }
		}
		return true
	}

	/// Converts an string to an Integer number
	///
	/// - Returns: the integer if the string is convertible; nil otherwise
	func pdmToInt() -> Int? {
		guard (self.pdmIsNumeric()) else { return nil }
		
		return Int(self)!
	}
	
	/// Returns a substring for a given number of characters
	///
	/// - Returns: the integer if the string is convertible; nil otherwise
	/// - Parameter fromIndex: the index where the substring starts (zero-based)
	/// - Parameter numberOfCharacters: substring legth
	func pdmSubstring(fromIndex: Int, numberOfCharacters: Int) -> String? {
		guard (fromIndex >= 0)                                 else { return nil }
		guard (fromIndex < self.count)                         else { return nil }
		guard (numberOfCharacters > 0)                         else { return nil }
		guard (numberOfCharacters <= self.count)               else { return nil }
		guard ((fromIndex + numberOfCharacters) <= self.count) else { return nil }
		
		return String(self.prefix(fromIndex+numberOfCharacters).suffix(numberOfCharacters))
	}
}
