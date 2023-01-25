//
//  AccountHeaderView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 25/12/2022.
//

import UIKit

class AccountHeaderView: UIView {

    static let reuseableID = "AccountHeaderView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    let profileLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.medium2.rawValue, size: 36.0)
        lb.textColor = Color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let ratingView: UIView = {
        let sv = UIView()
        sv.backgroundColor = Color.grey_bg2
        sv.layer.cornerRadius = 25/2
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let profileImage : UIImageView = {
        var iv = UIImageView()
        iv.image = nil//UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        iv.backgroundColor = .gray
        iv.layer.cornerRadius = 60/2
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let starImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let ratingLbl: UILabel = {
        let lb = UILabel()
        lb.text = "4.93"
        lb.font = UIFont(name: Font.medium.rawValue, size: 14.0)
        lb.textColor = Color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    func setupViews(){
        addSubview(profileLbl)
        addSubview(profileImage)
        addSubview(ratingView)
        ratingView.addSubview(starImage)
        ratingView.addSubview(ratingLbl)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            profileLbl.topAnchor.constraint(equalTo: topAnchor),
            profileLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            profileImage.centerYAnchor.constraint(equalTo: profileLbl.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.widthAnchor.constraint(equalToConstant: 60),

            ratingView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
            ratingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            ratingView.heightAnchor.constraint(equalToConstant: 25),
            ratingView.widthAnchor.constraint(equalToConstant: 75),

            starImage.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: 8),
            starImage.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            starImage.heightAnchor.constraint(equalToConstant: 14),
            starImage.widthAnchor.constraint(equalToConstant: 14),

            ratingLbl.trailingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: -8),
            ratingLbl.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
        ])
    }
}
