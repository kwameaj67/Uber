//
//  User.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 09/01/2023.
//

import MapKit


class User {
    let fullname: String
    let email: String
    let accountType: String
    var location: CLLocation?
    let uid: String
    
    private var userData: [String: Any] = [:]
    
    subscript(key: String) -> Any? {
        return userData[key]
    }
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? String ?? ""
        
        self.userData = dictionary
    }
    
}
