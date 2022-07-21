//
//  NumbersViewController.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import UIKit
import IGListKit
import FirebaseAnalytics

class NumbersViewController: BaseViewController {
    private static let Tab = 0
    
    private lazy var decimalTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Decimal", toolbarOptions: ["Decimal: "], enabled: true, maxKey: nil, changed: decimalChanged)
    }()
    private lazy var binaryTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Binary", toolbarOptions: ["Binary: "], enabled: true, maxKey: 1, changed: binaryChanged)
    }()
    private lazy var octalTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Octal", toolbarOptions: ["Octal: "], enabled: true, maxKey: 7, changed: octalChanged)
    }()
    private lazy var hexTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Hexadecimal", toolbarOptions: ["Hex: ", "A", "B", "C", "D", "E", "F"], enabled: true, maxKey: nil, changed: hexChanged)
    }()
    private lazy var signed16IntegerTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "16-Bit Integer", toolbarOptions: ["Decimal: ", "-"], enabled: true, maxKey: nil, changed: integer16Changed)
    }()
    private lazy var signed32IntegerTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "32-Bit Integer", toolbarOptions: ["Decimal: ", "-"], enabled: true, maxKey: nil, changed: integer32Changed)
    }()
    private lazy var signedBinaryTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Binary", toolbarOptions: ["Binary: "], enabled: true, maxKey: 1, changed: signedBinaryChanged)
    }()
    private lazy var signedHexTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Hexadecimal", toolbarOptions: ["Hex: ", "A", "B", "C", "D", "E", "F"], enabled: true, maxKey: nil, changed: signedHexChanged)
    }()
    private lazy var bannerAdModel: BannerAdDiffableModel = {
       return BannerAdDiffableModel(rootViewController: self)
    }()
    
    private lazy var objects: [ListDiffable] = {
        return [bannerAdModel,
                decimalTextField,
                binaryTextField,
                octalTextField,
                hexTextField,
                ClearButtonDiffableModel(clear: clear),
                LabelDiffableModel(labelTitle: "Signed Integers"),
                signed16IntegerTextField,
                signed32IntegerTextField,
                signedBinaryTextField,
                signedHexTextField,
                ClearButtonDiffableModel(clear: clearSigned)]
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
        self.init(tab: NumbersViewController.Tab)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNumbersViewController()
        
        Analytics.logEvent("page_view", parameters: ["page" : "Numbers"])
    }
    
    private func setupNumbersViewController() {
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func decimalChanged(text: String){
        guard let number = Int(text) else { return }
        decimalTextField.text = text
        binaryTextField.text = Factory.NumbersHelper.convertDecimalToBinary(decimal: number)
        octalTextField.text = Factory.NumbersHelper.convertDecimalToOctal(decimal: number)
        hexTextField.text = Factory.NumbersHelper.convertDecimalToHex(decimal: number)
        self.adapter.reloadObjects([binaryTextField, octalTextField, hexTextField])
    }
    private func binaryChanged(text: String){
        let number = Factory.NumbersHelper.convertBinaryToDecimal(binary: text)
        decimalTextField.text = (number == nil) ? "" : String(number!)
        binaryTextField.text = text
        octalTextField.text = Factory.NumbersHelper.convertBinaryToOctal(binary: text)
        hexTextField.text = Factory.NumbersHelper.convertBinaryToHex(binary: text)
        self.adapter.reloadObjects([decimalTextField, octalTextField, hexTextField])
    }
    private func octalChanged(text: String){
        let number = Factory.NumbersHelper.convertOctalToDecimal(octal: text)
        decimalTextField.text = (number == nil) ? "" : String(number!)
        binaryTextField.text = Factory.NumbersHelper.convertOctalToBinary(octal: text)
        octalTextField.text = text
        hexTextField.text = Factory.NumbersHelper.convertOctalToHex(octal: text)
        self.adapter.reloadObjects([decimalTextField, binaryTextField, hexTextField])
    }
    private func hexChanged(text: String){
        let number = Factory.NumbersHelper.convertHexToDecimal(hex: text)
        decimalTextField.text = (number == nil) ? "" : String(number!)
        binaryTextField.text = Factory.NumbersHelper.convertHexToBinary(hex: text)
        octalTextField.text = Factory.NumbersHelper.convertHexToOctal(hex: text)
        hexTextField.text = text
        self.adapter.reloadObjects([decimalTextField, binaryTextField, octalTextField])
    }
    private func clear(){
        decimalTextField.text = "";
        binaryTextField.text = "";
        octalTextField.text = "";
        hexTextField.text = "";
        self.adapter.reloadObjects([decimalTextField, binaryTextField, octalTextField, hexTextField])
    }
    
    private func integer16Changed(text: String){
        guard let number = Int16(text) else {
            signed16IntegerTextField.text = text
            signed32IntegerTextField.text = ""
            signedBinaryTextField.text = ""
            signedHexTextField.text = ""
            self.adapter.reloadObjects([signed32IntegerTextField, signedBinaryTextField, signedHexTextField])
            return
        }
        
        signed16IntegerTextField.text = text
        signed32IntegerTextField.text = ""
        signedBinaryTextField.text = Factory.NumbersHelper.convertSigned16DecimalToBinary(decimal: number)
        signedHexTextField.text = Factory.NumbersHelper.convertSigned16DecimalToHex(decimal: number)
        self.adapter.reloadObjects([signed32IntegerTextField, signedBinaryTextField, signedHexTextField])
    }
    private func integer32Changed(text: String){
        guard let number = Int32(text) else {
            signed16IntegerTextField.text = ""
            signed32IntegerTextField.text = text
            signedBinaryTextField.text = ""
            signedHexTextField.text = ""
            self.adapter.reloadObjects([signed16IntegerTextField, signedBinaryTextField, signedHexTextField])
            return
        }
        
        signed16IntegerTextField.text = ""
        signed32IntegerTextField.text = text
        signedBinaryTextField.text = Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: number)
        signedHexTextField.text = Factory.NumbersHelper.convertSigned32DecimalToHex(decimal: number)
        self.adapter.reloadObjects([signed16IntegerTextField, signedBinaryTextField, signedHexTextField])
    }
    private func signedBinaryChanged(text: String){
        signed16IntegerTextField.text = ""
        signed32IntegerTextField.text = ""
        signedBinaryTextField.text = text
        signedHexTextField.text = ""
        
        if(text.count == 16){
            signed16IntegerTextField.text = String(Factory.NumbersHelper.convertSignedBinaryToInteger16(binary: text))
            signedHexTextField.text = Factory.NumbersHelper.convertSignedBinaryToHex16(binary: text)
        }
        else if(text.count == 32){
            signed32IntegerTextField.text = String(Factory.NumbersHelper.convertSignedBinaryToInteger32(binary: text))
            signedHexTextField.text = Factory.NumbersHelper.convertSignedBinaryToHex32(binary: text)
        }
        self.adapter.reloadObjects([signed16IntegerTextField, signed32IntegerTextField, signedHexTextField])
    }
    private func signedHexChanged(text: String){
        signed16IntegerTextField.text = ""
        signed32IntegerTextField.text = ""
        signedBinaryTextField.text = ""
        signedHexTextField.text = text
        
        if(text.count == 4){
            signed16IntegerTextField.text = String(Factory.NumbersHelper.convertSignedHexToInteger16(hex: text))
            signedBinaryTextField.text = Factory.NumbersHelper.convertSignedHexToBinary16(hex: text)
        }
        else if(text.count == 8){
            signed32IntegerTextField.text = String(Factory.NumbersHelper.convertSignedHexToInteger32(hex: text))
            signedBinaryTextField.text = Factory.NumbersHelper.convertSignedHexToBinary32(hex: text)
        }
        self.adapter.reloadObjects([signed16IntegerTextField, signed32IntegerTextField, signedBinaryTextField])
    }
    private func clearSigned(){
        signed16IntegerTextField.text = "";
        signed32IntegerTextField.text = "";
        signedBinaryTextField.text = "";
        signedHexTextField.text = "";
        self.adapter.reloadObjects([signed16IntegerTextField, signed32IntegerTextField, signedBinaryTextField, signedHexTextField])
    }
}
extension NumbersViewController: ListAdapterDataSource {
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
