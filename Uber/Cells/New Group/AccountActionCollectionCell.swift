//
//  AccountActionCollectionCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 25/12/2022.
//

import UIKit

class AccountActionCollectionCell: UICollectionViewCell {
    var data: AccountActionOption? {
        didSet{
            manageData()
        }
    }
    static let reusableID = "AccountActionCollectionCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        self.layer.cornerRadius = 15
        backgroundColor = Color.grey_bg2
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties - 
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let iconImage : UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    func setupViews(){
        addSubview(stackView)
        stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(titleLabel)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            
            
//            iconImage.topAnchor.constraint(equalTo: topAnchor,constant: 20),
//            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 30),
            iconImage.widthAnchor.constraint(equalToConstant: 30),
            
//            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
//            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
           
        ])
    }
    
    func manageData(){
        guard let item = data else { return }
        titleLabel.text = item.name
        if item.type  == .trips {
            iconImage.image = UIImage(systemName: "clock.fill")?.withRenderingMode(.alwaysOriginal)
        }else{
            guard let icon = item.icon else { return }
            iconImage.image = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
        }
        
    }
    
}
