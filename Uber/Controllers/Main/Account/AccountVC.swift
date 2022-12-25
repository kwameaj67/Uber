//
//  AccountVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/11/2022.
//

import UIKit

class AccountVC: UIViewController {
    
    let options = AccountOption.data
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Properties -
    let accountHeaderView: AccountHeaderView = {
        let v = AccountHeaderView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var accountTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(AccountOptionCell.self, forCellReuseIdentifier: AccountOptionCell.reusableID)
        tv.register(AccountActionHeader.self, forHeaderFooterViewReuseIdentifier: AccountActionHeader.reuseableID)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        tv.tableHeaderView = UIView()
        tv.tableFooterView = UIView()
        tv.allowsMultipleSelection = false
        tv.allowsSelection = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    func setupViews(){
        view.addSubview(accountHeaderView)
        view.addSubview(accountTableView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            accountHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            accountHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-15),
            accountHeaderView.heightAnchor.constraint(equalToConstant: 95),
            
            accountTableView.topAnchor.constraint(equalTo: accountHeaderView.bottomAnchor, constant: 5),
            accountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accountTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
