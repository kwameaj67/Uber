//
//  UberOptionCollectionCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 18/12/2022.
//

import UIKit

class UberOptionCollectionCell: UICollectionViewCell {
    var data: UberFeatureOption? {
        didSet{
            manageData()
        }
    }
    static let reusableID = "UberOptionCollectionCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        self.layer.cornerRadius = 15
        backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 14)
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
    
    func setupViews(){
        addSubview(titleLabel)
        addSubview(iconImage)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            iconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 45),
            iconImage.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
           
        ])
    }
    
    func manageData(){
        guard let item = data else { return }
        titleLabel.text = item.name
        iconImage.image = UIImage(named: item.icon)?.withRenderingMode(.alwaysOriginal)
    }
    
}
