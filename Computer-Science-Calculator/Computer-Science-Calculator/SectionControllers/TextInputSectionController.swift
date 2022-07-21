//
//  TextfieldSectionController.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import IGListKit

protocol TextInputSectionDelegate {
    func focus();
}

class TextInputSectionController: ListSectionController {
  var currentObject: ListDiffable?
    
  override func didUpdate(to object: Any) {
    guard let object = object as? ListDiffable else {
      return
    }
    currentObject = object
  }
    
  override func numberOfItems() -> Int {
    return 1
  }
  override func cellForItem(at index: Int) -> UICollectionViewCell {
    
    if(self.currentObject is TextfieldDiffableModel){
        let currentObject = self.currentObject as! TextfieldDiffableModel
        let cell = collectionContext?.dequeueReusableCell(of: TextfieldViewCell.self, withReuseIdentifier: TextfieldViewCell.identifier, for: self, at: index)
        
        guard let textfieldViewCell = cell as? TextfieldViewCell else {
            return cell!
        }
        
        currentObject.delegate = textfieldViewCell
        
        textfieldViewCell.setupTextfieldViewCell(labelTitle: currentObject.labelTitle, toolbarOptions: currentObject.toolbarOptions, enabled: currentObject.enabled, text: currentObject.text, maxKey: currentObject.maxKey, keyboard: currentObject.keyboard, changed: currentObject.changed)
        
        return textfieldViewCell
    }
    else if(self.currentObject is ClearButtonDiffableModel){
        let currentObject = self.currentObject as! ClearButtonDiffableModel
        let cell = collectionContext?.dequeueReusableCell(of: ClearButtonViewCell.self, withReuseIdentifier: ClearButtonViewCell.identifier, for: self, at: index)
        
        guard let clearButtonViewCell = cell as? ClearButtonViewCell else {
            return cell!
        }
        
        clearButtonViewCell.setupClearButtonViewCell(clear: currentObject.clear)
        
        return clearButtonViewCell
    }
    else if(self.currentObject is SelectorDiffableModel){
        let currentObject = self.currentObject as! SelectorDiffableModel
        let cell = collectionContext?.dequeueReusableCell(of: SelectorViewCell.self, withReuseIdentifier: SelectorViewCell.identifier, for: self, at: index)
        
        guard let selectorViewCell = cell as? SelectorViewCell else {
            return cell!
        }
                
        selectorViewCell.setupSelectorViewCell(options: currentObject.options, selectedIndex: currentObject.selectedIndex, changed: currentObject.changed)
        
        return selectorViewCell
    }
    
    return UICollectionViewCell()

  }
  override func sizeForItem(at index: Int) -> CGSize {
    let width = (collectionContext?.containerSize.width ?? 0) - 20
    if(self.currentObject is TextfieldDiffableModel){
        return CGSize(width: width, height: 70)
    }
    else if(self.currentObject is SelectorDiffableModel){
        return CGSize(width: width, height: 60)
    }
    return CGSize(width: width, height: 18)
  }
}
