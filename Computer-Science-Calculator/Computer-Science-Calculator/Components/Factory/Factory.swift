//
//  Factory.swift
//  Computer-Science-Calculator
//
//  Created by Andrew Rotert on 6/13/21.
//

import Foundation

public class Factory{
    public lazy var NumbersHelper: NumbersHelper = {
        return Computer_Science_Calculator.NumbersHelper()
    }()
    
    public lazy var TextHelper: TextHelper = {
        return Computer_Science_Calculator.TextHelper()
    }()
    
    public lazy var NetworkHelper: NetworkHelper = {
        return Computer_Science_Calculator.NetworkHelper()
    }()
    
    public lazy var SubnetHelper: SubnetHelper = {
        return Computer_Science_Calculator.SubnetHelper()
    }()
}
