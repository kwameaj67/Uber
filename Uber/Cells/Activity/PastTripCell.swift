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
        arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 3/2) // transform image to the right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    let locationLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.light.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.light.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let iconContainer: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let carImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-car")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let arrowImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-down")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .systemGray3
        iv.contentMode = .scaleAspectFill
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
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(carImage)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(priceLabel)
        contentView.addSubview(arrowImage)
        contentView.addSubview(border)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            iconContainer.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconContainer.heightAnchor.constraint(equalToConstant: 72),
            iconContainer.widthAnchor.constraint(equalToConstant: 72),
            
            carImage.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            carImage.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            carImage.heightAnchor.constraint(equalToConstant: 45),
            carImage.widthAnchor.constraint(equalToConstant: 60),
            
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            stackView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 20),
//            stackView.heightAnchor.constraint(equalTo: carImage.heightAnchor),
            
            arrowImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrowImage.heightAnchor.constraint(equalToConstant: 10),
            arrowImage.widthAnchor.constraint(equalToConstant: 10),
            
            border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            border.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 20),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 0.6),
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
