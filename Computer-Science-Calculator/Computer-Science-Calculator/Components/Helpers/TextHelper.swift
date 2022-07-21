//
//  TextHelper.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/15/21.
//

import Foundation

public class TextHelper {
    //String conversions
    public func convertStringToDecimalString(text: String) -> String {
        var decimalString = ""
        for char in Array(text){
            decimalString += "\(char.asciiValue ?? 0) "
        }
        return decimalString
    }
    public func convertStringToBinaryString(text: String) -> String {
        var binaryString = ""
        for char in Array(text){
            binaryString += "\(String((char.asciiValue ?? 0), radix: 2, uppercase: true)) "
        }
        return binaryString
    }
    public func convertStringToHexString(text: String) -> String {
        var hexString = ""
        for char in Array(text){
            hexString += "\(String((char.asciiValue ?? 0), radix: 16, uppercase: true)) "
        }
        return hexString
    }
    //Decimal conversions
    public func convertDecimalStringToString(text: String) -> String{
        guard let number = Int(text) else { return "" }
        return "\(Character(UnicodeScalar(number)!))"
    }
    public func convertDecimalStringToBinary(text: String) -> String{
        guard let number = Int(text) else { return "" }
        return "\(String(number, radix: 2, uppercase: true))"
    }
    public func convertDecimalStringToHex(text: String) -> String{
        guard let number = Int(text) else { return "" }
        return "\(String(number, radix: 16, uppercase: true))"
    }
    //Binary conversions
    public func convertBinaryStringToString(text: String) -> String{
        guard let number = UInt16(text, radix: 2) else { return "" }
        return "\(Character(UnicodeScalar(number) ?? UnicodeScalar(0)))"
    }
    public func convertBinaryStringToDecimal(text: String) -> String{
        guard let number = Int(text, radix: 2) else { return "" }
        return "\(number)"
    }
    public func convertBinaryStringToHex(text: String) -> String{
        guard let number = Int(text, radix: 2) else { return "" }
        return "\(String(number, radix: 16, uppercase: true))"
    }
    //Hex conversions
    public func convertHexStringToString(text: String) -> String{
        guard let number = UInt16(text, radix: 16) else { return "" }
        return "\(Character(UnicodeScalar(number) ?? UnicodeScalar(0)))"
    }
    public func convertHexStringToDecimal(text: String) -> String{
        guard let number = Int(text, radix: 16) else { return "" }
        return "\(number)"
    }
    public func convertHexStringToBinary(text: String) -> String{
        guard let number = Int(text, radix: 16) else { return "" }
        return "\(String(number, radix: 2, uppercase: true))"
    }
}
