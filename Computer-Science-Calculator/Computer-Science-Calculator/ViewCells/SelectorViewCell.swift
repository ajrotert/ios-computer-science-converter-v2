//
//  SelectorViewCell.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/6/21.
//

import Foundation
import UIKit
import SnapKit

class SelectorViewCell: UICollectionViewCell {

    public static let identifier = "SelectorViewCell"
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.backgroundColor = UIColor.textColor
        segmented.selectedSegmentTintColor = UIColor.primaryColor
        segmented.layer.borderColor = UIColor.primaryColor.cgColor
        segmented.tintColor = UIColor.primaryColor
        segmented.setTitleTextAttributes([ NSAttributedString.Key.foregroundColor: UIColor.white ], for: .normal)
        segmented.addTarget(self, action: #selector(segmented_Changed), for: .valueChanged)
       return segmented
    }()
    
    private(set) var changed: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupSelectorViewCell(options: [String], selectedIndex: Int, changed: ((Int) -> Void)?){
        
        self.changed = changed
        var index = 0
        
        self.segmentedControl.removeAllSegments()
        
        for option in options{
            self.segmentedControl.insertSegment(withTitle: option, at: index, animated: false)
            index += 1
        }
        self.segmentedControl.selectedSegmentIndex = selectedIndex
        
        self.contentView.addSubview(self.segmentedControl)
        self.segmentedControl.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(40)
        }
    }
    
    @objc func segmented_Changed(sender: UISegmentedControl) -> Void {
        if(self.changed != nil){
            self.changed!(sender.selectedSegmentIndex)
        }
    }
}

