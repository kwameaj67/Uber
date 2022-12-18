//
//  PromoAdView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 18/12/2022.
//

import UIKit

class PromoAdView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        self.layer.cornerRadius = 12
        self.backgroundColor = Color.green
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Properties
    let bgImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-eats")?.withRenderingMode(.alwaysOriginal)
        iv.tintColor = .systemGray2
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = false
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let arrowImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-forward")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let headingLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Satisfy any carving"
        lb.textColor = .white
        lb.font = UIFont(name: Font.medium.rawValue, size: 21)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let subHeadingLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Order on Eats"
        lb.textColor = .white
        lb.font = UIFont(name: Font.medium.rawValue, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 5
        sv.backgroundColor = .clear
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    func setupViews(){
        addSubview(bgImage)
        addSubview(headingLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(subHeadingLabel)
        stackView.addArrangedSubview(arrowImage)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor,constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            stackView.widthAnchor.constraint(equalToConstant: 110),
            
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -2),
            bgImage.heightAnchor.constraint(equalTo: heightAnchor),
            bgImage.widthAnchor.constraint(equalToConstant: 111),
            
            arrowImage.widthAnchor.constraint(equalToConstant: 14),
            arrowImage.heightAnchor.constraint(equalToConstant: 14),
            
        ])
    }

}
