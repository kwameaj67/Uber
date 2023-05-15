//
//  WelcomeVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/11/2022.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
        navigationController?.navigationBar.isHidden = true
        animateImage()
        
        delay(duration: 3.0) {
            let tabBar = TabBarVC()
            self.smoothControllerTransition(for: tabBar)
        }
    }
    
    // MARK: Properties -
    
    lazy var textLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var iconImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "gps")?.withRenderingMode(.alwaysOriginal)
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    func setupViews(){
        view.addSubview(textLabel)
        view.addSubview(iconImage)
        
        textLabel.attributedText = setupAttributedText("Welcome to \nUber", "Customising your experience...")
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 60),
            iconImage.widthAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    func animateImage(){
        UIView.animate(withDuration: 0.2) {
            self.iconImage.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            UIView.animate(
                withDuration: 1.2,
                delay: 0,
                options: [.repeat, .curveLinear]
            ) {
                self.iconImage.transform = CGAffineTransform(rotationAngle: 2 * .pi)
            }
        }
    }
    
    func setupAttributedText(_ title: String, _ subTitle: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.black,.font: UIFont(name: Font.medium2.rawValue, size: 40)!]))
        text.append(NSAttributedString(string: "\n\n\n\(subTitle)", attributes: [.foregroundColor: UIColor.black,.font: UIFont(name: Font.regular.rawValue, size: 20)!]))
        return text
    }
   
}
