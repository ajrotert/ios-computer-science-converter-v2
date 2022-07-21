//
//  BitwiseViewController.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import UIKit
import IGListKit
import FirebaseAnalytics

class BitwiseViewController: BaseViewController {
    private static let Tab = 3
    
    private static let resultType = ["Bitwise AND", "Bitwise OR", "Bitwise XOR", "Bitwise NOT", "Bitwise LEFT", "Bitwise RIGHT"]
    
    private lazy var integerOneTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Integer One", toolbarOptions: ["Bitwise: "], enabled: true, maxKey: nil, changed: textFieldOneChanged)
    }()
    private lazy var integerTwoTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Integer Two", toolbarOptions: ["Bitwise: "], enabled: true, maxKey: nil, changed: textFieldTwoChanged)
    }()
    private lazy var selector: SelectorDiffableModel = {
        return SelectorDiffableModel(options: ["&", "|", "^", "~", "<<", ">>"], selectedIndex: 0, changed: segmentedChanged)
    }()
    private lazy var integerOneBinaryTextField: TextfieldDiffableModel = {
        TextfieldDiffableModel(labelTitle: "Integer One Binary", toolbarOptions: [], enabled: false, maxKey: nil, changed: nil)
    }()
    private lazy var integerTwoBinaryTextField: TextfieldDiffableModel = {
        TextfieldDiffableModel(labelTitle: "Integer Two Binary", toolbarOptions: [], enabled: false, maxKey: nil, changed: nil)
    }()
    private lazy var resultTextField: TextfieldDiffableModel = {
        TextfieldDiffableModel(labelTitle: BitwiseViewController.resultType[0], toolbarOptions: [], enabled: false, maxKey: nil, changed: nil)
    }()
    
    private lazy var bannerAdModel: BannerAdDiffableModel = {
       return BannerAdDiffableModel(rootViewController: self)
    }()
    
    private lazy var objects: [ListDiffable] = {
        return [bannerAdModel,
                integerOneTextField,
                integerTwoTextField,
                selector,
                integerOneBinaryTextField,
                integerTwoBinaryTextField,
                resultTextField,
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
        self.init(tab: BitwiseViewController.Tab)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNumbersViewController()
        
        Analytics.logEvent("page_view", parameters: ["page" : "Bitwise"])
    }
    
    private func setupNumbersViewController() {
        
        collectionView.register(TextfieldViewCell.self, forCellWithReuseIdentifier: TextfieldViewCell.identifier)
        collectionView.register(LabelViewCell.self, forCellWithReuseIdentifier: LabelViewCell.identifier)

        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func textFieldOneChanged(text: String){
        integerOneTextField.text = text
        self.textFieldChanged()
    }
    private func textFieldTwoChanged(text: String){
        integerTwoTextField.text = text
        self.textFieldChanged()
    }
    private func validateTextFieldInput() -> Bool{
        guard Int32(self.integerOneTextField.text ?? "") != nil else {
            return false;
        }
        if self.selector.selectedIndex != 3{
            guard Int32(self.integerTwoTextField.text ?? "") != nil else {
                return false;
            }
        }
        return true;
    }
    private func textFieldChanged(){
        
        let valid: Bool = validateTextFieldInput()
        
        if !valid {
            self.integerOneBinaryTextField.text = ""
            self.integerTwoBinaryTextField.text = ""
            self.resultTextField.text = ""
            self.adapter.reloadObjects([integerOneBinaryTextField, integerTwoBinaryTextField, resultTextField])
        }
        
        switch self.selector.selectedIndex {
        case 0:
            guard let inputOne = Int32(self.integerOneTextField.text ?? "") else { return }
            guard let inputTwo = Int32(self.integerTwoTextField.text ?? "") else { return }
            
            self.integerOneBinaryTextField.text = "(\(inputOne)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputOne))"
            self.integerTwoBinaryTextField.text = "(\(inputTwo)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputTwo))"
            
            self.resultTextField.text = "(\(inputOne & inputTwo)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: (inputOne & inputTwo)))"
            break;
        case 1:
            guard let inputOne = Int32(self.integerOneTextField.text ?? "") else { return }
            guard let inputTwo = Int32(self.integerTwoTextField.text ?? "") else { return }
            
            self.integerOneBinaryTextField.text = "(\(inputOne)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputOne))"
            self.integerTwoBinaryTextField.text = "(\(inputTwo)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputTwo))"
            
            self.resultTextField.text = "(\(inputOne | inputTwo)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: (inputOne | inputTwo)))"
            break;
        case 2:
            guard let inputOne = Int32(self.integerOneTextField.text ?? "") else { return }
            guard let inputTwo = Int32(self.integerTwoTextField.text ?? "") else { return }
            
            self.integerOneBinaryTextField.text = "(\(inputOne)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputOne))"
            self.integerTwoBinaryTextField.text = "(\(inputTwo)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputTwo))"
            
            self.resultTextField.text = "(\(inputOne ^ inputTwo)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: (inputOne ^ inputTwo)))"
            break;
        case 3:
            guard let inputOne = Int32(self.integerOneTextField.text ?? "") else { return }
            
            self.integerOneBinaryTextField.text = "(\(inputOne)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputOne))"
            
            self.resultTextField.text = "(\(~inputOne)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: (~inputOne)))"
            break;
        case 4:
            guard let inputOne = Int32(self.integerOneTextField.text ?? "") else { return }
            guard let inputTwo = Int32(self.integerTwoTextField.text ?? "") else { return }
            
            self.integerOneBinaryTextField.text = "(\(inputOne)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputOne))"
            self.integerTwoBinaryTextField.text = "(\(inputTwo)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputTwo))"
            
            let result = inputOne << (inputTwo % 32)
            self.resultTextField.text = "(\(result)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: result))"
            break;
        case 5:
            guard let inputOne = Int32(self.integerOneTextField.text ?? "") else { return }
            guard let inputTwo = Int32(self.integerTwoTextField.text ?? "") else { return }
            
            self.integerOneBinaryTextField.text = "(\(inputOne)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputOne))"
            self.integerTwoBinaryTextField.text = "(\(inputTwo)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: inputTwo))"
            
            let result = inputOne >> (inputTwo % 32)
            self.resultTextField.text = "(\(result)) - \(Factory.NumbersHelper.convertSigned32DecimalToBinary(decimal: result))"
            break;
        default:
            break;
        }
        
        self.adapter.reloadObjects([integerOneBinaryTextField, integerTwoBinaryTextField, resultTextField])
    }
    private func segmentedChanged(index: Int){
        self.selector.selectedIndex = index
        self.resultTextField.labelTitle = BitwiseViewController.resultType[index]
        updateObjectsList(completion: { _ in
            self.textFieldChanged()
        })
    }
    private func updateObjectsList(completion: ((Bool) -> Void)?) {
        
        var newObjects: [ListDiffable] = []
        switch self.selector.selectedIndex {
        case 0, 1, 2:
            newObjects = [bannerAdModel,
                          integerOneTextField,
                          integerTwoTextField,
                          selector,
                          integerOneBinaryTextField,
                          integerTwoBinaryTextField,
                          resultTextField,
                          ClearButtonDiffableModel(clear: clear)]
            break
        case 3:
            newObjects = [bannerAdModel,
                          integerOneTextField,
                          selector,
                          integerOneBinaryTextField,
                          resultTextField,
                          ClearButtonDiffableModel(clear: clear)]
            break
        case 4:
            newObjects = [bannerAdModel,
                          integerOneTextField,
                          integerTwoTextField,
                          selector,
                          integerOneBinaryTextField,
                          resultTextField,
                          ClearButtonDiffableModel(clear: clear)]
            break
        case 5:
            newObjects = [bannerAdModel,
                          integerOneTextField,
                          integerTwoTextField,
                          selector,
                          integerOneBinaryTextField,
                          resultTextField,
                          ClearButtonDiffableModel(clear: clear)]
            break
        default:
            break
        }
                
        if self.objects.count != newObjects.count {
            self.objects = newObjects
            self.adapter.reloadData(completion: completion)
        }
        else{
            var diff: Bool = false

            self.objects.forEach { object in
                if (object is ClearButtonDiffableModel){}
                else if (self.objects.firstIndex(where: { $0 === object }) == newObjects.firstIndex(where: { $0 === object })){
                    diff = true
                }
            }
            
            if(diff){
                self.objects = newObjects
                self.adapter.reloadData(completion: completion)
            }
            else if completion != nil{
                completion!(true)
            }
        }
    }
    private func clear(){
        self.integerOneTextField.text = ""
        self.integerTwoTextField.text = ""
        self.integerOneBinaryTextField.text = ""
        self.integerTwoBinaryTextField.text = ""
        self.resultTextField.text = ""
        self.resultTextField.labelTitle = BitwiseViewController.resultType[self.selector.selectedIndex]
        updateObjectsList(completion: { _ in
            self.adapter.reloadObjects([self.integerOneTextField, self.integerTwoTextField, self.selector, self.integerOneBinaryTextField, self.integerTwoBinaryTextField, self.resultTextField])
            
        })

    }
}
extension BitwiseViewController: ListAdapterDataSource {
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
