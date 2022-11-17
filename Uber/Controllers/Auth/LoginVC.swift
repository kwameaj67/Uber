//
//  LoginVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 17/11/2022.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .white
        title = "Log in"
        setupViews()
        setupContraints()
        configureNavBar()
        configureBackButton()
        navigationController?.navigationBar.isHidden = false
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
    lazy var loginButton: UberImageButton = {
        let v = UberImageButton(frame: .zero)
        v.forwardIcon.isHidden = true
        v.forwardIcon.alpha = 0
        v.textLabel.text = "Sign in"
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
    let signupButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("Don't have an account? Sign up", for: .normal)
        btn.setTitleColor(Color.text_grey, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 16)
        btn.backgroundColor = .none
        btn.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func didTapSignup(){
        navigationController?.pushViewController(RegisterVC(), animated: true)
    }
    func setupViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(stackView)
        container.addSubview(loginButton)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        container.addSubview(signupButton)
    }
    func setupContraints(){
        scrollView.pin(to: view)
        container.pinToEdges(to: scrollView)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            container.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
          
            emailTextField.heightAnchor.constraint(equalToConstant: 58),
            passwordTextField.heightAnchor.constraint(equalToConstant: 58),
           
            signupButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            signupButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 20),
           
            loginButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            loginButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 58),
        ])
       
    }
}

extension LoginVC {
    func configureNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 18.0)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 32.0)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeContentTitle = "Login"
        navigationController?.navigationItem.title = "Log in"
        
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
