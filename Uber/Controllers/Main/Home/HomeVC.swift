//
//  HomeVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/11/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    let places = RecentLocation.data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
        navigationController?.navigationBar.isHidden = true
       
    }
    
    // MARK: Properties -
    lazy var locationTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(RecentLocationCell.self, forCellReuseIdentifier: RecentLocationCell.reusableID)
        tv.register(HomeHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeHeaderView.reuseableID)
        tv.register(HomeFooterView.self, forHeaderFooterViewReuseIdentifier: HomeFooterView.reuseableID)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        tv.tableHeaderView = UIView()
        tv.tableFooterView = UIView()
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 75
        tv.allowsMultipleSelection = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    func setupViews(){
        view.addSubview(locationTableView)
    }
    
    func setupContraints(){
        locationTableView.pinToSafeArea(to: view)
    }

  
}
