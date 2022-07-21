//
//  ClearButtonViewCell.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import UIKit
import SnapKit

class ClearButtonViewCell: UICollectionViewCell {

    public static let identifier = "ClearButtonViewCell"
    
    private lazy var buttonClear: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.primaryColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .right
        button.contentHorizontalAlignment = .right
        button.setTitle("Clear Text", for: .normal)
        button.addTarget(self, action: #selector(clear_Clicked), for: .touchUpInside)
       return button
    }()
    
    private var clear: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clear = nil;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupClearButtonViewCell(clear: (() -> Void)?){
        self.clear = clear
        
        self.contentView.addSubview(self.buttonClear)
        self.buttonClear.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(18)
        }
    }
    
    @objc func clear_Clicked(sender: UIButton) -> Void {
        if(self.clear != nil){
            self.clear!()
        }
    }
}
