//
//  SubnetSectionController.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 7/17/21.
//

import Foundation
import IGListKit

class SubnetSectionController: ListSectionController {
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
    
    if(self.currentObject is SubnetDiffableModel){
        let currentObject = self.currentObject as! SubnetDiffableModel
        let cell = collectionContext?.dequeueReusableCell(of: SubnetViewCell.self, withReuseIdentifier: SubnetViewCell.identifier, for: self, at: index)
        
        guard let subnetViewCell = cell as? SubnetViewCell else {
            return cell!
        }
        
        subnetViewCell.setupSubnetViewCell(id: currentObject.id, binarySubnet: currentObject.binarySubnet, decimalSubnet: currentObject.decimalSubnet, broadcastAddress: currentObject.broadcastAddress, hostRange: currentObject.hostRange)
        
        return subnetViewCell
    }
    
    return UICollectionViewCell()

  }
  override func sizeForItem(at index: Int) -> CGSize {
    let width = (collectionContext?.containerSize.width ?? 0) - 20
    if(self.currentObject is SubnetDiffableModel){
        return CGSize(width: width, height: 110)
    }
    return CGSize(width: width, height: 18)
  }
}
