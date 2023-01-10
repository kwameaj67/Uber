//
//  DriverAnnotation.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 09/01/2023.
//

import MapKit

class DriverAnnotation: NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    let uid: String
    
    init(uid: String, coordinate: CLLocationCoordinate2D){
        self.uid = uid
        self.coordinate = coordinate
    }
}


