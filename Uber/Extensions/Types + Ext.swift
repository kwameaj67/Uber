//
//  Types + Ext.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 22/12/2022.
//

import Foundation


extension Double {
    func twoDecimalPlaces() -> String {
        return String(format: "%.2f", self)
    }
}
