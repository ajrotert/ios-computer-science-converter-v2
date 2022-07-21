//
//  ResultsViewCell.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/20/21.
//

import Foundation
import UIKit
import SnapKit

class ResultsLabelViewCell: UICollectionViewCell {

    public static let identifier = "ResultsLabelViewCell"
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.primaryColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
        self.labelTitle.preferredMaxLayoutWidth = self.contentView.frame.width
        self.contentView.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints{ make in
            make.edges.equalTo(self)
        }
    }
}
