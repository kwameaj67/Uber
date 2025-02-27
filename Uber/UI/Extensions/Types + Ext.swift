//
//  Types + Ext.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 22/12/2022.
//

import Foundation
import MapKit

extension Double {
    func twoDecimalPlaces() -> String {
        return String(format: "%.2f", self)
    }
}


extension MKPlacemark {
    var address: String? {
        get{
            guard let subThoroughFare = subThoroughfare else { return nil}
            guard let thoroughFare = thoroughfare else { return nil }
            guard let locality = locality else { return nil }
            guard let adminArea = administrativeArea else { return nil }
            
            return "\(subThoroughFare) \(thoroughFare), \(locality), \(adminArea)"
        }
    }
}

extension MKMapView {
    func zoomToFit(annotations: [MKAnnotation]){
        var zoomRect = MKMapRect.null
        
        annotations.forEach { annotation in
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01)
                
            zoomRect = zoomRect.union(pointRect)
        }
        let insets: UIEdgeInsets = .init(top: 100, left: 75, bottom: 400, right: 75)
        setVisibleMapRect(zoomRect, edgePadding: insets, animated: true)
    }
}
