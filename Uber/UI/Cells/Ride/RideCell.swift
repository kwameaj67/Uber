//
//  RideTableViewCell.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 8/4/23.
//

import UIKit

class RideCell: UITableViewCell {
    
    var data: Ride? {
        didSet{
            manageData()
        }
    }
    static let reusableID = "RideCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: RideCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.animate(withDuration: 0.2) {
            self.container.layer.cornerRadius = self.isSelected ? 12 : 0
            self.container.layer.borderColor = self.isSelected ? Color.black.cgColor : UIColor.white.cgColor
            self.container.layer.borderWidth = self.isSelected ? 2.5 : 0
        }
    }
    
    // MARK: UI -
    lazy var container: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var carImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-ride")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var typeLbl: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var dateLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var priceLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
//        sv.backgroundColor = .red
//        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var namePriceStackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var cheapStackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.axis = .horizontal
        sv.isHidden = true
        sv.alpha = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var cheapContainer: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = Color.blue
        v.layer.cornerRadius = 5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var cheapLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.text = "Cheaper"
        lb.font = UIFont(name: Font.medium.rawValue, size: 13)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var fakeLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.text = "n/a"
        lb.font = UIFont(name: Font.medium.rawValue, size: 13)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    func setupViews(){
        contentView.addSubview(container)
        [carImage, stackView ].forEach { item in
            container.addSubview(item)
        }
        stackView.addArrangedSubview(namePriceStackView)
        stackView.addArrangedSubview(dateLbl)
        stackView.addArrangedSubview(cheapStackView)
        cheapStackView.addArrangedSubview(cheapContainer)
        cheapContainer.addSubview(cheapLbl)
        cheapStackView.addArrangedSubview(fakeLbl)
        
        namePriceStackView.addArrangedSubview(typeLbl)
        namePriceStackView.addArrangedSubview(priceLbl)
        
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            carImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            carImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            carImage.heightAnchor.constraint(equalToConstant: 50),
            carImage.widthAnchor.constraint(equalToConstant: 70),
            
            stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: carImage.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            
            cheapContainer.widthAnchor.constraint(equalToConstant: 60),
            cheapContainer.heightAnchor.constraint(equalToConstant: 22),
            cheapContainer.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
        
            cheapLbl.centerYAnchor.constraint(equalTo: cheapContainer.centerYAnchor),
            cheapLbl.centerXAnchor.constraint(equalTo: cheapContainer.centerXAnchor),
        ])
        
    }
    
    func manageData(){
        guard let item = data else { return }
        carImage.image = item.icon
        typeLbl.text = item.name
        priceLbl.text = "₵\(item.price)"
        dateLbl.text = "\(item.duration)"
        
        if let distance =  item.distance {
            dateLbl.text?.append("· \(distance)")
        }
        
        if item.type == .uberX {
            cheapStackView.isHidden = false
            cheapStackView.alpha = 1
        }
    }
}

