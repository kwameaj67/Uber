//
//  HomeVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/11/2022.
//

import UIKit
import MapKit

class HomeVC: UIViewController, CLLocationManagerDelegate {
    
    private let userService = UserService.shared
    private let locationViewHeight: CGFloat = 200
    let places = RecentLocation.data
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupViews()
        setupContraints()
        configureLocationService()
        userService.fetchUserData() // we fetch user data on first tab (home)
    }
       
    func configureLocationService(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        region = .init(center: location.coordinate, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
        annotation.coordinate = location.coordinate
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
    
    lazy var overlayLocationInputView: OverLayLocationInputView = {
        let v = OverLayLocationInputView()
        v.isHidden = true
        v.alpha = 0
        v.delegate = self
        v.transform = CGAffineTransform(translationX: 0, y: -200)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var overlayLocationTableView: OverlayLocationTableView = {
        let v = OverlayLocationTableView()
        v.isHidden = true
        v.alpha = 0
        v.transform = CGAffineTransform(translationX: 0, y: 200)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        view.addSubview(recentLocationTableView)
        view.addSubview(overlayLocationInputView)
        view.addSubview(overlayLocationTableView)
    }
    
    func setupContraints(){
        recentLocationTableView.pinToSafeArea(to: view)
        NSLayoutConstraint.activate([
            overlayLocationInputView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayLocationInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayLocationInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayLocationInputView.heightAnchor.constraint(equalToConstant: locationViewHeight),
            
            overlayLocationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayLocationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayLocationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlayLocationTableView.heightAnchor.constraint(equalToConstant:  view.frame.height - locationViewHeight)
        ])
    }
}

extension HomeVC: SearchLocationDelegate, OverLayLocationInputViewDelegate{
    func animateOverlayViews(){

        UIView.animate(withDuration: 0.5) {
            self.overlayLocationInputView.isHidden = false
            self.overlayLocationInputView.alpha = 1
            self.overlayLocationInputView.transform = .identity
           
        } completion: { _ in
            print("DEBUG: presents locationInputView...")
            // animate right after inputView is shown
            UIView.animate(withDuration: 0.3) {
                self.overlayLocationTableView.transform = .identity
                self.overlayLocationTableView.isHidden = false
                self.overlayLocationTableView.alpha = 1
            } completion: { _ in
                print("DEBUG: presents locationTableView...")
            }
        }
    }
    func hideOverlayViews(){
        UIView.animate(withDuration: 0.4) {
            self.overlayLocationInputView.transform = CGAffineTransform(translationX: 0, y: -200)
            self.overlayLocationTableView.transform = CGAffineTransform(translationX: 0, y: 800)
        } completion: { _ in
            self.overlayLocationInputView.isHidden = true
            self.overlayLocationInputView.alpha = 0
            
            self.overlayLocationTableView.isHidden = true
            self.overlayLocationTableView.alpha = 0
            print("DEBUG: hides locationInputView...")
        }
    }
   
    func presentLocationInputView() {
        print("DEBUG: Handling present location view...")
        animateOverlayViews()
    }
    
    func dismissLocationInputView() {
        hideOverlayViews()
    }
}
