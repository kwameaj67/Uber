//
//  User.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 09/01/2023.
//

import MapKit


struct User {
    let fullname: String
    let email: String
    let accountType: AccountType?
    var location: CLLocation?
    let uid: String
    
    init(uid: String, dictionary:[String: Any]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? AccountType
    }
}
