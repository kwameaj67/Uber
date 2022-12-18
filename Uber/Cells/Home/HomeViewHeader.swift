//
//  HomeViewHeader.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 18/12/2022.
//

import UIKit

class HomeHeaderView: UITableViewHeaderFooterView {
    static let reuseableID = "HomeHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: HomeHeaderView.reuseableID)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    let promoView: UIView = {
        let v = PromoAdView()
        return v
    }()
    func setupViews(){
        addSubview(promoView)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            promoView.topAnchor.constraint(equalTo: topAnchor),
            promoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            promoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            promoView.heightAnchor.constraint(equalToConstant: 135)
        ])
    }
}
