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
    weak var location: CLLocation?
    override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if  manager.authorizationStatus == .authorizedAlways{
            locationManager?.requestAlwaysAuthorization()
        }
    }
}
