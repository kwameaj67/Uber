//
//  ReserveRideView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/12/2022.
//

import UIKit

class ReserveRideView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        self.backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var timeIcon : UIImageView = {
        var iv = UIImageView()
        iv.image =  UIImage(systemName: "clock.fill")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var uberDownIcon : UIImageView = {
        var iv = UIImageView()
        iv.image =  UIImage(named: "uber-down")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var timeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Now"
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.medium.rawValue, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 10
        sv.alignment = .center
//        sv.backgroundColor = .red
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    func setupViews(){
        addSubview(stackView)
        stackView.addArrangedSubview(timeIcon)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(uberDownIcon)
        
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            timeIcon.widthAnchor.constraint(equalToConstant: 20),
            timeIcon.heightAnchor.constraint(equalToConstant: 20),
            
            uberDownIcon.widthAnchor.constraint(equalToConstant: 7),
            uberDownIcon.heightAnchor.constraint(equalToConstant: 7),
        ])
    }

}
