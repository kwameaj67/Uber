//
//  SearchLocationView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/12/2022.
//

import UIKit

class SearchLocationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        self.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
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
    
    let locationLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Where to?"
        lb.textColor = .gray
        lb.font = UIFont(name: Font.medium.rawValue, size: 20)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let timerView: UIView = {
        let v = ReserveRideView()
        v.layer.cornerRadius = 40/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        addSubview(searchIcon)
        addSubview(locationLabel)
        addSubview(timerView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22),
            
            locationLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 15),
            
            timerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            timerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            timerView.heightAnchor.constraint(equalToConstant: 40),
            timerView.widthAnchor.constraint(equalToConstant: 125),
        ])
    }

}
