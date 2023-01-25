//
//  Firebase.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 08/01/2023.
//

import Firebase


struct FirebaseDatabase{
    static let db_ref = Database.database().reference()
    static let ref_users = db_ref.child("users")
    static let ref_driver_locations = db_ref.child("driver-locations")
}
