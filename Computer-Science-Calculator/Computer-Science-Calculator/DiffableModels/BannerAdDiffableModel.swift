//
//  BannerAdDiffableModel.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 7/20/22.
//

import Foundation
import UIKit
import IGListDiffKit

class BannerAdDiffableModel {
    private var identifier: String = UUID().uuidString

    public weak var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
}
extension BannerAdDiffableModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return identifier as NSString
  }
  
  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let object = object as? BannerAdDiffableModel else {
       return false
    }
    return self.identifier == object.identifier
  }
}
