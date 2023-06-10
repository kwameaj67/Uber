//
//  LocationInputCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 03/01/2023.
//

import UIKit
import MapKit

class LocationInputCell: UITableViewCell {

    var placemark: MKPlacemark?{
        didSet{
            manageData()
        }
    }
    static let reusableID = "LocationInputCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: LocationInputCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var locationLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 15)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var addressLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.regular.rawValue, size: 15)
        lb.textColor = .gray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var iconImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-mappin")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var border: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        contentView.addSubview(stackView)
        contentView.addSubview(iconImage)
        stackView.addArrangedSubview(locationLbl)
        stackView.addArrangedSubview(addressLbl)
        contentView.addSubview(border)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalToConstant: 18),
            iconImage.widthAnchor.constraint(equalToConstant: 18),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            stackView.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: leadingAnchor),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 0.6),
        ])
    }
    
    func manageData(){
        guard let item = placemark else { return }
        locationLbl.text = item.name ?? "n/a"
        addressLbl.text = item.title ?? "n/a"
    }
}
