//
//  OverlayLocationTableView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 03/01/2023.
//

import UIKit
import MapKit

protocol OverlayLocationTableViewDelegate: AnyObject {
    func didSelectLocationPlacemark(selectedPlacemark: MKPlacemark)
}

class OverlayLocationTableView: UIView {
    
    var placeMarkData = [MKPlacemark]() {
        didSet{
            locationTableView.reloadData()
        }
    }
    weak var delegate: OverlayLocationTableViewDelegate?
    
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
        tv.register(SavedPlacesCell.self, forCellReuseIdentifier: SavedPlacesCell.reusableID)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = Color.grey_bg.withAlphaComponent(0.8)
        tv.separatorStyle = .none
        tv.rowHeight = 68
        tv.tableHeaderView = UIView()
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
        return section == 0 ? "Saved Places" : " "
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return CGFloat(0)
        }
        else if section == 1{
            return CGFloat(0)
        }
        return CGFloat(0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : placeMarkData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: SavedPlacesCell.reusableID) as! SavedPlacesCell
            let bgView = UIView(frame: cell.bounds)
            bgView.backgroundColor = Color.textField_bg.withAlphaComponent(0.6)
            cell.selectedBackgroundView = bgView
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationInputCell.reusableID) as! LocationInputCell
            let bgView = UIView(frame: cell.bounds)
            bgView.backgroundColor = Color.textField_bg
            cell.selectedBackgroundView = bgView
            cell.placemark = placeMarkData[indexPath.row]
            return cell
        }
         return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let selectedPlacemark = placeMarkData[indexPath.row]
            delegate?.didSelectLocationPlacemark(selectedPlacemark: selectedPlacemark)
        }
    }
}
