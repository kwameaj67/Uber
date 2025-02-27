//
//  LoginVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 17/11/2022.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    let authManager = FirebaseAuthManager.shared
    private var isShowingKeyboard:Bool = false
    private var bottomButtonConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .white
        title = "Log in"
        setupViews()
        setupContraints()
        configureNavBar()
        configureBackButton()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.largeContentTitle = "Sign in"
        self.navigationItem.title = "Sign in"
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(gesture:))))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Properties -
    lazy var scrollView : UIScrollView = {
        var sb = UIScrollView()
        sb.showsVerticalScrollIndicator = false
        sb.bounces = true
        sb.alwaysBounceVertical = true
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    lazy var container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var loginButton: UberButton = {
        let ub = UberButton(frame: .zero)
        ub.backgroundColor = Color.black
        ub.setTitle("Login", for: .normal)
        ub.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 18)
        ub.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return ub
    }()
    
    lazy var emailTextField: UberTextField = {
        var tf = UberTextField()
        tf.placeholder = "Email"
        return tf
    }()
    
    lazy var passwordTextField: UberTextField = {
        var tf = UberTextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var signupButton: UberButton = {
        var btn = UberButton()
        btn.setTitle("Don't have an account? Sign up", for: .normal)
        btn.setTitleColor(Color.text_grey, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 16)
        btn.backgroundColor = .none
        btn.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var loaderView: UberLoaderOverlay = {
        let v = UberLoaderOverlay(frame: .zero)
        return v
    }()
    
    @objc func didTapLoginButton(){
        playHaptic(style: .medium)
        resignTextFields(fields: [emailTextField, passwordTextField])
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        loaderView.isOpen = true
        authManager.signInUserAccount(emailAddress: email, password: password) { [weak self] uid, error in
            guard let self = self else { return }
            
            if let err = error {
                loaderView.isOpen = false
                self.presentAlertError(title: "Error", message: err.localizedDescription)
                return
            }
            if let _ = uid {
                loaderView.isOpen = false
                print("Successfully Logged User")
                self.smoothControllerTransition(for: TabBarVC())
            }
        }
    }
    
    @objc func didTapSignup(){
        playHaptic(style: .light)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func hideKeyboard(gesture : UITapGestureRecognizer){
        view.endEditing(true)
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func setupViews(){
        view.addSubview(scrollView)
        view.addSubview(loaderView)
        scrollView.addSubview(container)
        container.addSubview(stackView)
        container.addSubview(loginButton)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        container.addSubview(signupButton) 
    }
    
    func setupContraints(){
        scrollView.pinToSafeArea(to: view)
        loaderView.pinToEdges(to: view)
        container.pinToEdges(to: scrollView)
        bottomButtonConstraint =  loginButton.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottomButtonConstraint.isActive = true
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            container.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
          
            emailTextField.heightAnchor.constraint(equalToConstant: 58),
            passwordTextField.heightAnchor.constraint(equalToConstant: 58),
           
            signupButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            signupButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 20),
           
            loginButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 58),
        ])
       
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isShowingKeyboard = true
    }
    @objc private func keyboardWillShow(notification: Notification){
        if let keyboardRectangle = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isShowingKeyboard{
                self.bottomButtonConstraint.constant = -(keyboardRectangle.height) + 20
            }
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }

    }
    @objc private func keyboardWillHide(notification: Notification){
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isShowingKeyboard{
                self.bottomButtonConstraint.constant = 0
            }
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
