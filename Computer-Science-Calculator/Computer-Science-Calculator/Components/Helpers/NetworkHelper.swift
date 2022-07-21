//
//  NetworkHelper.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/20/21.
//

import Foundation
public class NetworkHelper {
    private static let octet: Int = 4
    private static let octet_size: Int = 8
    
    public func canConvertIpToBinary(array: [String]) -> Bool{
        if(array.count != NetworkHelper.octet) { return false }
        for item in array {
            if(item.count > 3) { return false }
            guard UInt8(item) != nil else { return false }
        }
        return true
    }
    
    public func canConvertIpToDecimal(array: [String]) -> Bool{
        if(array.count != NetworkHelper.octet) { return false }
        for item in array {
            if(item.count > NetworkHelper.octet_size) { return false }
            guard UInt8(item, radix: 2) != nil else { return false }
        }
        return true
    }
    
    public func canConvertToSubnetMask(text: String) -> Bool{
        guard let number = Int(text) else { return false }
        if number > 32 { return false }
        return true
    }
    
    public func convertIpToBinary(array: [String]) -> String{
        var convertedIp:[String] = []
        for item in array {
            guard let segment =  UInt8(item) else { return "" }
            convertedIp.append(makeLength(text: String(segment, radix: 2, uppercase: true), length: NetworkHelper.octet_size))
        }
        return convertedIp.joined(separator: ".")
    }
    
    public func convertIpToDecimal(array: [String]) -> String{
        var convertedIp:[String] = []
        for item in array {
            guard let segment =  UInt8(item, radix: 2) else { return "" }
            convertedIp.append("\(segment)")
        }
        return convertedIp.joined(separator: ".")
    }
    
    public func convertToSubnetMask(text: String) -> String{
        guard let number = Int(text) else { return "" }
        
        var maskBits: [String] = []
        for octet in 0 ... NetworkHelper.octet-1 {
            for bit in 0 ... NetworkHelper.octet_size - 1{
                maskBits.append(((octet * NetworkHelper.octet_size) + bit) < number ? "1" : "0")
            }
            if octet < 3 { maskBits.append(".") }
        }
        
        let maskAddress:[String] = maskBits.joined().components(separatedBy: CharacterSet(charactersIn: "."))
                
        if self.canConvertIpToDecimal(array: maskAddress) {
            return self.convertIpToDecimal(array: maskAddress)
        }
        
        return ""
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
