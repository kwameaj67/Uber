//
//  OverlaySelectLocationView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 20/01/2023.
//

import UIKit

protocol OverlaySelectLocationViewDelegate: AnyObject {
    func didTapLocationButton()
}
class OverlaySelectLocationView: UIView {

    weak var delegate: OverlaySelectLocationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var container: UIView = {
        let v = UIView()
        v.backgroundColor = Color.grey_bg2
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContainer)))
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let nameLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Where to?"
        lb.font = UIFont(name: Font.medium.rawValue, size: 24)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: Selectors-
    @objc func didTapContainer(){
        delegate?.didTapLocationButton()
    }
    func setupViews(){
        addSubview(container)
        addSubview(nameLbl)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            container.heightAnchor.constraint(equalToConstant: 55),
            
            nameLbl.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            nameLbl.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15)
        ])
    }
}
