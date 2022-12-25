//
//  HomeVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/11/2022.
//

import UIKit
import MapKit

class HomeVC: UIViewController, CLLocationManagerDelegate {
    
    let places = RecentLocation.data
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
        navigationController?.navigationBar.isHidden = true
       
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print(location.coordinate)
        region = .init(center: location.coordinate, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
        annotation.coordinate = location.coordinate
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
        tv.allowsMultipleSelection = false
        tv.allowsSelection = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    func setupViews(){
        view.addSubview(locationTableView)
    }
    
    func setupContraints(){
        locationTableView.pinToSafeArea(to: view)
    }

    @objc func didSelectLocationView(){
        print("did tap me")
    }
}
