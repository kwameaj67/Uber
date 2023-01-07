//
//  MapViewVC+Delegates.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 07/01/2023.
//

import UIKit
import MapKit

extension MapViewVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        region = .init(center: location.coordinate, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
        annotation.coordinate = location.coordinate
        
        // show user location on map
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated:true)
        mapView.userTrackingMode = .follow
    }
}
