//
//  LocationInputCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 03/01/2023.
//

import UIKit

class LocationInputCell: UITableViewCell {

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
    let locationLbl: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let iconContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.layer.cornerRadius = 48/2
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
        contentView.addSubview(locationLbl)
        contentView.addSubview(border)
        locationLbl.attributedText = setupAttributedText("26 Lower Hill Dr", "Accra")
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconContainer.heightAnchor.constraint(equalToConstant: 48),
            iconContainer.widthAnchor.constraint(equalToConstant: 48),
            
            iconImage.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImage.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 20),
            iconImage.widthAnchor.constraint(equalToConstant: 20),
            
            locationLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            locationLbl.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 15),
            locationLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: leadingAnchor),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 0.6),
        ])
    }
    func setupAttributedText (_ name: String,_ location: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: name, attributes: [.foregroundColor: UIColor.black,.font:UIFont(name: Font.medium.rawValue, size: 17)!]))
        text.append( NSAttributedString(string: "\n\(location)", attributes: [.foregroundColor: Color.text_grey,.font:UIFont(name: Font.regular.rawValue, size: 16)!]))
        return text
    }
}
