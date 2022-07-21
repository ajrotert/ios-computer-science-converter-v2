//
//  LabelSectionController.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import IGListKit

class LabelSectionController: ListSectionController {
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
      
        if(self.currentObject is LabelDiffableModel){
            let currentObject = self.currentObject as! LabelDiffableModel
            let cell = collectionContext?.dequeueReusableCell(of: LabelViewCell.self, withReuseIdentifier: LabelViewCell.identifier, for: self, at: index)
            guard let labelViewCell = cell as? LabelViewCell else {
                return cell!
            }
            
            labelViewCell.setupLabelViewCell(labelTitle: currentObject.labelTitle)
            
            return labelViewCell
        }
        else if (self.currentObject is ResultsLabelDiffableModel){
            let currentObject = self.currentObject as! ResultsLabelDiffableModel
            let cell = collectionContext?.dequeueReusableCell(of: ResultsLabelViewCell.self, withReuseIdentifier: ResultsLabelViewCell.identifier, for: self, at: index)
            guard let labelViewCell = cell as? ResultsLabelViewCell else {
                return cell!
            }
            
            labelViewCell.setupLabelViewCell(labelTitle: currentObject.labelTitle)
            
            return labelViewCell
        }
      return UICollectionViewCell()

    }
    override func sizeForItem(at index: Int) -> CGSize {
      let width = (collectionContext?.containerSize.width ?? 0) - 20
      if self.currentObject is LabelDiffableModel {
          return CGSize(width: width, height: 34)
      }
      else if self.currentObject is ResultsLabelDiffableModel{
          let currentObject = self.currentObject as! ResultsLabelDiffableModel
          let height = currentObject.labelTitle.heightWithConstrainedWidth(width: width, font: UIFont.systemFont(ofSize: 14))
          return CGSize(width: width, height: height)
      }
        return CGSize(width: width, height: 40)
    }
}
