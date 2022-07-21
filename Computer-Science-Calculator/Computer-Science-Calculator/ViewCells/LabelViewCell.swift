//
//  LabelViewCell.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import UIKit
import SnapKit

class LabelViewCell: UICollectionViewCell {

    public static let identifier = "LabelViewCell"
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.primaryColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
       return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupLabelViewCell(labelTitle: String){
        self.labelTitle.text = labelTitle
        
        self.contentView.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(22)
        }
    }
}
