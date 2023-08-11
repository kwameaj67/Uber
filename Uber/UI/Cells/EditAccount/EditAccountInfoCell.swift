//
//  AccountInfoCell.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/22/23.
//

import UIKit

class EditAccountInfoCell: UITableViewCell {

    static let reusableID = "EditAccountInfoCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: EditAccountInfoCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var headingLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.textColor = .systemGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var dataLbl: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = UIFont(name: Font.regular.rawValue, size: 17)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var verifiedLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Verified"
        lb.isHidden = true
        lb.alpha = 0
        lb.font = UIFont(name: Font.regular.rawValue, size: 13)
        lb.textColor = Color.green
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let arrowImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .systemGray4
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    func setupViews(){
        contentView.addSubview(headingLbl)
        contentView.addSubview(dataLbl)
        contentView.addSubview(arrowImage)
        contentView.addSubview(verifiedLbl)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrowImage.widthAnchor.constraint(equalToConstant: 14),
            arrowImage.heightAnchor.constraint(equalToConstant: 14),
            
            headingLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            headingLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            dataLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            dataLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dataLbl.trailingAnchor.constraint(equalTo: verifiedLbl.leadingAnchor, constant: -5),
            
            verifiedLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            verifiedLbl.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -5),
            verifiedLbl.widthAnchor.constraint(equalToConstant: 52),
        ])
    }

}
