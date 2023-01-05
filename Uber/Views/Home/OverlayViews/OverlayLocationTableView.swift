//
//  OverlayLocationTableView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 03/01/2023.
//

import UIKit

class OverlayLocationTableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var locationTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(LocationInputCell.self, forCellReuseIdentifier: LocationInputCell.reusableID)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .none
        tv.separatorStyle = .none
        tv.rowHeight = 65
        tv.tableFooterView = UIView()
        tv.allowsMultipleSelection = false
        tv.allowsSelection = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    func setupViews(){
        addSubview(locationTableView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            locationTableView.topAnchor.constraint(equalTo: topAnchor),
            locationTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension OverlayLocationTableView: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Saved Places" : "Locations"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? CGFloat(30) : CGFloat(20)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationInputCell.reusableID) as! LocationInputCell
        let bgView = UIView(frame: cell.bounds)
        bgView.backgroundColor = Color.textField_bg.withAlphaComponent(0.6)
        cell.selectedBackgroundView = bgView
        return cell
    }
}
