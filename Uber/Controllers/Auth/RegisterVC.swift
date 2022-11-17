//
//  LoginVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 17/11/2022.
//

import UIKit

class RegisterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .white
        title = "Sign up"
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
        navigationController?.popViewController(animated: true)
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
            signupButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 58),
        ])
    }
}

extension RegisterVC {
    func configureNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 18.0)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 32.0)!,NSAttributedString.Key.foregroundColor: UIColor.black]
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
