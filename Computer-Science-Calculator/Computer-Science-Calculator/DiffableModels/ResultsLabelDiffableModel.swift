//
//  ResultsLabelDiffableModel.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/20/21.
//

import IGListDiffKit

class ResultsLabelDiffableModel {
    private var identifier: String = UUID().uuidString
    public var labelTitle: String

    init(labelTitle: String) {
        self.labelTitle = labelTitle
    }
}
extension ResultsLabelDiffableModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return identifier as NSString
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? ResultsLabelDiffableModel else {
       return false
    }
    return self.identifier == object.identifier
  }
}
