//
//  BannerAdSectionController.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 7/20/22.
//

import Foundation
import IGListKit

class BannerAdSectionController: ListSectionController {
  var currentObject: BannerAdDiffableModel?
    
  override func didUpdate(to object: Any) {
    guard let object = object as? BannerAdDiffableModel else {
      return
    }
    currentObject = object
  }
    
  override func numberOfItems() -> Int {
    return 1
  }
  override func cellForItem(at index: Int) -> UICollectionViewCell {
    
      let cell = collectionContext?.dequeueReusableCell(of: BannerAdViewCell.self, withReuseIdentifier: BannerAdViewCell.identifier, for: self, at: index)
      
      guard let cell = cell as? BannerAdViewCell, let rootViewController = currentObject?.rootViewController else {
          return cell!
      }
      
      let width = (collectionContext?.containerSize.width ?? 0) - 20
      
      cell.setupBannerAdViewCell(rootViewController: rootViewController, width: width)
      
      return cell

  }
  override func sizeForItem(at index: Int) -> CGSize {
    let width = (collectionContext?.containerSize.width ?? 0) - 20
    return CGSize(width: width, height: 80)
  }
}
