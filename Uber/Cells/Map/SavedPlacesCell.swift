//
//  SavedPlacesCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 14/01/2023.
//

import UIKit

class SavedPlacesCell: UITableViewCell {

    static let reusableID = "SavedPlacesCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SavedPlacesCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
        arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 3/2) // transform image to the right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties -
    let nameLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Saved Places"
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.textColor = .black
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
        iv.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let arrowImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-down")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .systemGray3
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    func setupViews(){
        contentView.addSubview(nameLbl)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImage)
        contentView.addSubview(arrowImage)
        
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconContainer.heightAnchor.constraint(equalToConstant: 42),
            iconContainer.widthAnchor.constraint(equalToConstant: 42),
            
            iconImage.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImage.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 22),
            iconImage.widthAnchor.constraint(equalToConstant: 22),
            
            nameLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLbl.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 15),
            //nameLbl.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -20),
            
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrowImage.heightAnchor.constraint(equalToConstant: 10),
            arrowImage.widthAnchor.constraint(equalToConstant: 10),
        ])
    }
    
}
