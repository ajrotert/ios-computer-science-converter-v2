//
//  NumbersHelper.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/13/21.
//

import Foundation

public class NumbersHelper {
    //Decimal conversions
    public func convertDecimalToBinary(decimal: Int?) -> String {
        if(decimal == nil) {
            return ""
        }
        return String(decimal!, radix: 2, uppercase: true)
    }
    public func convertDecimalToOctal(decimal: Int?) -> String {
        if(decimal == nil) {
            return ""
        }
        return String(decimal!, radix: 8, uppercase: true)
    }
    public func convertDecimalToHex(decimal: Int?) -> String {
        if(decimal == nil) {
            return ""
        }
        return String(decimal!, radix: 16, uppercase: true)
    }
    //Binary conversions
    public func convertBinaryToDecimal(binary: String) -> Int? {
        return Int(binary, radix: 2)
    }
    public func convertBinaryToOctal(binary: String) -> String{
        let decimal = convertBinaryToDecimal(binary: binary)
        return convertDecimalToOctal(decimal: decimal)
    }
    public func convertBinaryToHex(binary: String) -> String{
        let decimal = convertBinaryToDecimal(binary: binary)
        return convertDecimalToHex(decimal: decimal)
    }
    //Octal conversions
    public func convertOctalToDecimal(octal: String) -> Int? {
        return Int(octal, radix: 8)
    }
    public func convertOctalToBinary(octal: String) -> String{
        let decimal = convertOctalToDecimal(octal: octal)
        return convertDecimalToBinary(decimal: decimal)
    }
    public func convertOctalToHex(octal: String) -> String{
        let decimal = convertOctalToDecimal(octal: octal)
        return convertDecimalToHex(decimal: decimal)
    }
    //Hex conversions
    public func convertHexToDecimal(hex: String) -> Int? {
        return Int(hex, radix: 16)
    }
    public func convertHexToBinary(hex: String) -> String{
        let decimal = convertHexToDecimal(hex: hex)
        return convertDecimalToBinary(decimal: decimal)
    }
    public func convertHexToOctal(hex: String) -> String{
        let decimal = convertHexToDecimal(hex: hex)
        return convertDecimalToOctal(decimal: decimal)
    }
    
    //Signed 16 Int conversions
    private func twosComplement16Binary(num: Int16) -> String {
        var unsignedNum: UInt16 = 0
        if(num < 0){
            let a = Int(UInt16.max) + Int(num) + 1
            unsignedNum = UInt16(a)
        }
        else{
            return String(num, radix: 2, uppercase: true)
        }
        return String(unsignedNum, radix: 2, uppercase: true)
    }
    private func twosComplement16Hex(num: Int16) -> String {
        var unsignedNum: UInt16 = 0
        if(num < 0){
            let a = Int(UInt16.max) + Int(num) + 1
            unsignedNum = UInt16(a)
        }
        else{
            return String(num, radix: 16, uppercase: true)
        }
        return String(unsignedNum, radix: 16, uppercase: true)
    }
    public func convertSigned16DecimalToBinary(decimal: Int16?) -> String {
        if(decimal == nil) {
            return "0000000000000000"
        }
        return makeLength(text: twosComplement16Binary(num: decimal!), length: 16)
    }
    public func convertSigned16DecimalToHex(decimal: Int16?) -> String {
        if(decimal == nil) {
            return "0000"
        }
        return makeLength(text: twosComplement16Hex(num: decimal!), length: 4)
    }
    //Signed 32 Int conversions
    private func twosComplement32Binary(num: Int32) -> String {
        var unsignedNum: UInt32 = 0
        if(num < 0){
            let a = Int(UInt32.max) + Int(num) + 1
            unsignedNum = UInt32(a)
        }
        else{
            return String(num, radix: 2, uppercase: true)
        }
        return String(unsignedNum, radix: 2, uppercase: true)
    }
    private func twosComplement32Hex(num: Int32) -> String {
        var unsignedNum: UInt32 = 0
        if(num < 0){
            let a = Int(UInt32.max) + Int(num) + 1
            unsignedNum = UInt32(a)
        }
        else{
            return String(num, radix: 16, uppercase: true)
        }
        return String(unsignedNum, radix: 16, uppercase: true)
    }
    public func convertSigned32DecimalToBinary(decimal: Int32?) -> String {
        if(decimal == nil) {
            return "00000000000000000000000000000000"
        }
        return makeLength(text: twosComplement32Binary(num: decimal!), length: 32)
    }
    public func convertSigned32DecimalToHex(decimal: Int32?) -> String {
        if(decimal == nil) {
            return "00000000"
        }
        return makeLength(text: twosComplement32Hex(num: decimal!), length: 8)
    }
    //Signed binary conversions
    public func convertSignedBinaryToInteger16(binary: String) -> Int16{
        let number = Int16(bitPattern: UInt16(binary, radix: 2)!)
        return number
    }
    public func convertSignedBinaryToHex16(binary: String) -> String {
        let decimal = convertSignedBinaryToInteger16(binary: binary)
        return convertSigned16DecimalToHex(decimal: decimal)
    }
    public func convertSignedBinaryToInteger32(binary: String) -> Int32{
        let number = Int32(bitPattern: UInt32(binary, radix: 2)!)
        return number
    }
    public func convertSignedBinaryToHex32(binary: String) -> String {
        let decimal = convertSignedBinaryToInteger32(binary: binary)
        return convertSigned32DecimalToHex(decimal: decimal)
    }
    //Signed hex conversions
    public func convertSignedHexToInteger16(hex: String) -> Int16{
        let number = Int16(bitPattern: UInt16(hex, radix: 16)!)
        return number
    }
    public func convertSignedHexToBinary16(hex: String) -> String {
        let decimal = convertSignedHexToInteger16(hex: hex)
        return convertSigned16DecimalToBinary(decimal: decimal)
    }
    public func convertSignedHexToInteger32(hex: String) -> Int32{
        let number = Int32(bitPattern: UInt32(hex, radix: 16)!)
        return number
    }
    public func convertSignedHexToBinary32(hex: String) -> String {
        let decimal = convertSignedHexToInteger32(hex: hex)
        return convertSigned32DecimalToBinary(decimal: decimal)
    }
    
    
    
    private func makeLength(text: String, length: Int) -> String {
        var mutable = text
        if(length-1 >= text.count){
            for _ in 0 ... ((length - 1) - text.count) {
                mutable = "0" + mutable
            }
        }
        return mutable
    }
}
