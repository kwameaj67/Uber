//
//  SettingCell.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/28/23.
//

import UIKit

class SettingCell: UITableViewCell {

    var data : SectionOption? {
        didSet{
            manageData()
        }
    }
    static let reuseableID = "SettingCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SettingCell.reuseableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    lazy var titleLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var descriptionLbl: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textColor = Color.text_grey
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.backgroundColor = .none
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    lazy var iconImage : UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .black
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var arrowImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        iv.tintColor = .systemGray2
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var border: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLbl)
        stackView.addArrangedSubview(descriptionLbl)
        contentView.addSubview(iconImage)
        contentView.addSubview(arrowImage)
        contentView.addSubview(border)
    }

    func setupContraints(){
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalToConstant: 22),
            iconImage.widthAnchor.constraint(equalToConstant: 22),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: border.topAnchor, constant: -18),
              
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrowImage.heightAnchor.constraint(equalToConstant: 14),
            arrowImage.widthAnchor.constraint(equalToConstant: 14),

            border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 20),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 0.6),
        ])
    }
    
    func manageData(){
        guard let item = data else { return }
        titleLbl.text = item.name
        descriptionLbl.text = item.description
        
        switch item.type{
        case .home:
            iconImage.image = UIImage(named: "uber-home")?.withRenderingMode(.alwaysOriginal)
        case .work:
            iconImage.image = UIImage(named: "uber-message")?.withRenderingMode(.alwaysOriginal)
        case .shortcut:
            iconImage.image = UIImage(named: "uber-mappin")?.withRenderingMode(.alwaysOriginal)
        case .privacy:
            iconImage.image = UIImage(named: "uber-privacy")?.withRenderingMode(.alwaysOriginal)
        case .security:
            iconImage.image = UIImage(named: "uber-security")?.withRenderingMode(.alwaysOriginal)
        case .trusted_contacts:
            iconImage.image = UIImage(named: "uber-contact")?.withRenderingMode(.alwaysOriginal)
        case .verify_trip:
            iconImage.image = UIImage(named: "uber-pin")?.withRenderingMode(.alwaysOriginal)
        case .ride_check:
            iconImage.image = UIImage(named: "uber-ridecheck")?.withRenderingMode(.alwaysOriginal)
        case .setup_family:
            iconImage.image = UIImage(named: "uber-family")?.withRenderingMode(.alwaysOriginal)
        case .appearance:
            iconImage.image = UIImage(systemName: "moon.fill")?.withRenderingMode(.alwaysTemplate)
        default:
            break
        }
    }
}
