//
//  ActivityHeaderView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 23/12/2022.
//

import UIKit
import MapKit

class ActivityHeaderView: UITableViewHeaderFooterView {
    static let reuseableID = "HomeHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: HomeHeaderView.reuseableID)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    let headingLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Activity"
        lb.font = UIFont(name: Font.medium2.rawValue, size: 36.0)
        lb.textColor = Color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let titleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Past"
        lb.font = UIFont(name: Font.medium.rawValue, size: 20.0)
        lb.textColor = Color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let mapView: UberMapView = {
        let mp = UberMapView()
        return mp
    }()
    let tripContainer: UIView = {
        let v = UIView()
        v.layer.borderWidth = 2.0
        v.layer.cornerRadius = 10
        v.layer.borderColor = UIColor.systemGray5.cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let locationLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 25)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.text_grey
        lb.font = UIFont(name: Font.regular.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.text_grey
        lb.font = UIFont(name: Font.regular.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    func setupViews(){
        addSubview(headingLbl)
        addSubview(titleLbl)
        addSubview(tripContainer)
        [locationLabel,dateLabel,priceLabel].forEach{
            stackView.addArrangedSubview($0)
        }
        tripContainer.addSubview(mapView)
        tripContainer.addSubview(stackView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headingLbl.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            headingLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            
            titleLbl.topAnchor.constraint(equalTo: headingLbl.bottomAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            tripContainer.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 15),
            tripContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            tripContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            tripContainer.heightAnchor.constraint(equalToConstant: 300),
            
            mapView.topAnchor.constraint(equalTo: tripContainer.topAnchor, constant: 12),
            mapView.leadingAnchor.constraint(equalTo: tripContainer.leadingAnchor, constant: 12),
            mapView.trailingAnchor.constraint(equalTo: tripContainer.trailingAnchor, constant: -12),
            mapView.heightAnchor.constraint(equalToConstant: 152),
            
            stackView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: tripContainer.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: tripContainer.trailingAnchor, constant: -12),
            
        ])
    }

}
