//
//  SubnetViewCell.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 7/17/21.
//

import Foundation
import UIKit
import SnapKit

class SubnetViewCell: UICollectionViewCell {

    public static let identifier = "SubnetViewCell"
    
    private lazy var labelId: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.primaryColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var labelbinarySubnet: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.primaryColor
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var labelDecimalSubnet: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.primaryColor
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var labelbroadcastAddress: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.primaryColor
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var labelHostRange: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.primaryColor
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.backgroundColor = UIColor.disabledBackgroundColor
        stackView.layer.cornerRadius = 5
        stackView.layoutMargins = UIEdgeInsets(top: 2.5, left: 5, bottom: 2.5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupSubnetViewCell(id: String, binarySubnet: String, decimalSubnet: String, broadcastAddress: String, hostRange: String){
        
        self.labelId.text = "Id: \(id)"
        self.labelId.preferredMaxLayoutWidth = self.contentView.frame.width
        self.stackView.addArrangedSubview(self.labelId)
        
        self.labelbinarySubnet.text = binarySubnet
        self.labelbinarySubnet.preferredMaxLayoutWidth = self.contentView.frame.width
        self.stackView.addArrangedSubview(self.labelbinarySubnet)

        self.labelDecimalSubnet.text = "(\(decimalSubnet))"
        self.labelDecimalSubnet.preferredMaxLayoutWidth = self.contentView.frame.width
        self.stackView.addArrangedSubview(self.labelDecimalSubnet)
        
        self.labelbroadcastAddress.text = "Broadcast Id:  \(broadcastAddress)"
        self.labelbroadcastAddress.preferredMaxLayoutWidth = self.contentView.frame.width
        self.stackView.addArrangedSubview(self.labelbroadcastAddress)
        
        self.labelHostRange.text = "Host Range:  \(hostRange)"
        self.labelHostRange.preferredMaxLayoutWidth = self.contentView.frame.width
        self.stackView.addArrangedSubview(self.labelHostRange)
        
        self.contentView.addSubview(self.stackView)
        self.stackView.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(self).inset(5)
        }
    }
}
