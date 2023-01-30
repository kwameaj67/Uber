//
//  TripsVC.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 1/30/23.
//

import UIKit

class TripsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
        
    }
    
    // MARK: Properties
    let cancelButton: UIButton = {
        let cb = UIButton()
        let image = UIImage(named: "uber-exit")?.withRenderingMode(.alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
        cb.setBackgroundImage(image, for: .normal)
        cb.backgroundColor = .none
        cb.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    let filterButton: UIButton = {
        let cb = UIButton()
        cb.setTitle("Past", for: .normal)
        cb.setTitleColor(.black, for: .normal)
        cb.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 14)
        cb.setImage(UIImage(named: "uber-down")?.withRenderingMode(.alwaysOriginal), for: .normal)
        cb.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        cb.semanticContentAttribute = .forceRightToLeft
        cb.backgroundColor = Color.grey_bg
        cb.layer.cornerRadius = 40/2
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    let titleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Your trips"
        lb.textColor = .black
        lb.font = UIFont(name: Font.medium2.rawValue, size: 36)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: Selectors -
    @objc func didTapCancel(){
        dismiss(animated: true)
    }
    func setupViews(){
        view.addSubview(cancelButton)
        view.addSubview(filterButton)
        view.addSubview(titleLbl)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 20),
            cancelButton.widthAnchor.constraint(equalToConstant: 20),
            
            filterButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 85),
            
            titleLbl.topAnchor.constraint(equalTo: cancelButton.bottomAnchor,constant: 15),
            titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
}
