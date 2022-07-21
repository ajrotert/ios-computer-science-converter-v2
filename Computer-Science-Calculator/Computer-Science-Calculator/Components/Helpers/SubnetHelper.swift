//
//  SubnetHelper.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 7/11/21.
//

import Foundation
public class SubnetHelper {
    
    private let formattedIpAddressSize = 35
    public let ipAddressOctet = 4;
    public let ipAddressOctetSize = 8;
    
    func findStartPosition(binarySubnetMaskAddress: String) -> Int{
        var position:Int = 0;
        
        for i in 0..<formattedIpAddressSize {
            if binarySubnetMaskAddress[i] == "1" {
                position = i
                if(binarySubnetMaskAddress[i+1] == "."){
                    position += 1
                }
            }
        }
        
        return position;
    }
    
    func findByteSpace(numberSubnets: Int) -> Int{
        if(numberSubnets > 0){
            return Int(ceilf(log2(Float(numberSubnets))))
        }
        return 0
    }
    
    func validateSubnetAmount(startPosition: Int, numberSubnets: Int, byteSpace: Int) -> Bool {
        return !(byteSpace + startPosition > formattedIpAddressSize - 1 || numberSubnets <= 1);
    }
    
    func getIpAddressClass(firstOctet: String) -> String {
        guard let firstOctetValue = UInt8(firstOctet) else {
            return "Unknown Class"
        }
        if (firstOctetValue > 0 && firstOctetValue < 127){
            return "Class A"
        }
        else if (firstOctetValue >= 127 && firstOctetValue < 192){
            return "Class B"
        }
        else if (firstOctetValue >= 192 && firstOctetValue < 224){
            return "Class C"
        }
        else if (firstOctetValue >= 224 && firstOctetValue < 240){
            return "Class D"
        }
        else {
            return "Class E"
        }
    }
    
    func getSubnetAddress(binaryIpAddress: String, binarySubnetMask: String) -> String {
        var subnetAddress: String = ""
        for index in 0..<formattedIpAddressSize {
            subnetAddress += binaryIpAddress[index] != "0" && binarySubnetMask[index] != "0" ? binaryIpAddress[index] : "0"
        }
        
        return subnetAddress
    }
    
    func makeSubnets(startPosition: Int, numberSubnets: Int, byteSpace: Int, subnetAddress: String) -> [String]{
        
        var subnetArray = [String]()
        
        for i: Int in 0 ..< numberSubnets {
            let subnetId = convertDecimalToBinary(size: byteSpace, number: i)
            var count = 0
            var subnetString: String = ""
            for j in 0 ..< formattedIpAddressSize {
                if (subnetAddress[j] == ".") {
                    subnetString += ".";
                }
                else if (j >= startPosition + 1 && count < subnetId.count) {
                    subnetString += subnetId[count];
                    count += 1;
                }
                else {
                    subnetString += subnetAddress[j];
                }
            }
            
            subnetArray.append(subnetString)
        }
        
        return subnetArray
    }
    /*
     for (int i = 0; i < _subnets; i++)
     {
         string subnetID = Decimal.Convert_To_Binary(_byteSpace, i);
         int count = 0;
         subnetArray[i, 0] = "";
         for (int j = 0; j < IPAddressSize; j++)
         {
             if (subnetAddress[j] == '.')
             {
                 subnetArray[i, 0] += '.';
             }
             else if (j >= _startingLocation + 1 && count < subnetID.Length)
             {
                 subnetArray[i, 0] += subnetID[count];
                 count++;
             }
             else
             {
                 subnetArray[i, 0] += subnetAddress[j];
             }
         }

         string[] temp = getFormattedString(subnetArray[i, 0], getDecimalSubnet(i), getBroadcast(i), getHostRange(i), i, _subnets);
         subnetArray[i, 0] = temp[0];
         subnetArray[i, 1] = temp[1];
         subnetArray[i, 2] = temp[2];
     }
     return subnetArray;
     */
       
    func getBinaryBroadcastAddress(startingLocation: Int, binarySubnet: String, byteSpace: Int) -> String {
        var counter = 0
        var binaryBroadcastAddress = ""
        
        for i in 0..<formattedIpAddressSize {
                        
            if (i > startingLocation && counter >= byteSpace && binarySubnet[i] != "."){
                    binaryBroadcastAddress.append("1")
            }
            else {
                binaryBroadcastAddress.append(binarySubnet[i])
            }
            if(i > startingLocation && binarySubnet[i] != "."){
                counter += 1
            }
        }
        
        return binaryBroadcastAddress
    }
    
    func getBinaryHostLowerAddress(binarySubnet: String) -> String{
        var binarySubnetCopy = binarySubnet
        binarySubnetCopy.removeLast()
        binarySubnetCopy.append("1")
        return binarySubnetCopy
    }
    func getBinaryHostHigherAddress(binaryBroadcastAddress: String) -> String{
        var binaryBroadcastAddressCopy = binaryBroadcastAddress
        binaryBroadcastAddressCopy.removeLast()
        binaryBroadcastAddressCopy.append("0")
        return binaryBroadcastAddressCopy
    }
    
    func getTotalHosts(binarySubnetMask: String, byteSpace: Int) -> String {
        let numberOfHostBits = (ipAddressOctet*ipAddressOctetSize) - findHostSpace(binarySubnetMask: binarySubnetMask, byteSpace: byteSpace)
        return String(Int(powf(2, Float(numberOfHostBits)) - 2))
    }
    
    private func findHostSpace(binarySubnetMask: String, byteSpace: Int) -> Int {
        var position = 0
        var counter = 1
        for i in 0 ..< formattedIpAddressSize {
            if binarySubnetMask[i] == "1" {
                position = counter
            }
            else if binarySubnetMask[i] == "."{
                counter -= 1
            }
            counter += 1
        }
        return position + byteSpace
    }
    
    private func convertDecimalToBinary(size: Int, number: Int) -> String{
        return makeLength(text: String(number, radix: 2, uppercase: true), length: size)
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
