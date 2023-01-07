//
//  MapViewVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 07/01/2023.
//

import UIKit
import MapKit

class MapViewVC: UIViewController {
    
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
        configureLocationService()
        // Do any additional setup after loading the view.
    }
    func configureLocationService(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: Properties -
    let mapView: UberMapView = {
        let mp = UberMapView()
        return mp
    }()
    let backButton: UIButton = {
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
    let destinationView: OverlayDestinationView = {
        let v = OverlayDestinationView()
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
        ])
    }

}
