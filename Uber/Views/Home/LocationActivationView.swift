//
//  LocationActivationView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 02/01/2023.
//

import UIKit

protocol SearchLocationDelegate: AnyObject{
    func didTapLocationActivationView()
}

class LocationActivationView: UIView {

    weak var delegate: SearchLocationDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentMapVC)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    let searchIcon : UIImageView = {
        var iv = UIImageView()
        iv.image =  UIImage(named: "uber-search")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
   
    let locationBtn: UILabel = {
        var lb = UILabel()
        lb.text = "Where to?"
        lb.textColor = .gray
        lb.font = UIFont(name:  Font.medium.rawValue, size: 20)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    
    @objc func presentMapVC(){
        delegate?.didTapLocationActivationView()
    }
    func setupViews(){
        addSubview(searchIcon)
        addSubview(locationBtn)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22),
            
            locationBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            locationBtn.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 15),
        ])
    }

}
