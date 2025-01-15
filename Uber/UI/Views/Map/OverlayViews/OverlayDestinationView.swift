//
//  OverlayDestinationView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 07/01/2023.
//

import UIKit

protocol OverlayDestinationViewDelegate: AnyObject {
    func didTapSearchButton()
}

class OverlayDestinationView: UIView {

    weak var delegate: OverlayDestinationViewDelegate?
    
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
    lazy var titleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Set your destination"
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var border: UIView = {
        let v = UIView()
        v.backgroundColor = Color.grey_bg
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var locationLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Move the map"
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var searchBtn: UberButton = {
        var btn = UberButton()
        btn.setTitle("Search", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 14)
        btn.backgroundColor = Color.grey_bg
        btn.layer.cornerRadius = 35/2
        btn.addTarget(self, action: #selector(hanldeSearchTapped), for: .primaryActionTriggered)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var confirmBtn: UberButton = {
        var btn = UberButton()
        btn.setTitle("Confirm destination", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 18)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(handleConfirmTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func setupViews(){
        addConstrainedSubviews(titleLbl, border, locationLbl, searchBtn, confirmBtn)
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
            
            searchBtn.topAnchor.constraint(equalTo: border.bottomAnchor, constant: 15),
            searchBtn.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            searchBtn.heightAnchor.constraint(equalToConstant: 35),
            searchBtn.widthAnchor.constraint(equalToConstant: 72),
            
            confirmBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            confirmBtn.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            confirmBtn.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            confirmBtn.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    // MARK: Selectors -
    @objc func hanldeSearchTapped(){
        playHaptic(style: .medium)
        delegate?.didTapSearchButton()
    }
    
    @objc func handleConfirmTapped(){
        
    }
}
