//
//  MapViewVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 07/01/2023.
//

import UIKit
import MapKit

class MapViewVC: UIViewController {
    
    private let locationViewHeight: CGFloat = 200
    let locationManager = LocationManager.shared.locationManager
    let driverService = DriverService.shared
    let annotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        configureLocationService()
        showUserLocation()
        fetchDriverLocation()
    }
    
    func showUserLocation(){
        let authorizationStatus = locationManager?.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            annotation.coordinate = (locationManager?.location!.coordinate)!
            region = .init(center: (locationManager?.location?.coordinate)!, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
//            mapView.addAnnotation(annotation)
            mapView.setRegion(region, animated:true)
        }
    }
    // MARK: API's -
    func fetchDriverLocation(){
        guard let location = locationManager?.location else { return }
        driverService.fetchDriversLocations(location: location) { driver in
            guard let coordinate = driver.location?.coordinate else { return }
            let annotation = DriverAnnotation(uid: driver.uid, coordinate: coordinate)
            self.mapView.addAnnotation(annotation)
            
            // region
            let region: MKCoordinateRegion = .init(center: coordinate, latitudinalMeters: 0.8, longitudinalMeters: 0.8)
            self.mapView.setRegion(region, animated:true)
            print("DEBUG:name: \(driver.fullname) \(driver.email) location \(driver.location)")
        }
    }
    // MARK: Location -
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

    // MARK: Properties -
    let mapView: UberMapView = {
        let map = UberMapView()
        map.userTrackingMode = .follow
        return map
    }()
    lazy var backButton: UIButton = {
        var btn = UIButton()
        let image = UIImage(named: "uber-back")?.withRenderingMode(.alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 20))
        btn.setImage(image, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 60/2
        btn.adjustsImageWhenHighlighted = false
        btn.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
    lazy var destinationView: OverlayDestinationView = {
        let v = OverlayDestinationView()
        v.delegate = self
        return v
    }()
    
    // MARK: Selectors -
    @objc func didTapBackButton(){
        dismiss(animated: true, completion: nil)
    }
    func setupViews(){
        view.addSubview(mapView)
        view.addSubview(backButton)
        backButton.bringSubviewToFront(mapView)
        view.addSubview(destinationView)
        view.addSubview(overlayLocationInputView)
        view.addSubview(overlayLocationTableView)
        overlayLocationInputView.bringSubviewToFront(backButton)
        overlayLocationTableView.bringSubviewToFront(destinationView)
    }
    
    func setupContraints(){
        mapView.pinToEdges(to: view)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 60),
            
            destinationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            destinationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            destinationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            destinationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
