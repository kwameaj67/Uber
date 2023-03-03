//
//  ViewController.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 16/11/2022.
//

import UIKit

class OnboardVC: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.blue
        setupViews()
        setupContraints()
        navigationController?.navigationBar.isHidden = true
    }
   
    // MARK: Properties -
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 50
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let logoImage : UIImageView = {
        var iv = UIImageView()
        let img = UIImage(named: "uber-logo")?.withRenderingMode(.alwaysOriginal)
        iv.image = img
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let driveSafelyImage : UIImageView = {
        var iv = UIImageView()
        let img = UIImage(named: "drive")?.withRenderingMode(.alwaysOriginal)
        iv.image = img
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let sloganLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Move around safely"
        lb.textColor = .white
        lb.textAlignment = .center
        lb.font = UIFont(name: Font.medium.rawValue, size: 30)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
   
    lazy var getStartedButton: UberImageButton = {
        let v = UberImageButton(frame: .zero)
        v.textLabel.text = "Get Started"
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapGetStarted)))
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

  
    func setupViews(){
        view.addSubview(stackView)
        [logoImage,driveSafelyImage,sloganLabel].forEach{
            stackView.addArrangedSubview($0)
        }
        view.addSubview(getStartedButton)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
            logoImage.widthAnchor.constraint(equalToConstant: 80),
            logoImage.heightAnchor.constraint(equalToConstant: 30),
            
            driveSafelyImage.widthAnchor.constraint(equalToConstant: 250),
            driveSafelyImage.heightAnchor.constraint(equalToConstant: 250),
            
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            getStartedButton.heightAnchor.constraint(equalToConstant: 58),         
        ])
    }

}

extension OnboardVC{
    @objc func didTapGetStarted(){
        navigationController?.pushViewController(RegisterVC(), animated: true)
    }
}
