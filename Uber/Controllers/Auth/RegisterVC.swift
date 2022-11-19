//
//  LoginVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 17/11/2022.
//

import UIKit

class RegisterVC: UIViewController {

    private var isShowingKeyboard:Bool = false
    private var bottomButtonConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .white
        title = "Sign up"
        setupViews()
        setupContraints()
        configureNavBar()
        configureBackButton()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        navigationController?.navigationBar.isHidden = false
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(gesture:))))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Properties -
    var scrollView : UIScrollView = {
        var sb = UIScrollView()
        sb.showsVerticalScrollIndicator = false
        sb.bounces = true
        sb.alwaysBounceVertical = true
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 20
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    lazy var signupButton: UberImageButton = {
        let v = UberImageButton(frame: .zero)
        v.forwardIcon.isHidden = true
        v.forwardIcon.alpha = 0
        v.textLabel.text = "Sign up"
        return v
    }()
    let emailTextField: UberTextField = {
        var tf = UberTextField()
        tf.placeholder = "Email"
        return tf
    }()
    let passwordTextField: UberTextField = {
        var tf = UberTextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        return tf
    }()
    let loginButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("Already have an account? Login", for: .normal)
        btn.setTitleColor(Color.text_grey, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 16)
        btn.backgroundColor = .none
        btn.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func didTapLogin(){
        navigationController?.pushViewController(LoginVC(), animated: true)
    }
    @objc func hideKeyboard(gesture : UITapGestureRecognizer){
        view.endEditing(true)
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    func setupViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(stackView)
        container.addSubview(signupButton)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        container.addSubview(loginButton)
    }
    func setupContraints(){
        scrollView.pin(to: view)
        container.pinToEdges(to: scrollView)
        bottomButtonConstraint =  signupButton.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottomButtonConstraint.isActive = true
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            container.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
          
            emailTextField.heightAnchor.constraint(equalToConstant: 58),
            passwordTextField.heightAnchor.constraint(equalToConstant: 58),
            
            loginButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 20),
            
            signupButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            signupButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            signupButton.heightAnchor.constraint(equalToConstant: 58),
        ])
    }
}

extension RegisterVC {
    func configureNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.medium.rawValue, size: 18.0)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 36.0)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeContentTitle = "Sign up"
        self.navigationItem.title = "Sign up"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    func configureBackButton(){
        let backImage =  UIImage(named: "uber-back")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        navigationController?.navigationBar.topItem?.backBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func closeVC(){
        navigationController?.popViewController(animated: true)
    }
}
extension RegisterVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isShowingKeyboard = true
    }
    @objc private func keyboardWillShow(notification: Notification){
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isShowingKeyboard{
                self.bottomButtonConstraint.constant = -280
            }
            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
            }
        }

    }
    @objc private func keyboardWillHide(notification: Notification){
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isShowingKeyboard{
                self.bottomButtonConstraint.constant = 0
            }
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
