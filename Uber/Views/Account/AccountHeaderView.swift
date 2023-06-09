//
//  AccountHeaderView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 25/12/2022.
//

import UIKit

protocol DidTapProfileImageDelegate: AnyObject {
    func didTapProfileImage()
}

class AccountHeaderView: UIView {

    static let reuseableID = "AccountHeaderView"
    weak var delegate: DidTapProfileImageDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hanldeDidTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var profileLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Kojo Nkrumah"
        lb.font = UIFont(name: Font.medium2.rawValue, size: 36.0)
        lb.textColor = Color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var ratingView: UIView = {
        let sv = UIView()
        sv.backgroundColor = Color.grey_bg2
        sv.layer.cornerRadius = 25/2
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var profileImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        iv.backgroundColor = .gray
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 60/2
        iv.isUserInteractionEnabled = true
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
    lazy var ratingLbl: UILabel = {
        let lb = UILabel()
        lb.text = "4.93"
        lb.font = UIFont(name: Font.medium.rawValue, size: 14.0)
        lb.textColor = Color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    @objc func hanldeDidTap(){
        delegate?.didTapProfileImage()
    }
 
    func setupViews(){
        addSubview(profileLbl)
        addSubview(profileImage)
        addSubview(ratingView)
        ratingView.addSubview(starImage)
        ratingView.addSubview(ratingLbl)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            profileLbl.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            profileLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            profileImage.topAnchor.constraint(equalTo: topAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.widthAnchor.constraint(equalToConstant: 60),

            ratingView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
            ratingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            ratingView.heightAnchor.constraint(equalToConstant: 25),
            ratingView.widthAnchor.constraint(equalToConstant: 68),

            starImage.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: 8),
            starImage.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            starImage.heightAnchor.constraint(equalToConstant: 14),
            starImage.widthAnchor.constraint(equalToConstant: 14),

            ratingLbl.trailingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: -8),
            ratingLbl.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
        ])
    }
}
