//
//  ClearButtonDiffableModel.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import IGListDiffKit

class ClearButtonDiffableModel {
    private var identifier: String = UUID().uuidString
    private(set) var clear: (() -> Void)?

    init(clear: (() -> Void)?) {
        self.clear = clear
    }
}
extension ClearButtonDiffableModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return identifier as NSString
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? ClearButtonDiffableModel else {
       return false
    }
    return self.identifier == object.identifier
  }
}
