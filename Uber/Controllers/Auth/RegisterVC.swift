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
        addToolBarToFields()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.largeContentTitle = "Sign up"
        self.navigationItem.title = "Sign up"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(gesture:))))
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        fullNameTextField.delegate = self
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
    lazy var loaderView: UberLoaderOverlay = {
        let v = UberLoaderOverlay(frame: .zero)
        return v
    }()
    
    // MARK: Selectors -
    @objc func didTapLogin(){
        playHaptic(style: .light)
        navigationController?.pushViewController(LoginVC(), animated: true)
    }
    
    @objc func hideKeyboard(gesture : UITapGestureRecognizer){
        view.endEditing(true)
        fullNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @objc func didTapRegisterButton(){
        playHaptic(style: .medium)
        guard let fullname = fullNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }
        let accountTypeIndex = userSegmentedContol.selectedSegmentIndex
       
        loaderView.isOpen = true
        authManager.createUserAccount(
            emailAddress: email,
            password: password,
            fullname: fullname,
            accountType: accountTypeIndex) { [weak self] uid, error in
            guard let self = self else { return }
            if let err = error {
                loaderView.isOpen = false
                self.presentAlertError(title: "Error", message: err.localizedDescription)
                return
            }
            if let _ = uid {
                loaderView.isOpen = false
                print("User Did Save")
                let vc = WelcomeVC()
                vc.modalPresentationStyle = .custom
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let space1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let space2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let labelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        labelButton.setTitle("Done", for: .normal)
        labelButton.setTitleColor(.black, for: .normal)
        labelButton.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 15)
        labelButton.addTarget(self, action: #selector(onDone), for: .primaryActionTriggered)
        let doneBarItem = UIBarButtonItem(customView: labelButton)
        /// fix this layer - issue with constraints for doneBarItem
//        let barWidth = doneBarItem.customView?.widthAnchor.constraint(equalToConstant: 40)
//        barWidth?.isActive = true
//        let barHeight = doneBarItem.customView?.heightAnchor.constraint(equalToConstant: 40)
//        barHeight?.isActive = true
        doneBarItem.tintColor = UIColor.black
        toolbar.setItems([space1,space2,doneBarItem], animated: true)
        return toolbar
    }
    @objc func onDone(){
        playHaptic(style: .medium)
        if emailTextField.isFirstResponder{
            emailTextField.resignFirstResponder()
        }
        else if passwordTextField.isFirstResponder{
            passwordTextField.resignFirstResponder()
        }
        else if fullNameTextField.isFirstResponder{
            fullNameTextField.resignFirstResponder()
        }
    }
    func addToolBarToFields(){
        [fullNameTextField,emailTextField,passwordTextField].forEach { item in
            item?.inputAccessoryView = createToolBar()
        }
    }
   
    func setupViews(){
        view.addSubview(scrollView)
        view.addSubview(loaderView)
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
        loaderView.pinToEdges(to: view)
        container.pinToEdges(to: scrollView)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            container.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            userSegmentedContol.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            userSegmentedContol.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            userSegmentedContol.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            
            stackView.topAnchor.constraint(equalTo: userSegmentedContol.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
          
            fullNameTextField.heightAnchor.constraint(equalToConstant: 58),
            emailTextField.heightAnchor.constraint(equalToConstant: 58),
            passwordTextField.heightAnchor.constraint(equalToConstant: 58),
            
            loginButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 20),
            
            registerButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            registerButton.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 58),
            
        ])
    }
}


extension RegisterVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchBasedNextTextField(textField: textField)
        return true
    }
    private func switchBasedNextTextField(textField: UITextField){
        switch textField {
        case fullNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.resignFirstResponder()
        }
    }
}
