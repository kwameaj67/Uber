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
        self.backgroundColor = Color.grey_bg2
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var locationActivationView: LocationActivationView = {
        let v = LocationActivationView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var timerView: UIView = {
        let v = ReserveRideView()
        v.layer.cornerRadius = 40/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        addSubview(locationActivationView)
        addSubview(timerView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            locationActivationView.topAnchor.constraint(equalTo: topAnchor),
            locationActivationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationActivationView.trailingAnchor.constraint(equalTo: timerView.leadingAnchor),
            locationActivationView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            timerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            timerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            timerView.heightAnchor.constraint(equalToConstant: 40),
            timerView.widthAnchor.constraint(equalToConstant: 125),
        ])
    }

}
