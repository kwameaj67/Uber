//
//  MapViewVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 07/01/2023.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    private let locationViewHeight: CGFloat = 200
    let driverAnnotationIdentifier = "driverAnnotation"
    let locationManager = LocationManager.shared.locationManager
    let driverService = DriverService.shared
    let selectedAnnotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
    var placeMarkLocations = [MKPlacemark]()
    var showLocationView: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        configureLocationService()
//        showUserLocation()
        showOverlayView()
        if showLocationView == false{
            fetchDriverLocation()
        }
    }
    
    func showUserLocation(){
        let annotation = MKPointAnnotation()
        let authorizationStatus = locationManager?.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            guard let location = locationManager?.location else { return }
            annotation.coordinate = location.coordinate
            region = .init(center: location.coordinate, latitudinalMeters: 0.5, longitudinalMeters: 0.5)
            let span = MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09) // zoom level
            region.span = span
            mapView.setRegion(region, animated:true)
        }
    }
    // MARK: API's -
    func fetchDriverLocation(){
        guard let location = locationManager?.location else { return }
        driverService.fetchDriversLocations(location: location) { [weak self] driver in
            guard let coordinate = driver.location?.coordinate else { return }
            print("DEBUG: Driver location: \(coordinate)")
            // annotation
            let annotation = DriverAnnotation(uid: driver.uid, coordinate: coordinate)
            // region
            let region: MKCoordinateRegion = .init(center: coordinate, latitudinalMeters: 0.8, longitudinalMeters: 0.8)
            
            // prevents location changes to adjust creating duplicate annotations
            let driverLocation = self?.mapView.annotations.contains(where: { annotation -> Bool in
                guard let driverAnno = annotation as? DriverAnnotation else { return false }
                if driverAnno.uid == driver.uid{
                    print("DEBUG: handle driver annotation")
                    driverAnno.updateDriverAnnotationPosition(withCoordinate: coordinate)
                    return true  // update position
                }
                return false
            })
            var driverVisible: Bool {
                guard let driverLocation = driverLocation else { return false }
                return driverLocation
            }
            if !driverVisible{
                self?.mapView.addAnnotation(annotation)
            }
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // zoom level
            self?.mapView.region.span = span
            self?.mapView.setRegion(region, animated:true)
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

    func showOverlayView(){
        if showLocationView{ // shows "Where to?" view
            destinationView.isHidden = true
            destinationView.alpha = 0
            
            selectLocationView.isHidden = false
            selectLocationView.alpha = 1
        }else{
            destinationView.isHidden = false
            destinationView.alpha = 1
            
            selectLocationView.isHidden = true
            selectLocationView.alpha = 0
        }
    }
    // MARK: Properties -
    lazy var mapView: UberMapView = {
        let map = UberMapView()
        map.userTrackingMode = .follow
        map.delegate = self
        return map
    }()
    lazy var backButton: UIButton = {
        var btn = UIButton()
        let image = UIImage(named: "uber-back")?.withRenderingMode(.alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 20))
        btn.setImage(image, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 55/2
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
        v.delegate = self
        v.transform = CGAffineTransform(translationX: 0, y: 200)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var destinationView: OverlayDestinationView = {
        let v = OverlayDestinationView()
        v.delegate = self
        v.isHidden = true
        v.alpha = 0
        return v
    }()
    
    lazy var selectLocationView: OverlaySelectLocationView = {
        let v = OverlaySelectLocationView()
        v.delegate = self
        v.isHidden = true
        v.alpha = 0
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
        view.addSubview(selectLocationView)
        view.addSubview(overlayLocationInputView)
        view.addSubview(overlayLocationTableView)
        overlayLocationInputView.bringSubviewToFront(backButton)
        overlayLocationTableView.bringSubviewToFront(destinationView)
        overlayLocationTableView.bringSubviewToFront(selectLocationView)
    }
    
    func setupContraints(){
        mapView.pinToEdges(to: view)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 55),
            backButton.widthAnchor.constraint(equalToConstant: 55),
            
            destinationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            destinationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            destinationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            destinationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            selectLocationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectLocationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectLocationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13),
            selectLocationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
