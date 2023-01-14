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
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let locationLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium.rawValue, size: 17)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let addressLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.light.rawValue, size: 16)
        lb.textColor = .gray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let iconContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.layer.cornerRadius = 42/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let iconImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "clock.fill")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let border: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImage)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(locationLbl)
        stackView.addArrangedSubview(addressLbl)
        contentView.addSubview(border)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconContainer.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconContainer.heightAnchor.constraint(equalToConstant: 42),
            iconContainer.widthAnchor.constraint(equalToConstant: 42),
            
            iconImage.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImage.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 22),
            iconImage.widthAnchor.constraint(equalToConstant: 22),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            stackView.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 15),
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
