//
//  SelectorDiffableModel.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import IGListDiffKit

class SelectorDiffableModel {
    private var identifier: String = UUID().uuidString
    private(set) var options: [String]
    public var selectedIndex: Int
    private(set) var changed: ((Int) -> Void)?

    init(options: [String], selectedIndex: Int, changed: ((Int) -> Void)?) {
        self.options = options
        self.selectedIndex = selectedIndex
        self.changed = changed
    }
}
extension SelectorDiffableModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return identifier as NSString
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? SelectorDiffableModel else {
       return false
    }
    return self.identifier == object.identifier
  }
}
