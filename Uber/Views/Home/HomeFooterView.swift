//
//  HomeFooterView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/12/2022.
//

import UIKit
import MapKit

protocol HomeFooterViewDelegate: AnyObject {
    func didTapMapView()
}

class HomeFooterView: UITableViewHeaderFooterView {

    static let reuseableID = "HomeFooterView"
    
    weak var delegate: HomeFooterViewDelegate?
    
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
    
    lazy var mapView: UberMapView = {
        let mp = UberMapView()
        mp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDidTapMapView)))
        return mp
    }()
    
    @objc func handleDidTapMapView(){
        delegate?.didTapMapView()
    }
    func setupViews(){
        addSubview(titleLabel)
        addSubview(mapView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            mapView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalToConstant: 185)
        ])
    }
}
