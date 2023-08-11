//
//  UberImageButton.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 16/11/2022.
//

import UIKit


class UberImageButton: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    let textLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let forwardIcon : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-forward")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    func setupViews(){
        addSubview(textLabel)
        addSubview(forwardIcon)
    }
    func setupConstraints(){
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            forwardIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            forwardIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            forwardIcon.widthAnchor.constraint(equalToConstant: 20),
            forwardIcon.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

}
