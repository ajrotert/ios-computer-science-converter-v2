//
//  TextfieldDiffableModel.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import IGListDiffKit

class TextfieldDiffableModel {
    private var identifier: String = UUID().uuidString
    public var labelTitle: String
    private(set) var toolbarOptions: [String]
    private(set) var enabled: Bool
    private(set) var changed: ((String) -> Void)?
    private(set) var maxKey: Int?
    private(set) var keyboard: UIKeyboardType
    public var delegate: TextInputSectionDelegate?

    public var text: String?

    init(labelTitle: String, toolbarOptions: [String], enabled: Bool, maxKey: Int?, keyboard: UIKeyboardType = .numberPad, changed: ((String) -> Void)?) {
        self.labelTitle = labelTitle
        self.toolbarOptions = toolbarOptions
        self.enabled = enabled
        self.changed = changed
        self.text = nil
        self.maxKey = maxKey
        self.keyboard = keyboard
    }
}
extension TextfieldDiffableModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return identifier as NSString
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? TextfieldDiffableModel else {
       return false
    }
    return self.identifier == object.identifier
  }
}
