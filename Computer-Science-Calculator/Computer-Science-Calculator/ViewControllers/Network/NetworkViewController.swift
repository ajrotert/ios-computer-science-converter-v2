//
//  NetworkViewController.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import UIKit
import IGListKit
import FirebaseAnalytics

class NetworkViewController: BaseViewController {
    private static let Tab = 2

    private lazy var ipTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "IP Address: ", toolbarOptions: ["IP Address: ", ".", "⎵", ":", "/"], enabled: true, maxKey: nil, changed: ipChanged)
    }()
    private lazy var convertedIpTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Converted IP Address", toolbarOptions: [], enabled: false, maxKey: nil, changed: nil)
    }()
    private lazy var maskIpTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "Subnet Mask: ", toolbarOptions: ["IP Address: ", ".", "⎵", ":"], enabled: true, maxKey: nil, changed: maskChanged)
    }()
    private lazy var numberSubnetTextField: TextfieldDiffableModel = {
        return TextfieldDiffableModel(labelTitle: "How Many Subnets: ", toolbarOptions: [], enabled: true, maxKey: nil, changed: numberChanged)
    }()
    private lazy var resultsLabel: ResultsLabelDiffableModel = {
        return ResultsLabelDiffableModel(labelTitle: "")
    }()
    
    private lazy var bannerAdModel: BannerAdDiffableModel = {
       return BannerAdDiffableModel(rootViewController: self)
    }()
    
    private lazy var objects: [ListDiffable] = {
        return [bannerAdModel,
                ipTextField,
                convertedIpTextField,
                LabelDiffableModel(labelTitle: "Subnetting"),
                maskIpTextField,
                numberSubnetTextField,
                ClearButtonDiffableModel(clear: clear),
                resultsLabel]
    }()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(
        updater: ListAdapterUpdater(),
        viewController: self,
        workingRangeSize: 0)
      }()
    
    convenience init(){
        self.init(tab: NetworkViewController.Tab)
    }
    
    private lazy var Factory: Factory = {
        return Computer_Science_Calculator.Factory()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNumbersViewController()
        
        Analytics.logEvent("page_view", parameters: ["page" : "Network"])
    }
    
    private func ipChanged(text: String){
        self.ipTextField.text = text
        if((self.ipTextField.text ?? "").count > 0){
            let subnetSplit = self.ipTextField.text!.split(separator: "/")
            updateIpAddress(ip: String(subnetSplit[0]))
            updateSubnetMask(number: subnetSplit.count > 1 ? String(subnetSplit[1]) : "")
            updateSubnet()
        }
    }
    private func maskChanged(text: String){
        self.maskIpTextField.text = text
        if((self.ipTextField.text ?? "").count > 0) && self.ipTextField.text!.contains("/"){
            let subnetSplit = self.ipTextField.text!.split(separator: "/")
            self.ipTextField.text = String(subnetSplit[0])
            self.adapter.reloadObjects([ipTextField])
            updateSubnet()
        }
    }
    private func numberChanged(text: String){
        guard let number = Int(text) else {
            self.numberSubnetTextField.text = ""
            self.adapter.reloadObjects([self.numberSubnetTextField])
            return
        }
        self.numberSubnetTextField.text = "\(number)"
        self.updateSubnet()
    }
    private func updateIpAddress(ip: String){
        let inputArray = ip.components(separatedBy: CharacterSet(charactersIn: ". :"))
        if Factory.NetworkHelper.canConvertIpToBinary(array: inputArray){
            self.convertedIpTextField.text = Factory.NetworkHelper.convertIpToBinary(array: inputArray)
        }
        else if Factory.NetworkHelper.canConvertIpToDecimal(array: inputArray){
            self.convertedIpTextField.text = Factory.NetworkHelper.convertIpToDecimal(array: inputArray)
        }
        else{
            self.convertedIpTextField.text = ""
        }
        self.adapter.reloadObjects([convertedIpTextField])
    }
    private func updateSubnetMask(number: String) {
        if Factory.NetworkHelper.canConvertToSubnetMask(text: number) {
            self.maskIpTextField.text = Factory.NetworkHelper.convertToSubnetMask(text: number)
        }
        else{
            self.maskIpTextField.text = ""
        }
        self.adapter.reloadObjects([maskIpTextField])
    }
    private func validateIpAddress() -> Bool {
        if((self.ipTextField.text ?? "").count > 0){
            let subnetSplit = self.ipTextField.text!.split(separator: "/")
            let inputArray = subnetSplit[0].components(separatedBy: CharacterSet(charactersIn: ". :"))
            return Factory.NetworkHelper.canConvertIpToBinary(array: inputArray)
        }
        return false
    }
    private func validateMaskAddress() -> Bool {
        if((self.maskIpTextField.text ?? "").count > 0){
            let inputArray = self.maskIpTextField.text!.components(separatedBy: CharacterSet(charactersIn: ". :"))
            return Factory.NetworkHelper.canConvertIpToBinary(array: inputArray)
        }
        return false
    }
    private func validateNumberSubnets() -> Bool {
        guard Int(self.numberSubnetTextField.text ?? "") != nil else { return false }
        return true
    }
    private func updateSubnet(){
        
        //Clear existing data
        if self.objects.count > 8 {
            self.resultsLabel.labelTitle = ""

            self.objects = [bannerAdModel,
                            ipTextField,
                            convertedIpTextField,
                            LabelDiffableModel(labelTitle: "Subnetting"),
                            maskIpTextField,
                            numberSubnetTextField,
                            ClearButtonDiffableModel(clear: clear),
                            resultsLabel]
            self.adapter.reloadData(completion: nil)
        }

        if(!validateIpAddress()) { return }
        if(!validateMaskAddress()) { return }
        if(!validateNumberSubnets()) { return }

        let subnetSplit = self.ipTextField.text!.split(separator: "/")
        let ipComponentsArray = subnetSplit[0].components(separatedBy: CharacterSet(charactersIn: ". :"))
        let maskComponentsArray = maskIpTextField.text!.components(separatedBy: CharacterSet(charactersIn: ". :"))
        
        let binaryIpAddress = Factory.NetworkHelper.convertIpToBinary(array: ipComponentsArray)
        let binaryMaskAddress = Factory.NetworkHelper.convertIpToBinary(array: maskComponentsArray)
        
        let subnetAddress = Factory.SubnetHelper.getSubnetAddress(binaryIpAddress: binaryIpAddress, binarySubnetMask: binaryMaskAddress)
        
        let numberSubnets = Int(self.numberSubnetTextField.text ?? "") ?? 0
        let startPosition = self.Factory.SubnetHelper.findStartPosition(binarySubnetMaskAddress: binaryMaskAddress)
        let byteSpace = self.Factory.SubnetHelper.findByteSpace(numberSubnets: numberSubnets)
        let valid = self.Factory.SubnetHelper.validateSubnetAmount(startPosition: startPosition, numberSubnets: numberSubnets, byteSpace: byteSpace)
                
        if(valid){
            
            self.resultsLabel.labelTitle = """
                IP Address:\t\(Factory.SubnetHelper.getIpAddressClass(firstOctet: ipComponentsArray[0]))
                Bits Stolen:\t\(byteSpace)
                Total Hosts:\t\(self.Factory.SubnetHelper.getTotalHosts(binarySubnetMask: binaryMaskAddress, byteSpace: byteSpace))
                """

            let results = self.Factory.SubnetHelper.makeSubnets(startPosition: startPosition, numberSubnets: numberSubnets, byteSpace: byteSpace, subnetAddress: subnetAddress)
            
            for id in 0..<results.count {
                let subnet = results[id]
                let decimalSubnet = self.Factory.NetworkHelper.convertIpToDecimal(array: subnet.components(separatedBy: CharacterSet(charactersIn: ". :")))
                let binaryBroadcastAddress = Factory.SubnetHelper.getBinaryBroadcastAddress(startingLocation: startPosition, binarySubnet: subnet, byteSpace: byteSpace)
                let broadcastAddress = self.Factory.NetworkHelper.convertIpToDecimal(array: binaryBroadcastAddress.components(separatedBy: CharacterSet(charactersIn: ". :")))
                
                let hostRange = "\(self.Factory.NetworkHelper.convertIpToDecimal(array: Factory.SubnetHelper.getBinaryHostLowerAddress(binarySubnet: subnet).components(separatedBy: CharacterSet(charactersIn: ". :")))) - \(self.Factory.NetworkHelper.convertIpToDecimal(array: Factory.SubnetHelper.getBinaryHostHigherAddress(binaryBroadcastAddress: binaryBroadcastAddress).components(separatedBy: CharacterSet(charactersIn: ". :"))))"
                
                let subnetModel = SubnetDiffableModel(id: String(id), binarySubnet: subnet, decimalSubnet: decimalSubnet, broadcastAddress: broadcastAddress, hostRange: hostRange)
                
                self.objects.append(subnetModel)
            }
        }
        else {
            self.resultsLabel.labelTitle = ""

            self.objects = [bannerAdModel,
                            ipTextField,
                            convertedIpTextField,
                            LabelDiffableModel(labelTitle: "Subnetting"),
                            maskIpTextField,
                            numberSubnetTextField,
                            ClearButtonDiffableModel(clear: clear),
                            resultsLabel]
        }
        self.adapter.reloadData(completion: { _ in
            if(self.numberSubnetTextField.delegate != nil){
                self.numberSubnetTextField.delegate!.focus()
            }
        })
    }
    private func clear(){
        ipTextField.text = ""
        convertedIpTextField.text = ""
        maskIpTextField.text = ""
        numberSubnetTextField.text = ""
        resultsLabel.labelTitle = ""
        
        self.objects = [bannerAdModel,
                        ipTextField,
                        convertedIpTextField,
                        LabelDiffableModel(labelTitle: "Subnetting"),
                        maskIpTextField,
                        numberSubnetTextField,
                        ClearButtonDiffableModel(clear: clear),
                        resultsLabel]
        
        self.adapter.reloadData(completion: nil)
    }
    
    private func setupNumbersViewController() {
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
}
extension NetworkViewController: ListAdapterDataSource {
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return self.objects
  }
  
  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any)
  -> ListSectionController {
    if(object is LabelDiffableModel || object is ResultsLabelDiffableModel){
        return LabelSectionController()
    } else if(object is SubnetDiffableModel){
        return SubnetSectionController()
    } else if object is BannerAdDiffableModel {
        return BannerAdSectionController()
    }
    return TextInputSectionController()
  }
  
  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }
}
