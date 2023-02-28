//
//  OptionHeaderView.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/28/23.
//

import UIKit

class OptionHeaderView: UITableViewHeaderFooterView {

    static let reuseableID = "OptionHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: OptionHeaderView.reuseableID)
        addSubview(titleLbl)

        titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var titleLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = UIFont(name: Font.bold2.rawValue, size: 24)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
  
}
