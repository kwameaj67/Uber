//
//  AccountOptionCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 25/12/2022.
//

import UIKit

class AccountOptionCell: UITableViewCell {

    var data: AccountOption? {
        didSet{
            manageData()
        }
    }
    static let reusableID = "AccountOptionCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: AccountOptionCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var iconImage : UIImageView = {
        var iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var titleLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var subTitleLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.text_grey.withAlphaComponent(0.9)
        lb.font = UIFont(name: Font.regular.rawValue, size: 11)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.spacing = 4
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    
    func setupViews(){
        contentView.addSubview(iconImage)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLbl)
        stackView.addArrangedSubview(subTitleLbl)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalToConstant: 18),
            iconImage.widthAnchor.constraint(equalToConstant: 18),
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    func manageData(){
        guard let data = data else { return }
        
        if data.type == .messages,
           data.type == .earning,
           data.type == .business {
            let resizedImage = data.image?.resize(to: CGSize(width: 16, height: 14))
            iconImage.image = resizedImage
        }
        else {
            iconImage.image = data.image
        }
        
        titleLbl.text = data.title
        
//        if option has subTitle
        guard let subTitle =  data.subTitle else { return }
        subTitleLbl.text = subTitle
    }
}
