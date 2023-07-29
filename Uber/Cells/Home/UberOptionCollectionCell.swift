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
    
    override var isHighlighted: Bool{
        didSet{
            container.backgroundColor = isHighlighted ? .systemGray4 : Color.grey_bg2
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
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 13)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var iconImage : UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var promoView: UIView = {
        let v = UIView()
        v.isHidden = true
        v.alpha = 0
        v.backgroundColor = UIColor(red: 0.11, green: 0.58, blue: 0.37, alpha: 1.00)
        v.layer.cornerRadius = 20/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var promoLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Promo"
        lb.textColor = .white
        lb.font = UIFont(name: Font.medium.rawValue, size: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var container: UIView = {
        let v = UIView()
        v.backgroundColor = Color.grey_bg2
        v.layer.cornerRadius = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        addSubview(container)
        container.addSubview(iconImage)
        addSubview(promoView)
        promoView.bringSubviewToFront(container)
        promoView.addSubview(promoLbl)
        addSubview(titleLabel)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            promoView.topAnchor.constraint(equalTo: topAnchor),
            promoView.widthAnchor.constraint(equalToConstant: 55),
            promoView.heightAnchor.constraint(equalToConstant: 20),
            promoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            promoLbl.centerYAnchor.constraint(equalTo: promoView.centerYAnchor),
            promoLbl.centerXAnchor.constraint(equalTo: promoView.centerXAnchor),
            
            container.topAnchor.constraint(equalTo: promoView.bottomAnchor, constant: -12),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: 72),
            container.widthAnchor.constraint(equalTo: widthAnchor),
            
            iconImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconImage.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 42),
            iconImage.widthAnchor.constraint(equalToConstant: 42),
            
            titleLabel.topAnchor.constraint(equalTo: container.bottomAnchor,constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            
        ])
    }
    
    func manageData(){
        guard let item = data else { return }
        titleLabel.text = item.type.rawValue
        if item.type == .more {
            iconImage.image = item.icon?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(pointSize: 5))
            iconImage.tintColor = .black
        }
        else {
            iconImage.image = item.icon
        }
        
        if item.promoActive {
            promoView.isHidden = false
            promoView.alpha = 1
        }
    }
    
}
