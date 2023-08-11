//
//  AccountOptionCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 25/12/2022.
//

import UIKit

class AccountOptionCell: UITableViewCell {

    var data: AccountOption? {
        didSet{
            manageData()
        }
    }
    static let reusableID = "AccountOptionCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: AccountOptionCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    let iconImage : UIImageView = {
        var iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    func setupViews(){
        contentView.addSubview(iconImage)
        contentView.addSubview(titleLabel)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalToConstant: 18),
            iconImage.widthAnchor.constraint(equalToConstant: 18),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    func manageData(){
        guard let data = data else { return }
        
        switch data.iconType {
            case .messages:
                iconImage.image = UIImage(named: "uber-message")?.withRenderingMode(.alwaysOriginal)
            case .settings:
                iconImage.image = UIImage(named: "uber-setting")?.withRenderingMode(.alwaysOriginal)
            case .earning:
                iconImage.image = UIImage(named: "uber-gift")?.withRenderingMode(.alwaysOriginal)
            case .legal:
                iconImage.image = UIImage(systemName: "info.circle.fill")?.withRenderingMode(.alwaysTemplate)
            case .refer:
                iconImage.image = UIImage(systemName: "person.2.fill")?.withRenderingMode(.alwaysOriginal)
            case .business:
                iconImage.image = UIImage(named: "uber-wallet")?.withRenderingMode(.alwaysOriginal)
        }
        
        titleLabel.text = data.name
    }
}
