//
//  SettingsVC.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/28/23.
//

import UIKit

class SettingsVC: UIViewController {

    let authManager = FirebaseAuthManager.shared
    let userDefaultManager = UserDefaultsManager.shared
    lazy var sections = Section.sectionArray
    lazy var username: String = ""
    lazy var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        view.backgroundColor = .white
        username = userDefaultManager.getUserFullname()
        email = userDefaultManager.getUserEmail()
    }
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: Properties
    lazy var cancelButton: UberButton = {
        let cb = UberButton()
        let image = UIImage(named: "uber-exit")?.withRenderingMode(.alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(weight: .heavy))
        cb.setBackgroundImage(image, for: .normal)
        cb.backgroundColor = .none
        cb.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    lazy var smallTitleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Settings"
        lb.textColor = .black
        lb.alpha = 0
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var headerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var settingTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseableID)
        tv.register(SettingFooterView.self, forHeaderFooterViewReuseIdentifier: SettingFooterView.reuseableID)
        tv.register(SettingHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingHeaderView.reuseableID)
        tv.register(OptionHeaderView.self, forHeaderFooterViewReuseIdentifier: OptionHeaderView.reuseableID)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.tableHeaderView = UIView()
        tv.tableFooterView = UIView()
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 50
        tv.allowsMultipleSelection = false
        tv.allowsSelection = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: Selectors -
    @objc func didTapCancel(){
        dismiss(animated: true)
        self.removeFromParent()
        playHaptic(style: .medium)
    }
    
    func setupViews(){
        view.addSubview(headerView)
        headerView.addSubview(cancelButton)
        headerView.addSubview(smallTitleLbl)
        view.addSubview(settingTableView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 32),
            
            cancelButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 16),
            cancelButton.widthAnchor.constraint(equalToConstant: 16),
            
            smallTitleLbl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            smallTitleLbl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            settingTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            settingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

