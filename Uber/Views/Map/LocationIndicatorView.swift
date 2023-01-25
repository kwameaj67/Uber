//
//  LocationIndicatorView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 02/01/2023.
//

import UIKit

class LocationIndicatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties -
    let pickupIndicator: UIView = {
        let v = UIView()
        v.backgroundColor = Color.blue
        v.layer.cornerRadius = 8/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let line: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let destinationIndicator: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        addSubview(pickupIndicator)
        addSubview(line)
        addSubview(destinationIndicator)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            pickupIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickupIndicator.topAnchor.constraint(equalTo: topAnchor),
            pickupIndicator.widthAnchor.constraint(equalToConstant: 8),
            pickupIndicator.heightAnchor.constraint(equalToConstant: 8),
            
            
            line.topAnchor.constraint(equalTo: pickupIndicator.bottomAnchor, constant: 5),
            line.centerXAnchor.constraint(equalTo: centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: 1),
            line.heightAnchor.constraint(equalToConstant: 25),
            
            destinationIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            destinationIndicator.topAnchor.constraint(equalTo: line.bottomAnchor,constant: 5),
            destinationIndicator.widthAnchor.constraint(equalToConstant: 8),
            destinationIndicator.heightAnchor.constraint(equalToConstant: 8),
        ])
    }
}
