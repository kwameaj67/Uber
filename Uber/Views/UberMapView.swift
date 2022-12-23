//
//  UberMapView.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 23/12/2022.
//

import UIKit
import MapKit

class UberMapView: MKMapView, MKMapViewDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        isZoomEnabled = true
        showsUserLocation = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
