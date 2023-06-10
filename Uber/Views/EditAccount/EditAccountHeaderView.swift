//
//  EditAccountHeaderView.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/22/23.
//

import UIKit

class EditAccountHeaderView: UITableViewHeaderFooterView {

    static let reuseableID = "EditAccountHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: EditAccountHeaderView.reuseableID)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var largeTitleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Edit Account"
        lb.textColor = .black
        lb.font = UIFont(name: Font.medium2.rawValue, size: 34)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var imageView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = Color.grey_bg2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var profileImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        iv.backgroundColor = .gray
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 95/2
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var editBtn: UberButton = {
        let btn = UberButton()
        btn.setImage(UIImage(systemName: "pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        btn.isUserInteractionEnabled = false
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 30/2
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    func setupViews(){
        addSubview(largeTitleLbl)
        addSubview(imageView)
        imageView.addSubview(profileImage)
        imageView.addSubview(editBtn)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            largeTitleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            largeTitleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            imageView.topAnchor.constraint(equalTo: largeTitleLbl.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            profileImage.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            profileImage.widthAnchor.constraint(equalToConstant: 95),
            profileImage.heightAnchor.constraint(equalToConstant: 95),
            
            
            editBtn.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,constant: -35),
            editBtn.leadingAnchor.constraint(equalTo: imageView.leadingAnchor,constant: 20),
            editBtn.widthAnchor.constraint(equalToConstant: 30),
            editBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
