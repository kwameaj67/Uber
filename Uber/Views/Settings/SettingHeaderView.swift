//
//  SettingHeaderView.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/28/23.
//

import UIKit

class SettingHeaderView: UITableViewHeaderFooterView {

    static let reuseableID = "SettingHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: SettingHeaderView.reuseableID)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var largeTitleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Settings"
        lb.textColor = .black
        lb.font = UIFont(name: Font.bold2.rawValue, size: 34)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var profileImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        iv.backgroundColor = .gray
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 70/2
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.backgroundColor = .white
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var nameLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Kwame Boateng"
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var phoneLbl: UILabel = {
        let lb = UILabel()
        lb.text = "020 895 6935"
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var emailLbl: UILabel = {
        let lb = UILabel()
        lb.text = "kagyenimboateng65@gmail.com"
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var arrowImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        iv.tintColor = .systemGray2
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupViews(){
        addSubview(largeTitleLbl)
        addSubview(profileImage)
        addSubview(stackView)
        stackView.addArrangedSubview(nameLbl)
        stackView.addArrangedSubview(phoneLbl)
        stackView.addArrangedSubview(emailLbl)
        addSubview(arrowImage)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            largeTitleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            largeTitleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            profileImage.topAnchor.constraint(equalTo: largeTitleLbl.bottomAnchor,constant: 25),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            profileImage.widthAnchor.constraint(equalToConstant: 70),
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            
            stackView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -20),
            
            arrowImage.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            arrowImage.heightAnchor.constraint(equalToConstant: 14),
            arrowImage.widthAnchor.constraint(equalToConstant: 14),
        ])
    }
}
