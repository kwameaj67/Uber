//
//  Loader.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 5/19/23.
//

import UIKit


class UberLoaderOverlay: UIView {
    
    var isOpen: Bool = false {
        didSet{
            if isOpen{
                self.indicator.startAnimating()
                self.isHidden = false
                self.alpha = 1
            }
            else {
                self.indicator.stopAnimating()
                self.isHidden = true
                self.alpha = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        alpha = 0
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black.withAlphaComponent(0.3)
        addSubview(indicator)
        
        //constraints
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var indicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(frame: .zero)
        ai.color  = .systemGray5
        ai.style = .large
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
}
