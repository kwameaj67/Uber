//
//  ActivityVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/11/2022.
//

import UIKit
import MapKit

class ActivityVC: UIViewController {
    
   
    let currentTrip: Trip = Trip.data.remove(at: 0)
    let trips = Trip.data
    //let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
        navigationController?.navigationBar.isHidden = true
    }
   
    // MARK: Properties -
    lazy var tripTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(PastTripCell.self, forCellReuseIdentifier: PastTripCell.reusableID)
        tv.register(ActivityHeaderView.self, forHeaderFooterViewReuseIdentifier: ActivityHeaderView.reuseableID)
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
        view.addSubview(tripTableView)
    }
    
    func setupContraints(){
        tripTableView.pinToSafeArea(to: view)
    }

}
