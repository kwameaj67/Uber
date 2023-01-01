//
//  SearchLocationView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/12/2022.
//

import UIKit

protocol SearchLocationDelegate: AnyObject{
    func presentLocationInputView()
}
class SearchLocationView: UIView {

//    var controller: HomeVC? {
//        didSet{
//            locationBtn.addTarget(controller, action: #selector(HomeVC.didSelectLocationView), for: .touchUpInside)
//        }
//    }
    weak var delegate: SearchLocationDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        self.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    let searchIcon : UIImageView = {
        var iv = UIImageView()
        iv.image =  UIImage(named: "uber-search")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
   
    let locationBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Where to?", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = UIFont(name:  Font.medium.rawValue, size: 20)
        btn.backgroundColor = .none
        btn.addTarget(self, action: #selector(presentLocationInputView), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let timerView: UIView = {
        let v = ReserveRideView()
        v.layer.cornerRadius = 40/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    @objc func presentLocationInputView(){
        delegate?.presentLocationInputView()
    }
    func setupViews(){
        addSubview(searchIcon)
        addSubview(locationBtn)
        addSubview(timerView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            searchIcon.widthAnchor.constraint(equalToConstant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 22),
            
            locationBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            locationBtn.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 15),
            locationBtn.heightAnchor.constraint(equalTo: heightAnchor),
            
            timerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            timerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            timerView.heightAnchor.constraint(equalToConstant: 40),
            timerView.widthAnchor.constraint(equalToConstant: 125),
        ])
    }

}
