//
//  OverlayRideActionView.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/1/23.
//

import UIKit
import MapKit

class OverlayRideActionView: UIView {

    var destination: MKPlacemark? {
        didSet{
            addresLbl.attributedText = setupAttributedText(destination?.name ?? "No location", destination?.title ?? "No address")
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setupContraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let addresLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let confirmButton: UberButton = {
        let btn = UberButton()
        btn.setTitle("Choose UberX", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 18)
        btn.backgroundColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let uberXcontainer: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .black
        v.layer.cornerRadius = 30/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let uberXLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "X"
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = UIFont(name: Font.medium.rawValue, size: 24)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let uberXLbl2: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "UberX"
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont(name: Font.medium.rawValue, size: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let border: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .systemGray4
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.axis = .vertical
        sv.distribution = .equalCentering
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    
    func setupViews(){
        addSubview(stackView)
        [addresLbl,uberXLbl2,border,confirmButton].forEach { item in
            stackView.addArrangedSubview(item)
        }

        addresLbl.attributedText = setupAttributedText("Borbon Carbon", "Madina Zongo Junction")
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -30),
            
            
//            uberXcontainer.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
//            uberXcontainer.widthAnchor.constraint(
//            uberXcontainer.heightAnchor.constraint(equalToConstant: 50),
            
//            uberXLbl.centerXAnchor.constraint(equalTo: uberXcontainer.centerXAnchor),
//            uberXLbl.centerYAnchor.constraint(equalTo: uberXcontainer.centerYAnchor),
            
            
            uberXLbl2.bottomAnchor.constraint(equalTo: border.topAnchor, constant: -10),
            border.heightAnchor.constraint(equalToConstant: 1.5),
            border.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -30),
            
            confirmButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    func setupAttributedText (_ name: String,_ location: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: name, attributes: [.foregroundColor: UIColor.black,.font:UIFont(name: Font.medium.rawValue, size: 17)!]))
        text.append( NSAttributedString(string: "\n\(location)", attributes: [.foregroundColor: Color.text_grey,.font:UIFont(name: Font.regular.rawValue, size: 17)!]))
        return text
    }
}
