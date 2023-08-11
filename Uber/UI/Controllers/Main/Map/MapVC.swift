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
    var annotations = [MKAnnotation]()
    lazy var userAnnotation = MKPointAnnotation()
    let selectedAnnotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
    var placeMarkLocations = [MKPlacemark]()
    var span = MKCoordinateSpan(latitudeDelta: 0.0098, longitudeDelta: 0.0098) // map zoom level for user location
    var showDestinationView: Bool = false
    var route: MKRoute?
    var destination: MKMapItem?
    var locationQuery: String?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        showUserLocation()
        handleOverlayViews()
        
        if locationQuery != nil{  // if user is requesting trip for recent location
            animateOverlayViews()
            overlayLocationInputView.destinationLocationField.text = locationQuery
        }
    }
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: configureLocationService -
    func showUserLocation(){
        if let location = locationManager?.location {
            fetchDriverLocations()
            
            region = .init(center: location.coordinate, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
            region.span = .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            mapView.setRegion(region, animated:true) // user region
           
            userAnnotation.coordinate = location.coordinate
            userAnnotation.title = "Here"
            mapView.addAnnotation(userAnnotation)
            mapView.selectAnnotation(userAnnotation, animated: true)
            
            overlayLocationInputView.pickupLocationField.text = "Current location"
            overlayLocationInputView.pickupLocationField.isEnabled = false
            overlayLocationInputView.pickupLocationField.textColor = Color.blue
        
        }
    }
    
    // MARK: API's -
    func fetchDriverLocations(){
        guard let location = locationManager?.location else { return }
        driverService.fetchDriversLocations(location: location) { [weak self] driver in
            guard let coordinate = driver.location?.coordinate else { return }
           // print("DEBUG: Driver location: \(coordinate)")
            // annotation
            let annotation = DriverAnnotation(uid: driver.uid, coordinate: coordinate)
            
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
        }
    }
    
    func handleOverlayViews(){
        if showDestinationView{
            destinationView.isHidden = false
            destinationView.alpha = 1
            
            selectLocationView.isHidden = true
            selectLocationView.alpha = 0
        }else{
            destinationView.isHidden = true
            destinationView.alpha = 0
            
            selectLocationView.isHidden = false
            selectLocationView.alpha = 1
        }
    }
    // MARK: Properties -
    lazy var mapView: UberMapView = {
        let map = UberMapView()
        map.userTrackingMode = .follow
        map.delegate = self
        return map
    }()
    lazy var backButton: UberButton = {
        var btn = UberButton()
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
   
    lazy var rideActionView: OverlayRideActionView = {
        let v = OverlayRideActionView()
        v.transform = CGAffineTransform(translationX: 0, y: 200)
        v.isHidden = true
        v.alpha = 0
        return v
    }()
    
    // MARK: Selectors -
    @objc func didTapBackButton(){
        playHaptic(style: .medium)
        
        // if we selected a destination, and we tap back button
        if (rideActionView.destination != nil) {
            if self.showDestinationView {
                destinationView.isHidden = false
                destinationView.alpha = 1
            }else{
                selectLocationView.isHidden = false
                selectLocationView.alpha = 1
            }
            UIView.animate(withDuration: 0.3) {
                self.rideActionView.transform = CGAffineTransform(translationX: 0, y: 600)
            } completion: { _ in
                self.rideActionView.isHidden = true
                self.rideActionView.alpha = 0
            }
            self.rideActionView.destination = nil
            removeAnnotationsOverlay()
            
            // zoom into user location
            guard let location = locationManager?.location else { return }
            region = .init(center: location.coordinate, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
            region.span = .init(latitudeDelta: 0.098, longitudeDelta: 0.098)
            
            // set user region
            mapView.setRegion(region, animated:true)
           
            userAnnotation.coordinate = location.coordinate
            userAnnotation.title = "Here"
            mapView.addAnnotation(userAnnotation)
            mapView.selectAnnotation(userAnnotation, animated: true)
        }
        else {
            removeAnnotationsOverlay()
            destinationView.removeFromSuperview()
            selectLocationView.removeFromSuperview()
            overlayLocationInputView.removeFromSuperview()
            overlayLocationTableView.removeFromSuperview()
            rideActionView.removeFromSuperview()
            dismiss(animated: true, completion: nil)
        }
    }
    func setupViews(){
        view.addSubview(mapView)
        view.addSubview(backButton)
        backButton.bringSubviewToFront(mapView)
        view.addSubview(destinationView)
        view.addSubview(selectLocationView)
        view.addSubview(overlayLocationInputView)
        view.addSubview(overlayLocationTableView)
        view.addSubview(rideActionView)
        overlayLocationInputView.bringSubviewToFront(backButton)
        overlayLocationTableView.bringSubviewToFront(destinationView)
        overlayLocationTableView.bringSubviewToFront(selectLocationView)
        destinationView.bringSubviewToFront(destinationView)
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
            selectLocationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            selectLocationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rideActionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rideActionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rideActionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.52),
            rideActionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
