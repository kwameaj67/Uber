//
//  LocationManager.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 08/01/2023.
//

import CoreLocation
import MapKit


class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    var locationManager: CLLocationManager!
    var location: CLLocation?    
    override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if  manager.authorizationStatus == .authorizedAlways{
            locationManager.requestAlwaysAuthorization()
        }
    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        region = .init(center: location.coordinate, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
//        annotation.coordinate = location.coordinate
//    }
    
}
