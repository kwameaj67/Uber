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
    let firebaseManager = FirebaseAuthManager.shared
    let locationManager = LocationManager.shared.locationManager
    let userDefaultManager = UserDefaultsManager.shared
    let driverService = DriverService.shared
    let annotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
    var spanDelta = MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8) // zoom level
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupViews()
        setupContraints()
        configureLocationService()
        showUserLocationOnMap()
        fetchUserData()
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
    func showUserLocationOnMap(){
        let authorizationStatus = locationManager?.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            guard let location = locationManager?.location else { return }
            print("DEBUG: My Location: \(location.coordinate)")
            annotation.coordinate = location.coordinate
            region = .init(center: location.coordinate, latitudinalMeters: 0.5, longitudinalMeters: 0.5)
        }
    }
    // MARK: API -
    func fetchUserData(){
        guard let uid = firebaseManager.currentUser else { return }
        userService.fetchUserData(uid: uid) { [weak self] user in
            let me = [
                "uid": uid,
                "email": user.email,
                "fullname": user.fullname,
                "accountType": user.accountType,
            ]
            self?.userDefaultManager.saveUserInfo(user: me)
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
        tv.estimatedRowHeight = 60
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
    
    func navigateToMapVC(locationQuery: String?, showDestinationView: Bool){
        playHaptic(style: .medium)
        let mapVC = MapVC()
        mapVC.locationQuery = locationQuery
        mapVC.showDestinationView  = showDestinationView
        mapVC.modalPresentationStyle = .custom
        mapVC.modalTransitionStyle = .crossDissolve
        present(mapVC, animated: true, completion: nil)
    }
}
