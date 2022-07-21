//
//  TextfieldViewCell.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import UIKit
import SnapKit

class TextfieldViewCell: UICollectionViewCell {

    public static let identifier = "TextfieldViewCell"
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
       return label
    }()
    private lazy var textfieldInput: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.backgroundColor
        textfield.layer.borderColor = UIColor.primaryColor.cgColor
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 5
        textfield.textColor = UIColor.textColor
        textfield.keyboardType = .numberPad
        textfield.keyboardAppearance = .dark
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        textfield.leftViewMode = .always
        textfield.adjustsFontSizeToFitWidth = true
        textfield.minimumFontSize = 10
        textfield.addTarget(self, action: #selector(textField_Changed), for: .editingChanged)
       return textfield
    }()
    
    private var changed: ((String) -> Void)?
    private var maxKey: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        changed = nil
        maxKey = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupTextfieldViewCell(labelTitle: String, toolbarOptions: [String], enabled: Bool, text: String?, maxKey: Int?, keyboard: UIKeyboardType, changed: ((String) -> Void)?){
        self.changed = changed
        self.maxKey = maxKey
        
        self.labelTitle.text = labelTitle
        self.textfieldInput.text = text
        self.textfieldInput.keyboardType = keyboard
        
        self.contentView.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(20)
        }
        
        self.contentView.addSubview(self.textfieldInput)
        self.textfieldInput.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.labelTitle.snp.bottom).offset(2)
            make.height.equalTo(40)
        }
        
        let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        toolbar.barTintColor = .primaryColor
        toolbar.items = []
        
        for option in toolbarOptions {
            let button = UIBarButtonItem(title: option, style: .plain, target: self, action: #selector(customOption_TouchUpInside))
            button.tintColor = .white
            toolbar.items!.append(button)
        }
        toolbar.items!.append(UIBarButtonItem(systemItem: .flexibleSpace))
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))
        button.tintColor = .white
        toolbar.items!.append(button)
        
        toolbar.sizeToFit()

        self.textfieldInput.inputAccessoryView = toolbar
        
        self.textfieldInput.isEnabled = enabled
        
        self.textfieldInput.backgroundColor = enabled ? UIColor.backgroundColor : UIColor.disabledBackgroundColor
    }
    
    @objc func textField_Changed(sender: UITextField) -> Void {
        if(self.maxKey != nil){
            let lastChar = self.textfieldInput.text?.last
            if(lastChar != nil){
                let lastChars = lastChar!
                if(lastChars.isNumber && lastChars.wholeNumberValue! > self.maxKey!){
                    self.textfieldInput.text = String(self.textfieldInput.text!.dropLast())
                }
            }
        }
        
        if(self.changed != nil){
            self.changed!(sender.text ?? "")
        }
    }
    
    @objc func customOption_TouchUpInside(sender: UIBarButtonItem) -> Void {
        let txt = sender.title ?? ""
        
        if txt.count != 1 { return }
        
        switch txt {
        case "-":
            if let index = (self.textfieldInput.text!.range(of: "-")?.upperBound){
                self.textfieldInput.text = String(self.textfieldInput.text!.suffix(from: index))
            }
            else{
                self.textfieldInput.text = "-" + (self.textfieldInput.text ?? "")
            }
            break;
        case ".", ":", "/":
            let c = "\((self.textfieldInput.text!.last ?? "_"))"
            if self.textfieldInput.text!.count > 0 && c != "." && c != ":" && c != "/" && c != " " {
                self.textfieldInput.text = (self.textfieldInput.text ?? "") + txt
            }
            break;
        case "⎵":
            let c = "\((self.textfieldInput.text!.last ?? "_"))"
            if self.textfieldInput.text!.count > 0 && c != "." && c != ":" && c != "/" && c != " " {
                self.textfieldInput.text = (self.textfieldInput.text ?? "") + " "
            }
            break;
        default:
            self.textfieldInput.text = (self.textfieldInput.text ?? "") + txt
            break;
        }

        textField_Changed(sender: self.textfieldInput)
    }
    
    @objc func doneWithNumberPad() {
        self.textfieldInput.resignFirstResponder()
    }
}
extension TextfieldViewCell : TextInputSectionDelegate{
    func focus() {
        self.textfieldInput.becomeFirstResponder()
    }
}
