//
//  OverlayRideActionView.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/1/23.
//

import UIKit

class OverlayRideActionView: UIView {

   
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
    
    let stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.spacing = 10
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    let addresslabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = ""
        lbl.textColor = .black
        lbl.font = UIFont(name: "", size: 15)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let confirmButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Choose UberX", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 14)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 55/2
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    func setupViews(){
        addSubview(stackView)
    }
    
    func setupContraints(){
        
    }
    func setupAttributedText (_ name: String,_ location: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: name, attributes: [.foregroundColor: UIColor.black,.font:UIFont(name: Font.medium.rawValue, size: 19)!]))
        text.append( NSAttributedString(string: "\n\(location)", attributes: [.foregroundColor: Color.text_grey,.font:UIFont(name: Font.regular.rawValue, size: 18)!]))
        return text
    }
}
