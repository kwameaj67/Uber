//
//  HomeFooterView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/12/2022.
//

import UIKit

class HomeFooterView: UITableViewHeaderFooterView {

    static let reuseableID = "HomeFooterView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: HomeFooterView.reuseableID)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:Properties -
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Around you"
        lb.textColor = .black
        lb.font = UIFont(name: Font.medium.rawValue, size: 22)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    func setupViews(){
        addSubview(titleLabel)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
}
