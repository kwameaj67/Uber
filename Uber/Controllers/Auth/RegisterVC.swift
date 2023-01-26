//
//  LoginVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 17/11/2022.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    let authManager = FirebaseAuthManager.shared
    
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
        navigationController?.navigationBar.largeContentTitle = "Sign up"
        self.navigationItem.title = "Sign up"
        
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
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    lazy var registerButton: UberImageButton = {
        let ub = UberImageButton(frame: .zero)
        ub.forwardIcon.isHidden = true
        ub.forwardIcon.alpha = 0
        ub.textLabel.text = "Sign up"
        ub.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRegisterButton)))
        return ub
    }()
    let fullNameTextField: UberTextField = {
        var tf = UberTextField()
        tf.placeholder = "Fullname"
        return tf
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
    let userSegmentedContol: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider","Driver"])
        sc.isSelected = true
        sc.backgroundColor = Color.textField_bg
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = .white
        sc.setTitleTextAttributes([.font: UIFont(name: Font.medium.rawValue, size: 15)!], for: .normal)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    // MARK: Selectors -
    @objc func didTapLogin(){
        navigationController?.pushViewController(LoginVC(), animated: true)
    }
    @objc func hideKeyboard(gesture : UITapGestureRecognizer){
        view.endEditing(true)
        fullNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    @objc func didTapRegisterButton(){
        guard let fullname = fullNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }
        let accountTypeIndex = userSegmentedContol.selectedSegmentIndex
       
        authManager.createUserAccount(
            emailAddress: email,
            password: password,
            fullname: fullname,
            accountType: accountTypeIndex) { [weak self] uid, error in
            guard let self = self else { return }
            if let err = error {
                self.presentAlertError(title: "Error", message: err.localizedDescription)
                return
            }
            if let _ = uid {
                print("User Did Save")
                self.smoothControllerTransition(for: TabBarVC())
            }
           
        }
    }
    func didShowTabBar(){
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = TabBarVC()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    func resolveAccountType(index: Int) -> String{
        switch index {
        case 0:
            return "rider"
        case 1:
            return "driver"
        default:
            return "rider"
        }
    }
    func setupViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(userSegmentedContol)
        container.addSubview(stackView)
        container.addSubview(registerButton)
        stackView.addArrangedSubview(fullNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        container.addSubview(loginButton)
    }
    func setupContraints(){
        scrollView.pinToSafeArea(to: view)
        container.pinToEdges(to: scrollView)
        bottomButtonConstraint =  registerButton.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottomButtonConstraint.isActive = true
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            container.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            userSegmentedContol.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            userSegmentedContol.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            userSegmentedContol.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            
            stackView.topAnchor.constraint(equalTo: userSegmentedContol.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
          
            fullNameTextField.heightAnchor.constraint(equalToConstant: 58),
            emailTextField.heightAnchor.constraint(equalToConstant: 58),
            passwordTextField.heightAnchor.constraint(equalToConstant: 58),
            
            loginButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 20),
            
            registerButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            registerButton.heightAnchor.constraint(equalToConstant: 58),
        ])
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
