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
    }
    
    // MARK: Properties -
    
    let textLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let locationImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "gps")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black.withAlphaComponent(0.8)
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupViews(){
        view.addSubview(textLabel)
        view.addSubview(locationImage)
        
        textLabel.attributedText = setupAttributedText("Welcome to \nUber", "Customising your experience...")
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            locationImage.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 90),
            locationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationImage.heightAnchor.constraint(equalToConstant: 130),
            locationImage.widthAnchor.constraint(equalToConstant: 130),
            
        ])
    }
    
    func animateImage(){
        UIView.animate(withDuration: 0.4) {
            self.locationImage.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            UIView.animate(
                withDuration: 1.2,
                delay: 0,
                options: [.repeat, .curveLinear]
            ) {
                self.locationImage.transform = CGAffineTransform(rotationAngle: 2 * .pi)
            }
        }
    }
    
    func setupAttributedText(_ title: String, _ subTitle: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.black,.font: UIFont(name: Font.bold.rawValue, size: 45)!]))
        text.append(NSAttributedString(string: "\n\n\(subTitle)", attributes: [.foregroundColor: UIColor.black,.font: UIFont(name: Font.regular.rawValue, size: 20)!]))
        return text
    }
   
}
