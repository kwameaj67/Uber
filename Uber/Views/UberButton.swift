//
//  UberButton.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 16/11/2022.
//

import UIKit

class UberButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK:  properties -
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: Font.bold.rawValue, size: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
