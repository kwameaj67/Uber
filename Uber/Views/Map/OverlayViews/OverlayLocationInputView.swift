//
//  LocationInputView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 02/01/2023.
//

import UIKit


protocol OverLayLocationInputViewDelegate: AnyObject {
    func dismissLocationInputView()
    func executeLocationSearch(query: String)
    func textFieldShouldClearSearchResults()
}
class OverLayLocationInputView: UIView {

    weak var delegate: OverLayLocationInputViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        addBottomShadowsToView()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties -
    let backButton: UIButton = {
        var btn = UIButton()
        let image = UIImage(named: "uber-back")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(image, for: .normal)
        btn.backgroundColor = .none
        btn.addTarget(self, action: #selector(handledBackTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let headingLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Plan your ride"
        lb.textColor = .black
        lb.font = UIFont(name: Font.medium.rawValue, size: 19)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var pickupLocationField: UberTextField = {
        var tf = UberTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Pickup Location", attributes: [.foregroundColor: UIColor.gray,.font: UIFont(name: Font.regular.rawValue, size: 16)!])
        tf.isEnabled = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var destinationLocationField: UberTextField = {
        var tf = UberTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Where to?", attributes: [.foregroundColor: UIColor.gray,.font: UIFont(name: Font.regular.rawValue, size: 16)!])
        tf.returnKeyType = .search
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let inputStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.backgroundColor = .none
        sv.spacing = 5
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let locationIndicatorView: LocationIndicatorView = {
        let v = LocationIndicatorView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
   
    // MARK: Selectors -
    @objc func handledBackTapped(){
        delegate?.dismissLocationInputView()
    }
    
    func setupViews(){
        addSubview(backButton)
        addSubview(headingLbl)
        addSubview(locationIndicatorView)
        addSubview(inputStackView)
        inputStackView.addArrangedSubview(pickupLocationField)
        inputStackView.addArrangedSubview(destinationLocationField)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor,constant: 54),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            headingLbl.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            headingLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            locationIndicatorView.topAnchor.constraint(equalTo: backButton.bottomAnchor,constant: 30),
            locationIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            locationIndicatorView.heightAnchor.constraint(equalToConstant: 50),
            locationIndicatorView.widthAnchor.constraint(equalToConstant: 15),
            
            inputStackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12),
            inputStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -40),
            inputStackView.leadingAnchor.constraint(equalTo: locationIndicatorView.trailingAnchor, constant: 20),
            inputStackView.heightAnchor.constraint(equalToConstant: 90),
       
        ])
    }
}

//MARK: UITextFieldDelegate -
extension OverLayLocationInputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let query = textField.text else { return false }
        delegate?.executeLocationSearch(query: query)
        return true
    }
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        guard let text = textField.text else { return }
//        if text.isEmpty {
//            delegate?.textFieldShouldClearSearchResults()
//        }
//    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldClearSearchResults()
        return true
    }
    
}
