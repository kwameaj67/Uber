//
//  LoadingVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 18/12/2022.
//

import UIKit

class LoadingVC: UIViewController {
    
    let authManager = FirebaseAuthManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        delay(duration: 1.0) {
            self.checkIfUserIsLoggedIn()
        }
    }
    
    func checkIfUserIsLoggedIn(){
        print(authManager.currentUser ?? "no id")
        if authManager.isLoggedIn {
            loadingIndicator.stopAnimating()
            smoothControllerTransition(for: TabBarVC())
        }else {
            let onboardingVC = UINavigationController(rootViewController: OnboardVC())
            smoothControllerTransition(for: onboardingVC)
        }
    }
    
    // MARK: Properties
    let uberLogo : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named:"uber-logo")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(frame: .zero)
        ai.color  = .systemGray5
        ai.style = .medium
        ai.startAnimating()
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    func setupViews(){
        view.addSubview(uberLogo)
        view.addSubview(loadingIndicator)
    }
    // MARK: Contriants
    func setupContraints(){
        NSLayoutConstraint.activate([
            uberLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            uberLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uberLogo.widthAnchor.constraint(equalToConstant: 127),
            uberLogo.heightAnchor.constraint(equalToConstant: 43),
            
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    

}
