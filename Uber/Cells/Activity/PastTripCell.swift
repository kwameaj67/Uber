//
//  PastTripCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 22/12/2022.
//

import UIKit

class PastTripCell: UITableViewCell {
    
    var data: Trip? {
        didSet{
            manageData()
        }
    }
    static let reusableID = "PastTripCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: PastTripCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    lazy var locationLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 2
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var dateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.text_grey
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var priceLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.text_grey
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    lazy var iconContainer: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.backgroundColor = Color.grey_bg2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var carImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-ride")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
  
    lazy var rebookBtn: UberButton = {
        let btn = UberButton(frame: .zero)
        let image = UIImage(systemName: "arrow.uturn.right")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        let resizedImage = image?.resize(to: CGSize(width: 16, height: 16))
        btn.setTitle("Rebook", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 14)
        btn.setImage(resizedImage, for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        btn.semanticContentAttribute = .forceLeftToRight
        btn.backgroundColor = Color.grey_bg
        btn.tintColor = .black
        btn.layer.cornerRadius = 35/2
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    lazy var border: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    func setupViews(){
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(carImage)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(priceLabel)
        contentView.addSubview(rebookBtn)
        contentView.addSubview(border)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            iconContainer.heightAnchor.constraint(equalToConstant: 68),
            iconContainer.widthAnchor.constraint(equalToConstant: 72),
            
            carImage.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            carImage.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            carImage.heightAnchor.constraint(equalToConstant: 45),
            carImage.widthAnchor.constraint(equalToConstant: 60),
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: rebookBtn.leadingAnchor, constant: -20),
            
            rebookBtn.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            rebookBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            rebookBtn.heightAnchor.constraint(equalToConstant: 35),
            rebookBtn.widthAnchor.constraint(equalToConstant: 92),
            
            border.bottomAnchor.constraint(equalTo: bottomAnchor),
            border.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 10),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 0.8),
        ])
    }
    
    func manageData(){
        guard let item = data else { return }
        locationLabel.text = item.location
        dateLabel.text = item.date
        if item.status == .cancelled {
            priceLabel.text = "GH₵\(item.price) · Canceled"
        }else {
            priceLabel.text = "GH₵\(item.price.twoDecimalPlaces())"
        }
    }
    
    func setupAttributedText (_ name: String,_ location: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: name, attributes: [.foregroundColor: UIColor.black,.font:UIFont(name: Font.medium.rawValue, size: 19)!]))
        text.append( NSAttributedString(string: "\n\n\(location)", attributes: [.foregroundColor: Color.text_grey,.font:UIFont(name: Font.regular.rawValue, size: 18)!]))
        return text
    }

}
