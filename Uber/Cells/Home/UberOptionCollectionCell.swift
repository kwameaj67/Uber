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
    override var isSelected: Bool{
        didSet{
            container.backgroundColor = isSelected ? .systemGray4 : Color.grey_bg2
        }
    }
    static let reusableID = "UberOptionCollectionCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        promoView.isHidden = true
    }
    // MARK: Properties -
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 13)
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
    
    let promoView: UIView = {
        let v = UIView()
        v.isHidden = true
        v.alpha = 0
        v.backgroundColor = UIColor(red: 0.11, green: 0.58, blue: 0.37, alpha: 1.00)
        v.layer.cornerRadius = 20/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let promoLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Promo"
        lb.textColor = .white
        lb.font = UIFont(name: Font.medium.rawValue, size: 13)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let container: UIView = {
        let v = UIView()
        v.backgroundColor = Color.grey_bg2
        v.layer.cornerRadius = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(iconImage)
        addSubview(promoView)
        promoView.bringSubviewToFront(container)
        promoView.addSubview(promoLbl)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            promoView.topAnchor.constraint(equalTo: topAnchor),
            promoView.widthAnchor.constraint(equalToConstant: 60),
            promoView.heightAnchor.constraint(equalToConstant: 20),
            promoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            promoLbl.centerYAnchor.constraint(equalTo: promoView.centerYAnchor),
            promoLbl.centerXAnchor.constraint(equalTo: promoView.centerXAnchor),
            
            container.topAnchor.constraint(equalTo: promoView.bottomAnchor, constant: -12),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: 95),
            
            iconImage.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            iconImage.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 45),
            iconImage.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            
        ])
    }
    
    func manageData(){
        guard let item = data else { return }
        titleLabel.text = item.name
        iconImage.image = UIImage(named: item.icon)?.withRenderingMode(.alwaysOriginal)
        
        if item.promoActive{
            promoView.isHidden = false
            promoView.alpha = 1
        }
    }
    
}
