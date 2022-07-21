//
//  LabelDiffableModel.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import IGListDiffKit

class LabelDiffableModel {
    private var identifier: String = UUID().uuidString
    private(set) var labelTitle: String

    init(labelTitle: String) {
        self.labelTitle = labelTitle
    }
}
extension LabelDiffableModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return identifier as NSString
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? LabelDiffableModel else {
       return false
    }
    return self.identifier == object.identifier
  }
}
