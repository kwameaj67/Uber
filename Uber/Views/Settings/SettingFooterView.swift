//
//  SignoutCell.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/28/23.
//

import UIKit

protocol DidTapSignOutDelegate: AnyObject{
    func didTapSignOut()
}
class SettingFooterView: UITableViewHeaderFooterView {

    weak var delegate: DidTapSignOutDelegate?
    
    static let reuseableID = "SettingFooterView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: SettingFooterView.reuseableID)
        addSubview(border)
        addSubview(titleLbl)
        
        // contraints
        border.topAnchor.constraint(equalTo: topAnchor).isActive = true
        border.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        border.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        border.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hanldeSignOut)))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var border: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = Color.grey_bg2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var titleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Sign out"
        lb.textColor = UIColor(red: 0.77, green: 0.17, blue: 0.17, alpha: 1.00)
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
   
    @objc func hanldeSignOut(){
        delegate?.didTapSignOut()
    }
    
}
