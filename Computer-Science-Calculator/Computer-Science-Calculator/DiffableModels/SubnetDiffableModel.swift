//
//  SubnetDiffableModel.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 7/17/21.
//

import IGListDiffKit

class SubnetDiffableModel {
    private var identifier: String = UUID().uuidString

    public var id: String
    public var binarySubnet: String
    public var decimalSubnet: String
    public var broadcastAddress: String
    public var hostRange: String
    
    init(id: String, binarySubnet: String, decimalSubnet: String, broadcastAddress: String, hostRange: String) {
        self.id = id
        self.binarySubnet = binarySubnet
        self.decimalSubnet = decimalSubnet
        self.broadcastAddress = broadcastAddress
        self.hostRange = hostRange
    }
}
extension SubnetDiffableModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return identifier as NSString
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? SubnetDiffableModel else {
       return false
    }
    return self.identifier == object.identifier
  }
}
