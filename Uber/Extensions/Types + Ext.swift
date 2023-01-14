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
