//
//  UIViewController+Ext.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/11/2022.
//

import UIKit

enum AlertAction{
    case yes
    case no
}

extension UIViewController {
    
    func presentAlertError(title: String, message: String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlertDialog(title: String, message: String, completion: @escaping ( (AlertAction)-> Void? )){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            completion(.no)
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            completion(.yes)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentLoading(isOpen: Bool){
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 80, height: 80))
        indicator.center = self.view.center
        indicator.color = .gray
        indicator.layer.cornerRadius = 10
        indicator.backgroundColor = .black.withAlphaComponent(0.4)
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.medium
        
        if !isOpen {
            indicator.alpha = 0
            indicator.isHidden = true
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            print("removed")
        }
        else {
            self.view.addSubview(indicator)
            indicator.startAnimating()
        }
    }
    
    // navbar edits
    func configureNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold2.rawValue, size: 15.0)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.medium2.rawValue, size: 36.0)!,NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    
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
    
    func smoothControllerTransition(for vc: UIViewController){
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    func logoutSmoothControllerTransition(for vc: UIViewController){
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    func resignTextFields(fields: [UITextField]){
        fields.forEach { item in
            item.resignFirstResponder()
        }
    }
}
