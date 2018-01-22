//
//  StringJava.swift
//  PDMUtils_iOS
//
//  Created by Pedro L. Diaz Montilla on 17/1/18.
//  Copyright © 2018 Pedro L. Diaz Montilla. All rights reserved.
//

/*
** Port to Swift languaje of most of the String class methods in Java
** If you're moving from Java to Swift it could be useful in order to have a more readable and Java-like Swift code
*/

/*
** Some of the Java String methods are not ported yet:
*
 int codePointAt(int index) - Returns the character (Unicode code point) at the specified index.
 int codePointBefore(int index) - Returns the character (Unicode code point) before the specified index.
 int codePointCount(int beginIndex, int endIndex) - Returns the number of Unicode code points in the specified text range of this String.
 int compareTo(String anotherString) - Compares two strings lexicographically.
 int compareToIgnoreCase(String str) - Compares two strings lexicographically, ignoring case differences.
 static String format(Locale l, String format, Object... args) - Returns a formatted string using the specified locale, format string, and arguments.
 static String format(String format, Object... args) - Returns a formatted string using the specified format string and arguments.
 byte[] getBytes() - Encodes this String into a sequence of bytes using the platform's default charset, storing the result into a new byte array.
 byte[] getBytes(Charset charset) - Encodes this String into a sequence of bytes using the given charset, storing the result into a new byte array.
 void getBytes(int srcBegin, int srcEnd, byte[] dst, int dstBegin) - Deprecated.  This method does not properly convert characters into bytes. As of JDK 1.1, the preferred way to do this is via the getBytes() method, which uses the platform's default charset.
 byte[] getBytes(String charsetName) - Encodes this String into a sequence of bytes using the named charset, storing the result into a new byte array.
 boolean matches(String regex) - Tells whether or not this string matches the given regular expression.
 int offsetByCodePoints(int index, int codePointOffset) - Returns the index within this String that is offset from the given index by codePointOffset code points.
 String replaceAll(String regex, String replacement) - Replaces each substring of this string that matches the given regular expression with the given replacement.
 String replaceFirst(String regex, String replacement) -  Replaces the first substring of this string that matches the given regular expression with the given replacement.
 String[] split(String regex) - Splits this string around matches of the given regular expression.
 String[] split(String regex, int limit) - Splits this string around matches of the given regular expression.
 CharSequence subSequence(int beginIndex, int endIndex) - Returns a new character sequence that is a subsequence of this sequence.
 String toLowerCase(Locale locale) - Converts all of the characters in this String to lower case using the rules of the given Locale.
 String toUpperCase(Locale locale) - Converts all of the characters in this String to upper case using the rules of the given Locale.
 static String valueOf(long l) - Returns the string representation of the long argument.
 */

import Foundation

extension String {
	
	enum StringError: Error {
		case IndexOutOfBoundsError
	}
	
	/// Returns the char value at the specified index. An index ranges from 0 to length() - 1. The first char value of the sequence is at index 0, the next at index 1, and so on, as for array indexing.
	///
	///	If the char value specified by the index is a surrogate, the surrogate value is returned.
	///
	/// - Returns: the char value at the specified index of this string. The first char value is at index 0.
	/// - Parameter index: the index of the char value.
	/// - Throws: IndexOutOfBoundsError - if the index argument is negative or not less than the length of this string.
	func java_charAt(_ index: Int) throws -> Character {
		guard (index < self.count) else { throw StringError.IndexOutOfBoundsError }
		guard (index >= 0)         else { throw StringError.IndexOutOfBoundsError }
		
		return self.prefix(index+1).last!
	}

	/// Concatenates the specified string to the end of this string.
	///
	/// If the length of the argument string is 0, then this String object is returned. Otherwise, a String object is returned that represents a character sequence that is the concatenation of the character sequence represented by this String object and the character sequence represented by the argument string.
	///
	/// Examples:
	///
	///     "cares".concat("s") returns "caress"
	///     "to".concat("get").concat("her") returns "together"
	///
	/// - Returns: a string that represents the concatenation of this object's characters followed by the string argument's characters.
	/// - Parameter str: the String that is concatenated to the end of this String.
	func java_concat(_ str: String) -> String {
		return self + str
	}
	
	/// Compares this string to the specified CharSequence. The result is true if and only if this String represents the same sequence of char values as the specified sequence. Note that if the CharSequence is a StringBuffer then the method synchronizes on it.
	///
	/// - Returns: true if this String represents the same sequence of char values as the specified sequence, false otherwise
	/// - Parameter s: The sequence to compare this String against
	func java_contentEquals(_ s: String) -> Bool {
		return (self == s)
	}

	/// Equivalent to valueOf(char[]).
	///
	/// - Returns: a String that contains the characters of the character array.
	/// - Parameter data: the character array.
	static func java_copyValueOf(_ data: [Character]) -> String {
		var str: String = ""
		
		for c in data {
			str.append(c)
		}
		
		return str
	}
	
	/// Equivalent to valueOf(char[], int, int).
	///
	/// - Returns: a String that contains the characters of the specified subarray of the character array.
	/// - Parameter data: the character array.
	/// - Parameter offset: initial offset of the subarray.
	/// - Parameter count: length of the subarray.
	/// - Throws: IndexOutOfBoundsError - if offset is negative, or count is negative, or offset+count is larger than data.length.
	static func java_copyValueOf(data: [Character], offset: Int, count: Int) throws -> String {
		guard (offset > 0)                   else { throw StringError.IndexOutOfBoundsError }
		guard (count > 0)                    else { throw StringError.IndexOutOfBoundsError }
		guard (count <= data.count)          else { throw StringError.IndexOutOfBoundsError }
		guard (offset < data.count)          else { throw StringError.IndexOutOfBoundsError }
		guard (offset + count <= data.count) else { throw StringError.IndexOutOfBoundsError }
		
		return String(String.java_copyValueOf(data).prefix(offset+count).suffix(count))
	}

	/// Tests if this string ends with the specified suffix.
	///
	/// - Returns: true if the character sequence represented by the argument is a suffix of the character sequence represented by this object; false otherwise. Note that the result will be true if the argument is the empty string or is equal to this String object as determined by the equals(Object) method.
	/// - Parameter suffix: the suffix.
	func java_endsWith(_ suffix: String) -> Bool {
		return self.hasSuffix(suffix)
	}

	/// Compares this string to the specified object. The result is true if and only if the argument is not null and is a String object that represents the same sequence of characters as this object.
	///
	/// - Returns: true if the given object represents a String equivalent to this string, false otherwise
	/// - Parameter anObject: The object to compare this String against
	func java_equals(_ anObject: Any) -> Bool {
		guard (anObject is CustomStringConvertible) else { return false }
		
		return (self == (anObject as! CustomStringConvertible).description)
	}
	
	/// Compares this String to another String, ignoring case considerations. Two strings are considered equal ignoring case if they are of the same length and corresponding characters in the two strings are equal ignoring case.
	///
	/// Two characters c1 and c2 are considered the same ignoring case if at least one of the following is true:
	/// * The two characters are the same (as compared by the == operator)
	/// * Calling Character.toLowerCase(Character.toUpperCase(char)) on each character produces the same result
	//// Note that this method does not take locale into account, and will result in unsatisfactory results for certain locales.
	///
	/// - Returns: true if the argument is not null and it represents an equivalent String ignoring case; false otherwise
	/// - Parameter anotherString: The String to compare this String against
	func java_equalsIgnoreCase(_ anotherString: String) -> Bool {
		return (self.uppercased() == anotherString.uppercased())
	}

	/// Copies characters from this string into the destination character array.
	///
	/// The first character to be copied is at index srcBegin; the last character to be copied is at index srcEnd-1 (thus the total number of characters to be copied is srcEnd-srcBegin). The characters are copied into the subarray of dst starting at index dstBegin and ending at index:
	///
	///     dstBegin + (srcEnd-srcBegin) - 1
	///
	/// - Parameter srcBegin: index of the first character in the string to copy.
	/// - Parameter srcEnd: index after the last character in the string to copy.
	/// - Parameter dst: the destination array.
	/// - Parameter dstBegin: the start offset in the destination array.
	/// - Throws: IndexOutOfBoundsException - If any of the following is true: srcBegin is negative; srcBegin is greater than srcEnd; srcEnd is greater than the length of this string; dstBegin is negative; dstBegin+(srcEnd-srcBegin) is larger than dst.length
	func java_getChars(srcBegin: Int, srcEnd: Int, dst: inout [Character], dstBegin: Int) throws {
		guard (srcBegin >= 0)                           else { throw StringError.IndexOutOfBoundsError }
		guard (srcBegin <= srcEnd)                      else { throw StringError.IndexOutOfBoundsError }
		guard (srcEnd <= self.count)                    else { throw StringError.IndexOutOfBoundsError }
		guard (dstBegin >= 0)                           else { throw StringError.IndexOutOfBoundsError }
		guard (dstBegin+(srcEnd-srcBegin) <= dst.count) else { throw StringError.IndexOutOfBoundsError }

		var contDest: Int = 0

		for i in srcBegin..<srcEnd {
			try dst[dstBegin + contDest] = self.java_charAt(i)
			contDest += 1
		}
	}
	
	/// Returns a hash code for this string.
	///
	/// - Returns: a hash code value for this object.
	func java_hashCode() -> Int {
		return self.hashValue
	}
	
	/// Returns the index within this string of the first occurrence of the specified character. If a character with value ch occurs in the character sequence represented by this String object, then the index (in Unicode code units) of the first such occurrence is returned. For values of ch in the range from 0 to 0xFFFF (inclusive), this is the smallest value k such that:
	///
	///     this.charAt(k) == ch
	/// is true. For other values of ch, it is the smallest value k such that:
	///     this.codePointAt(k) == ch
	///	is true. In either case, if no such character occurs in this string, then nil is returned.
	///
	/// - Returns: the index of the first occurrence of the character in the character sequence represented by this object, or nil if the character does not occur.
	/// - Parameter ch: a character (Unicode code point).
	func java_indexOf(ch: Character) -> Int? {
		guard let index = self.index(of: ch) else { return nil }
		
		return self.distance(from: self.startIndex, to: index)
	}

	/// Returns the index within this string of the first occurrence of the specified character, starting the search at the specified index.
	///
	/// If a character with value ch occurs in the character sequence represented by this String object at an index no smaller than fromIndex, then the index of the first such occurrence is returned. For values of ch in the range from 0 to 0xFFFF (inclusive), this is the smallest value k such that:
	///
	///     (this.charAt(k) == ch) && (k >= fromIndex)
	///	is true. For other values of ch, it is the smallest value k such that:
	///
	///     (this.codePointAt(k) == ch) && (k >= fromIndex)
	///	is true. In either case, if no such character occurs in this string at or after position fromIndex, then nil is returned.
	///
	/// There is no restriction on the value of fromIndex. If it is negative, it has the same effect as if it were zero: this entire string may be searched. If it is greater than the length of this string, it has the same effect as if it were equal to the length of this string: nil is returned.
	///
	/// All indices are specified in char values (Unicode code units).
	///
	/// - Returns: the index of the first occurrence of the character in the character sequence represented by this object that is greater than or equal to fromIndex, or -1 if the character does not occur.
	/// - Parameter ch: a character (Unicode code point).
	/// - Parameter fromIndex: the index to start the search from.
	func java_indexOf(ch: Character, fromIndex: Int) -> Int? {
		guard (fromIndex < self.count) else { return nil }
		
		let wfromIndex: Int = (fromIndex < 0 ? 0 : fromIndex)
		
		if let i = self.dropFirst(wfromIndex).description.java_indexOf(ch: ch) { return i + wfromIndex }
		else { return nil }
	}

	/// Returns the index within this string of the first occurrence of the specified substring.
	///
	/// The returned index is the smallest value k for which:
	///
	///      this.startsWith(str, k)
	/// If no such value of k exists, then nil is returned.
	///
	/// - Returns: the index of the first occurrence of the specified substring, or nil if there is no such occurrence.
	/// - Parameter str: the substring to search for.
	func java_indexOf(str: String) -> Int? {
		guard (str.count > 0) else { return nil }
		
		var i: Int = 0
		
		while i < self.count {
			if (self[i] == str.first) {
				if(str == String(self.dropFirst(i).prefix(str.count))) { return i }
			}
			i += 1
		}
		
		return nil
	}
	
	/// Returns the index within this string of the first occurrence of the specified substring, starting at the specified index.
	///
	/// The returned index is the smallest value k for which:
	///
	///     k >= Math.min(fromIndex, this.length())
	///     && this.startsWith(str, k)
	/// If no such value of k exists, then nil is returned.
	///
	/// - Returns: the index of the first occurrence of the specified substring, starting at the specified index, or nil if there is no such occurrence.
	/// - Parameter str: the substring to search for.
	/// - Parameter fromIndex: the index from which to start the search.
	func java_indexOf(str: String, fromIndex: Int) -> Int? {
		guard (fromIndex < self.count) else { return nil }
		guard (fromIndex >= 0)         else { return nil }
		guard (str.count > 0)          else { return nil }
		
		if let i = String(self.dropFirst(fromIndex).prefix(self.count-fromIndex)).java_indexOf(str: str) {
			return i + fromIndex
		}
		else {
			return nil
		}
	}

	/// Returns a canonical representation for the string object.
	///
	/// A pool of strings, initially empty, is maintained privately by the class String.
	///
	/// When the intern method is invoked, if the pool already contains a string equal to this String object as determined by the equals(Object) method, then the string from the pool is returned. Otherwise, this String object is added to the pool and a reference to this String object is returned.
	///
	/// It follows that for any two strings s and t, s.intern() == t.intern() is true if and only if s.equals(t) is true.
	///
	/// All literal strings and string-valued constant expressions are interned. String literals are defined in section 3.10.5 of the The Java™ Language Specification.
	///
	/// - Returns: a string that has the same contents as this string, but is guaranteed to be from a pool of unique strings.
	func java_intern() -> String {
		return self.description
	}

	/// Returns the index within this string of the last occurrence of the specified character. For values of ch in the range from 0 to 0xFFFF (inclusive), the index (in Unicode code units) returned is the largest value k such that:
	///
	///     this.charAt(k) == ch
	/// is true. For other values of ch, it is the largest value k such that:
	///
	///     this.codePointAt(k) == ch
	///	is true. In either case, if no such character occurs in this string, then nil is returned. The String is searched backwards starting at the last character.
	///
	/// - Returns: the index of the last occurrence of the character in the character sequence represented by this object, or nil if the character does not occur.
	/// - Parameter ch: a character (Unicode code point).
	func java_lastIndexOf(ch: Character) -> Int? {
		return java_lastIndexOf(str: String(ch))
	}

	/// Returns the index within this string of the last occurrence of the specified character, searching backward starting at the specified index. For values of ch in the range from 0 to 0xFFFF (inclusive), the index returned is the largest value k such that:
	///
	///     (this.charAt(k) == ch) && (k <= fromIndex)
	/// is true. For other values of ch, it is the largest value k such that:
	///
	///     (this.codePointAt(k) == ch) && (k <= fromIndex)
	///	is true. In either case, if no such character occurs in this string at or before position fromIndex, then nil is returned.
	///
	/// All indices are specified in char values (Unicode code units).
	///
	/// - Returns: the index of the last occurrence of the character in the character sequence represented by this object that is less than or equal to fromIndex, or -1 if the character does not occur before that point.
	/// - Parameter ch: a character (Unicode code point).
	/// - Parameter fromIndex: the index to start the search from. There is no restriction on the value of fromIndex. If it is greater than or equal to the length of this string, it has the same effect as if it were equal to one less than the length of this string: this entire string may be searched. If it is negative, it has the same effect as if it were -1: nil is returned.
	func java_lastIndexOf(ch: Character, fromIndex: Int) -> Int? {
		guard (fromIndex >= 0)         else { return nil }
		
		let wfromIndex = (fromIndex >= self.count) ? self.count-1 : fromIndex
		
		return java_lastIndexOf(str: String(ch), fromIndex: wfromIndex)
	}

	/// Returns the index within this string of the last occurrence of the specified substring. The last occurrence of the empty string "" is considered to occur at the index value this.length().
	///
	/// The returned index is the largest value k for which:
	///
	///     this.startsWith(str, k)
	///	If no such value of k exists, then nil is returned.
	///
	/// - Returns: the index of the last occurrence of the specified substring, or nil if there is no such occurrence.
	/// - Parameter str: the substring to search for.
	func java_lastIndexOf(str: String) -> Int? {
		guard (str.count > 0) else { return nil }
		
		for i in stride(from: self.count - str.count, through:0, by: -1) {
			if (String(self.dropFirst(i)).hasPrefix(str)) { return i }
		}
		
		return nil
	}

	/// Returns the index within this string of the last occurrence of the specified substring, searching backward starting at the specified index.
	///
	/// The returned index is the largest value k for which:
	///
	///     k <= Math.min(fromIndex, this.length()) &&
	///     this.startsWith(str, k)
	///
	/// If no such value of k exists, then nil is returned.
	///
	/// - Returns: the index of the last occurrence of the specified substring, searching backward from the specified index, or nil if there is no such occurrence.
	/// - Parameter str: the substring to search for.
	/// - Parameter fromIndex: the index to start the search from.
	func java_lastIndexOf(str: String, fromIndex: Int) -> Int? {
		guard (fromIndex >= 0)         else { return nil }
		guard (fromIndex < self.count) else { return nil }
		
		if let i = String(self.dropFirst(fromIndex)).java_lastIndexOf(str: str) { return i + fromIndex }
		else { return nil }
	}

	/// Returns the length of this string. The length is equal to the number of Unicode code units in the string.
	///
	/// - Returns: the length of the sequence of characters represented by this object.
	func java_length() -> Int {
		return self.count
	}

	/// Tests if two string regions are equal.
	///
	/// A substring of this String object is compared to a substring of the argument other. The result is true if these substrings represent character sequences that are the same, ignoring case if and only if ignoreCase is true. The substring of this String object to be compared begins at index toffset and has length len. The substring of other to be compared begins at index ooffset and has length len. The result is false if and only if at least one of the following is true:
	///	* toffset is negative.
	///	* ooffset is negative.
	///	* toffset+len is greater than the length of this String object.
	///	* ooffset+len is greater than the length of the other argument.
	///	* ignoreCase is false and there is some nonnegative integer k less than len such that:
	///
	///       this.charAt(toffset+k) != other.charAt(ooffset+k)
	/// * ignoreCase is true and there is some nonnegative integer k less than len such that:
	///
	///       Character.toLowerCase(Character.toUpperCase(this.charAt(toffset+k))) !=
	///       Character.toLowerCase(Character.toUpperCase(other.charAt(ooffset+k)))
	/// Note that this method does not take locale into account, and will result in unsatisfactory results for certain locales when ignoreCase is true.
	///
	/// - Returns: true if the specified subregion of this string matches the specified subregion of the string argument; false otherwise. Whether the matching is exact or case insensitive depends on the ignoreCase argument.
	/// - Parameter ignoreCase: if true, ignore case when comparing characters.
	/// - Parameter toffset: the starting offset of the subregion in this string.
	/// - Parameter other: the string argument.
	/// - Parameter ooffset: the starting offset of the subregion in the string argument.
	/// - Parameter len: the number of characters to compare.
	func java_regionMatches(ignoreCase: Bool, toffset: Int, other: String, ooffset: Int, len: Int) -> Bool {
		guard (toffset >= 0)                       else { return false }
		guard (toffset+len <= self.count)          else { return false }
		guard (toffset < self.count)               else { return false }
		guard (ooffset >= 0)                       else { return false }
		guard (ooffset+len <= other.count)         else { return false }
		guard (ooffset < other.count)              else { return false }
		guard (len > 0)                            else { return false }
		guard (len < min(self.count, other.count)) else { return false }
		
		var wst = String(self.dropFirst(toffset).prefix(len))
		var wso = String(other.dropFirst(ooffset).prefix(len))
		
		wst = (ignoreCase ? wst.uppercased() : wst)
		wso = (ignoreCase ? wso.uppercased() : wso)
		
		return wst == wso
	}

	/// Tests if two string regions are equal.
	///
	/// A substring of this String object is compared to a substring of the argument other. The result is true if these substrings represent identical character sequences. The substring of this String object to be compared begins at index toffset and has length len. The substring of other to be compared begins at index ooffset and has length len. The result is false if and only if at least one of the following is true:
	/// * toffset is negative.
	/// * ooffset is negative.
	/// * toffset+len is greater than the length of this String object.
	/// * ooffset+len is greater than the length of the other argument.
	/// * There is some nonnegative integer k less than len such that: this.charAt(toffset + k) != other.charAt(ooffset + k)
	/// Note that this method does not take locale into account.
	///
	/// - Returns: true if the specified subregion of this string exactly matches the specified subregion of the string argument; false otherwise.
	/// - Parameter toffset: the starting offset of the subregion in this string.
	/// - Parameter other: the string argument.
	/// - Parameter ooffset: the starting offset of the subregion in the string argument.
	/// - Parameter len: the number of characters to compare.
	func java_regionMatches(toffset: Int, other: String, ooffset: Int, len: Int) -> Bool {
		return java_regionMatches(ignoreCase: false, toffset: toffset, other: other, ooffset: ooffset, len: len)
	}

	/// Returns a string resulting from replacing all occurrences of oldChar in this string with newChar.
	///
	/// If the character oldChar does not occur in the character sequence represented by this String object, then a reference to this String object is returned. Otherwise, a String object is returned that represents a character sequence identical to the character sequence represented by this String object, except that every occurrence of oldChar is replaced by an occurrence of newChar.
	///
	/// Examples:
	///
	/// 	"mesquite in your cellar".replace('e', 'o')
	///		returns "mosquito in your collar"
	///		"the war of baronets".replace('r', 'y')
	///		returns "the way of bayonets"
	///		"sparring with a purple porpoise".replace('p', 't')
	///		returns "starring with a turtle tortoise"
	///		"JonL".replace('q', 'x') returns "JonL" (no change)
	///
	/// - Returns: a string derived from this string by replacing every occurrence of oldChar with newChar.
	/// - Parameter oldChar: the old character.
	/// - Parameter newChar: the new character.
	func java_replace(oldChar: Character, newChar: Character) -> String? {
		return java_replace(target: String(oldChar), replacement: String(newChar))
	}

	/// Replaces each substring of this string that matches the literal target sequence with the specified literal replacement sequence. The replacement proceeds from the beginning of the string to the end, for example, replacing "aa" with "b" in the string "aaa" will result in "ba" rather than "ab".
	///
	/// - Returns: The resulting string
	/// - Parameter target: The sequence of char values to be replaced
	/// - Parameter replacement: The replacement sequence of char values
	func java_replace(target: String, replacement: String) -> String? {
		guard (target.count > 0) else { return nil }

		if let i = self.java_indexOf(str: target) {
			return String(self.prefix(i)) + replacement + String(self.dropFirst(i+target.count))
		}
		else { return nil }
	}

	/// Tests if this string starts with the specified prefix.
	///
	/// - Returns: true if the character sequence represented by the argument is a prefix of the character sequence represented by this string; false otherwise. Note also that true will be returned if the argument is an empty string or is equal to this String object as determined by the equals(Object) method.
	/// - Parameter prefix: the prefix.
	func java_startsWith(_ prefix: String) -> Bool {
		guard (prefix.count > 0) else { return false }
		
		return self.hasPrefix(prefix)
	}

	/// Tests if the substring of this string beginning at the specified index starts with the specified prefix.
	///
	/// - Returns: true if the character sequence represented by the argument is a prefix of the substring of this object starting at index toffset; false otherwise. The result is false if toffset is negative or greater than the length of this String object; otherwise the result is the same as the result of the expression
	///
	///		this.substring(toffset).startsWith(prefix)
	/// - Parameter prefix: the prefix.
	/// - Parameter toffset: where to begin looking in this string.
	func java_startsWith(prefix: String, toffset: Int) -> Bool {
		guard (prefix.count > 0)     else { return false }
		guard (toffset > 0)          else { return false }
		guard (toffset < self.count) else { return false }
		
		return String(self.dropFirst(toffset)).java_startsWith(prefix)
	}

	/// Returns a string that is a substring of this string. The substring begins with the character at the specified index and extends to the end of this string.
	///
	/// Examples:
	///
	///		"unhappy".substring(2) returns "happy"
	///		"Harbison".substring(3) returns "bison"
	///		"emptiness".substring(9) returns "" (an empty string)
	///
	/// - Returns: the specified substring.
	/// - Parameter beginIndex: the beginning index, inclusive.
	/// - Throws: IndexOutOfBoundsError - if beginIndex is negative or larger than the length of this String object.
	func java_substring(beginIndex: Int) throws -> String? {
		guard (beginIndex >= 0)         else { throw StringError.IndexOutOfBoundsError }
		guard (beginIndex < self.count) else { throw StringError.IndexOutOfBoundsError }
		
		return String(self.dropFirst(beginIndex))
	}

	/// Returns a string that is a substring of this string. The substring begins at the specified beginIndex and extends to the character at index endIndex - 1. Thus the length of the substring is endIndex-beginIndex.
	/// Examples:
	///
	///		"hamburger".substring(4, 8) returns "urge"
	///		"smiles".substring(1, 5) returns "mile"
	///
	/// - Returns: the specified substring.
	/// - Parameter beginIndex: the beginning index, inclusive.
	/// - Parameter endIndex: the ending index, exclusive.
	/// - Throws: IndexOutOfBoundsError - if the beginIndex is negative, or endIndex is larger than the length of this String object, or beginIndex is larger than endIndex.
	func java_substring(beginIndex: Int, endIndex: Int) throws -> String? {
		guard (beginIndex >= 0)         else { throw StringError.IndexOutOfBoundsError }
		guard (beginIndex <= endIndex)  else { throw StringError.IndexOutOfBoundsError }
		guard (endIndex <= self.count)  else { throw StringError.IndexOutOfBoundsError }
		guard (self.count > 0)          else { throw StringError.IndexOutOfBoundsError }
		
		return String(self.prefix(endIndex).suffix(endIndex-beginIndex))
	}

	/// Converts this string to a new character array.
	///
	/// - Returns: a newly allocated character array whose length is the length of this string and whose contents are initialized to contain the character sequence represented by this string.
	func java_toCharArray() -> [Character] {
		var wa: [Character] = []
		
		for c in self {
			wa.append(c)
		}
		
		return wa
	}

	/// Converts all of the characters in this String to lower case using the rules of the default locale. This is equivalent to calling toLowerCase(Locale.getDefault()).
	///
	///	**Note:** This method is locale sensitive, and may produce unexpected results if used for strings that are intended to be interpreted locale independently. Examples are programming language identifiers, protocol keys, and HTML tags. For instance, "TITLE".toLowerCase() in a Turkish locale returns "t\u0131tle", where '\u0131' is the LATIN SMALL LETTER DOTLESS I character. To obtain correct results for locale insensitive strings, use toLowerCase(Locale.ROOT).
	///
	/// - Returns: the String, converted to lowercase.
	func java_toLowerCase() -> String {
		return self.lowercased()
	}

	/// This object (which is already a string!) is itself returned.
	///
	/// - Returns: the string itself.
	func java_toString() -> String {
		return self
	}

	/// Converts all of the characters in this String to upper case using the rules of the default locale. This method is equivalent to toUpperCase(Locale.getDefault()).
	///
	/// **Note:** This method is locale sensitive, and may produce unexpected results if used for strings that are intended to be interpreted locale independently. Examples are programming language identifiers, protocol keys, and HTML tags. For instance, "title".toUpperCase() in a Turkish locale returns "T\u0130TLE", where '\u0130' is the LATIN CAPITAL LETTER I WITH DOT ABOVE character. To obtain correct results for locale insensitive strings, use toUpperCase(Locale.ROOT).
	///
	/// - Returns:the String, converted to uppercase.
	func java_toUpperCase() -> String {
		return self.uppercased()
	}

	/// Returns a string whose value is this string, with any leading and trailing whitespace removed.
	///
	///	If this String object represents an empty character sequence, or the first and last characters of character sequence represented by this String object both have codes greater than '\u0020' (the space character), then a reference to this String object is returned.
	///
	///	Otherwise, if there is no character with a code greater than '\u0020' in the string, then a String object representing an empty string is returned.
	///
	///	Otherwise, let k be the index of the first character in the string whose code is greater than '\u0020', and let m be the index of the last character in the string whose code is greater than '\u0020'. A String object is returned, representing the substring of this string that begins with the character at index k and ends with the character at index m-that is, the result of this.substring(k, m + 1).
	///
	///	This method may be used to trim whitespace (as defined above) from the beginning and end of a string.
	///
	/// - Returns: A string whose value is this string, with any leading and trailing white space removed, or this string if it has no leading or trailing white space.
	func java_trim() -> String {
		return self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
	}

	/// Returns the string representation of the boolean argument.
	///
	/// - Returns: if the argument is true, a string equal to "true" is returned; otherwise, a string equal to "false" is returned.
	/// - Parameter b: a boolean.
	static func java_valueOf(_ b: Bool) -> String {
		return b.description
	}

	/// Returns the string representation of the char argument.
	///
	/// - Returns: a string of length 1 containing as its single character the argument c.
	/// - Parameter c: a char.
	static func java_valueOf(_ c: Character) -> String {
		return String(c)
	}
	
	/// Returns the string representation of the char array argument. The contents of the character array are copied; subsequent modification of the character array does not affect the returned string.
	///
	/// - Returns: a String that contains the characters of the character array.
	/// - Parameter data: the character array.
	static func java_valueOf(_ data: [Character]) -> String {
		return data.description
	}

	/// Returns the string representation of a specific subarray of the char array argument.
	///
	///	The offset argument is the index of the first character of the subarray. The count argument specifies the length of the subarray. The contents of the subarray are copied; subsequent modification of the character array does not affect the returned string.
	///
	/// - Returns: a String that contains the characters of the specified subarray of the character array.
	/// - Parameter data: the character array.
	/// - Parameter offset: initial offset of the subarray.
	/// - Parameter count: length of the subarray.
	/// - Throws: IndexOutOfBoundsError - if offset is negative, or count is negative, or offset+count is larger than data.length.
	static func java_valueOf(data: [Character], offset: Int, count: Int) throws -> String? {
		guard (offset >= 0)                else { throw StringError.IndexOutOfBoundsError }
		guard (offset < data.count)        else { throw StringError.IndexOutOfBoundsError }
		guard (count >= 0)                 else { throw StringError.IndexOutOfBoundsError }
		guard (count < data.count)         else { throw StringError.IndexOutOfBoundsError }
		guard (offset+count <= data.count) else { throw StringError.IndexOutOfBoundsError }

		var ws: String = "["

		for i in offset...(offset+count-1) {
			if (ws.count>1) { ws.append(", ") }
			ws.append("\"")
			ws.append(data[i])
			ws.append("\"")
		}
		ws.append("]")
		return ws
	}

	/// Returns the string representation of the double argument.
	///
	///	The representation is exactly the one returned by the Double.toString method of one argument.
	///
	/// - Returns: a string representation of the double argument.
	/// - Parameter d: a double.
	static func java_valueOf(_ d: Double) -> String {
		return d.description
	}

	/// Returns the string representation of the float argument.
	///
	///	The representation is exactly the one returned by the Float.toString method of one argument.
	///
	/// - Returns: a string representation of the float argument.
	/// - Parameter f: a float.
	static func java_valueOf(_ f: Float) -> String {
		return f.description
	}

	/// Returns the string representation of the int argument.
	///
	///	The representation is exactly the one returned by the Int.toString method of one argument.
	///
	/// - Returns: a string representation of the int argument.
	/// - Parameter i: an int.
	static func java_valueOf(_ i: Int) -> String {
		return i.description
	}

	/// Returns the string representation of the Object argument.
	///
	/// - Returns: if the argument is null, then a string equal to "null"; otherwise, the value of obj.toString() is returned.
	/// - Parameter obj: an Object.
	static func java_valueOf(_ obj: Any) -> String? {
		guard (obj is CustomStringConvertible) else { return nil }
		
		return (obj as! CustomStringConvertible).description
	}
}
