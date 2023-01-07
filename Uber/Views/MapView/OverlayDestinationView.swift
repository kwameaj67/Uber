//
//  OverlayDestinationView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 07/01/2023.
//

import UIKit

class OverlayDestinationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 1.0
        layer.shadowOffset =  CGSize(width: 0, height: -1)
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties -
    let titleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Set your destination"
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let border: UIView = {
        let v = UIView()
        v.backgroundColor = Color.grey_bg
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let locationLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Move the map"
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let searchBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Search", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 16)
        btn.backgroundColor = Color.grey_bg
        btn.layer.cornerRadius = 45/2
        //btn.addTarget(self, action: #selector(), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let confirmBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Confirm destination", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 20)
        btn.backgroundColor = .black
        //btn.addTarget(self, action: #selector(), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    func setupViews(){
        addSubview(titleLbl)
        addSubview(border)
        addSubview(locationLbl)
        addSubview(searchBtn)
        addSubview(confirmBtn)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            
            border.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 18),
            border.leadingAnchor.constraint(equalTo: leadingAnchor),
            border.trailingAnchor.constraint(equalTo: trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 2),
            
            locationLbl.centerYAnchor.constraint(equalTo: searchBtn.centerYAnchor),
            locationLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            locationLbl.trailingAnchor.constraint(equalTo: searchBtn.leadingAnchor, constant: 10),
            
            searchBtn.topAnchor.constraint(equalTo: border.bottomAnchor, constant: 18),
            searchBtn.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            searchBtn.heightAnchor.constraint(equalToConstant: 45),
            searchBtn.widthAnchor.constraint(equalToConstant: 85),
            
            confirmBtn.topAnchor.constraint(equalTo: searchBtn.bottomAnchor, constant: 18),
            confirmBtn.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            confirmBtn.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            confirmBtn.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
}
