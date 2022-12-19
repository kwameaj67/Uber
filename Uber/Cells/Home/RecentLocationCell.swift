//
//  RecentLocationCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 18/12/2022.
//

import UIKit

class RecentLocationCell: UITableViewCell {
    
    var data: RecentLocation? {
        didSet{
            manageData()
        }
    }
    static let reusableID = "RecentLocationCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: RecentLocationCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    let nameTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
//        lb.letterSpacing(value: 10.0)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let locationTitle: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textColor = Color.black.withAlphaComponent(0.9)
        lb.font = UIFont(name: Font.regular.rawValue, size: 17)
//        lb.letterSpacing(value: 10.0)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let iconImage : UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let border: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    func setupViews(){
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameTitle)
        stackView.addArrangedSubview(locationTitle)
        contentView.addSubview(iconImage)
        contentView.addSubview(border)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            iconImage.heightAnchor.constraint(equalToConstant: 26),
            iconImage.widthAnchor.constraint(equalToConstant: 26),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: border.topAnchor, constant: -15),
              
            border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 20),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 0.6),
        ])
    }
    
    func manageData(){
        guard let item = data else { return }
        nameTitle.text = item.name
        locationTitle.text = item.location
//        locationTitle.attributedText = setupAttributedText(item.name, item.location)
        switch item.icon{
            case .work:
                iconImage.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
                iconImage.tintColor = .black.withAlphaComponent(0.7)
            case .random:
                iconImage.image =  UIImage(systemName: "clock.fill")?.withRenderingMode(.alwaysTemplate)
                iconImage.tintColor = .black.withAlphaComponent(0.7)
        }
       
    }
    
    func setupAttributedText (_ name: String,_ location: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: name, attributes: [.foregroundColor: UIColor.black,.font:UIFont(name: Font.medium.rawValue, size: 19)!]))
        text.append( NSAttributedString(string: "\n\n\(location)", attributes: [.foregroundColor: Color.text_grey,.font:UIFont(name: Font.regular.rawValue, size: 18)!]))
        return text
    }
}
