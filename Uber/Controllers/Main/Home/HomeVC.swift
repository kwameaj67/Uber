//
//  HomeVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/11/2022.
//

import UIKit
import MapKit

class HomeVC: UIViewController {
    
    private let userService = UserService.shared
    let places = RecentLocation.data
    let locationManager = LocationManager.shared.locationManager
    let annotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupViews()
        setupContraints()
        configureLocationService()
        userService.fetchUserData()  // we fetch user data on first tab (home)
        showUserLocation()
        print(locationManager?.location as Any)
    }
       
    func configureLocationService(){
        switch locationManager?.authorizationStatus {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            locationManager?.requestAlwaysAuthorization()
        default:
            break
        }
    }
    func showUserLocation(){
        let authorizationStatus = locationManager?.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            annotation.coordinate = (locationManager?.location!.coordinate)!
            region = .init(center: (locationManager?.location?.coordinate)!, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
        }
    }
   
    // MARK: Properties -
    lazy var recentLocationTableView: UITableView = {
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
        view.addSubview(recentLocationTableView)
    }
    
    func setupContraints(){
        recentLocationTableView.pinToSafeArea(to: view)
    }
}
