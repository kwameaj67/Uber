//
//  DriverAnnotation.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 09/01/2023.
//

import MapKit
import UIKit

class DriverAnnotation: NSObject,MKAnnotation{
    dynamic var coordinate: CLLocationCoordinate2D
    let uid: String
    
    init(uid: String, coordinate: CLLocationCoordinate2D){
        self.uid = uid
        self.coordinate = coordinate
    }
    
    func updateDriverAnnotationPosition(withCoordinate coordinate: CLLocationCoordinate2D ){
        UIView.animate(withDuration: 0.2) {
            self.coordinate = coordinate
        }
    }
}


