//
//  OverlayRideActionView.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/1/23.
//

import UIKit

class OverlayRideActionView: UIView {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let view: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .black
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    func setupViews(){
        
    }
    
    func setupContraints(){
        
    }
}
