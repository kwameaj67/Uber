//
//  CodeVerificationVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 26/11/2022.
//

import UIKit
import CHIOTPField


class CodeVerificationVC: UIViewController, UITextFieldDelegate {
    
    private var phoneNumber: String? = "020 895 6935"
    private var isShowingKeyboard:Bool = false
    private var backButtonbottomConstraint = NSLayoutConstraint()
    private var nextButtonbottomConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
        // Do any additional setup after loading the view.
        titleLabel.text = "Enter the 4-digit code sent to you at \n\(phoneNumber ?? "")"
        navigationController?.navigationBar.isHidden = true
        codeField.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(gesture:))))
        observeKeyboard()
    }
    
    
    // MARK: Properties -
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.font = UIFont(name: Font.medium.rawValue, size: 22)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let codeField: UITextField = {
        let cf = CHIOTPFieldFour(frame: .init(x: 0, y: 0, width: 250, height: 55))
        cf.numberOfDigits = 4
        cf.spacing = 10
        cf.cornerRadius = 8
        cf.boxBackgroundColor = Color.grey_bg
//        cf.activeBoxBackgroundColor = Color.grey_bg2
//        cf.filledBoxBackgroundColor = Color.grey_bg
        cf.borderColor = .clear
//        cf.activeBorderColor = .black
//        cf.filledBorderColor = .clear
//        cf.boxPlaceholder = nil
//        cf.boxPlaceholderColor = nil
        cf.text = ""
        cf.translatesAutoresizingMaskIntoConstraints = false
        return cf
    }()
    let noCodeButton: UberButton = {
        var btn = UberButton()
        btn.setTitle("I haven't received a code", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 16)
        btn.backgroundColor = Color.grey_bg
        btn.layer.cornerRadius = 45/2
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
  
    let backButton: UberButton = {
        var btn = UberButton()
        let image = UIImage(named: "uber-back")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24))
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.adjustsImageWhenHighlighted = false
        btn.backgroundColor = Color.grey_bg
        btn.layer.cornerRadius = 60/2
//        btn.addTarget(self, action: #selector(), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let nextButton: UberButton = {
        var btn = UberButton()
        let image = UIImage(named: "uber-forward")?.withConfiguration(UIImage.SymbolConfiguration(pointSize:    18)).withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 18)
        btn.backgroundColor = Color.grey_bg
        btn.adjustsImageWhenHighlighted = false
        btn.tintColor = .black
        btn.semanticContentAttribute = .forceRightToLeft
        btn.layer.cornerRadius = 60/2
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//        btn.addTarget(self, action: #selector(), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func hideKeyboard(gesture : UITapGestureRecognizer){
        view.endEditing(true)
        codeField.resignFirstResponder()
    }
    func setupViews(){
        view.addSubview(titleLabel)
        view.addSubview(codeField)
        view.addSubview(noCodeButton)
        view.addSubview(backButton)
        view.addSubview(nextButton)
    }
    func setupContraints(){
        backButtonbottomConstraint = backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        backButtonbottomConstraint.isActive = true
        nextButtonbottomConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        nextButtonbottomConstraint.isActive = true

        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            codeField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            codeField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            codeField.heightAnchor.constraint(equalToConstant: 55),
            codeField.widthAnchor.constraint(equalToConstant: 250),
            
            noCodeButton.topAnchor.constraint(equalTo: codeField.bottomAnchor, constant: 30),
            noCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noCodeButton.heightAnchor.constraint(equalToConstant: 45),
            noCodeButton.widthAnchor.constraint(equalToConstant: 220),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.widthAnchor.constraint(equalToConstant: 105),
            
        ])
    }

}

extension CodeVerificationVC {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isShowingKeyboard = true
    }
    
    func observeKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification){
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isShowingKeyboard{
                self.backButtonbottomConstraint.constant = -keyboardRect.height + 10
                self.nextButtonbottomConstraint.constant = -keyboardRect.height + 10
            }
            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
            }
        }

    }
    
    @objc private func keyboardWillHide(notification: Notification){
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isShowingKeyboard{
                self.backButtonbottomConstraint.constant = 0
                self.nextButtonbottomConstraint.constant = 0
            }
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
}
