//
//  User.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 16/12/2022.
//

import Foundation


struct User {
    
}

enum RecentLocationType{
    case work
    case random
}
struct RecentLocation {
    var name: String
    var location: String
    var icon: RecentLocationType
    
    
    static let data: [RecentLocation] = [
        RecentLocation(name: "Work", location: "Petra Trust Company Limited", icon: .work),
        RecentLocation(name: "Accra Mall", location: "Plot C11 Tetteh Quarshie Interchange, Spintex Rd, Accra", icon: .random),
        RecentLocation(name: "Labone", location: "Accra", icon: .random),
    ]
}
