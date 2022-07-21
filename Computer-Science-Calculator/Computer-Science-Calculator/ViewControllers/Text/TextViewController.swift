//
//  TextViewController.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import UIKit
import IGListKit
import FirebaseAnalytics

class TextViewController: BaseViewController {
    private static let Tab = 1

    private lazy var stringTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "String", toolbarOptions: ["String: "], enabled: true, maxKey: nil, keyboard: .default, changed: stringChanged)
    }()
    private lazy var decimalTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Decimal", toolbarOptions: ["Decimal: "], enabled: true, maxKey: nil, changed: decimalChanged)
    }()
    private lazy var binaryTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Binary", toolbarOptions: ["Binary: "], enabled: true, maxKey: 1, changed: binaryChanged)
    }()
    private lazy var hexTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Hexadecimal", toolbarOptions: ["Hex: ", "A", "B", "C", "D", "E", "F"], enabled: true, maxKey: nil, changed: hexChanged)
    }()
    
    private lazy var bannerAdModel: BannerAdDiffableModel = {
       return BannerAdDiffableModel(rootViewController: self)
    }()
    
    private lazy var objects: [ListDiffable] = {
        return [bannerAdModel,
                stringTextField,
                decimalTextField,
                binaryTextField,
                hexTextField,
                ClearButtonDiffableModel(clear: clear)]
    }()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(
        updater: ListAdapterUpdater(),
        viewController: self,
        workingRangeSize: 0)
      }()
    
    private lazy var Factory: Factory = {
        return Computer_Science_Calculator.Factory()
    }()
    
    convenience init(){
        self.init(tab: TextViewController.Tab)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNumbersViewController()
        
        Analytics.logEvent("page_view", parameters: ["page" : "Text"])
    }
    
    private func setupNumbersViewController() {
                adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func stringChanged(text: String){
        stringTextField.text = text
        decimalTextField.text = Factory.TextHelper.convertStringToDecimalString(text: text)
        binaryTextField.text = Factory.TextHelper.convertStringToBinaryString(text: text)
        hexTextField.text = Factory.TextHelper.convertStringToHexString(text: text)
        self.adapter.reloadObjects([decimalTextField, binaryTextField, hexTextField])
    }
    private func decimalChanged(text: String){
        stringTextField.text = Factory.TextHelper.convertDecimalStringToString(text: text)
        decimalTextField.text = text
        binaryTextField.text = Factory.TextHelper.convertDecimalStringToBinary(text: text)
        hexTextField.text = Factory.TextHelper.convertDecimalStringToHex(text: text)
        self.adapter.reloadObjects([stringTextField, binaryTextField, hexTextField])
    }
    private func binaryChanged(text: String){
        stringTextField.text = Factory.TextHelper.convertBinaryStringToString(text: text)
        decimalTextField.text = Factory.TextHelper.convertBinaryStringToDecimal(text: text)
        binaryTextField.text = text
        hexTextField.text = Factory.TextHelper.convertBinaryStringToHex(text: text)
        self.adapter.reloadObjects([stringTextField, decimalTextField, hexTextField])
    }
    private func hexChanged(text: String){
        stringTextField.text = Factory.TextHelper.convertHexStringToString(text: text)
        decimalTextField.text = Factory.TextHelper.convertHexStringToDecimal(text: text)
        binaryTextField.text = Factory.TextHelper.convertHexStringToBinary(text: text)
        hexTextField.text = text
        self.adapter.reloadObjects([stringTextField, decimalTextField, binaryTextField])
    }
    private func clear(){
        stringTextField.text = "";
        decimalTextField.text = "";
        binaryTextField.text = "";
        hexTextField.text = "";
        self.adapter.reloadObjects([stringTextField, decimalTextField, binaryTextField, hexTextField])
    }
}
extension TextViewController: ListAdapterDataSource {
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return self.objects
  }
  
  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any)
  -> ListSectionController {
    if(object is LabelDiffableModel){
        return LabelSectionController()
    } else if object is BannerAdDiffableModel {
        return BannerAdSectionController()
    }
    return TextInputSectionController()
  }
  
  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }
}
