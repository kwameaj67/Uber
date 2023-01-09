//
//  DriverService.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 08/01/2023.
//

import CoreLocation
import GeoFire

class DriverService {
    
    static let shared = DriverService()
    private let userService = UserService.shared
    
    private init(){}
    
    func fetchDriversLocations(location: CLLocation, completion: @escaping (User) -> Void){
        let geofire = GeoFire(firebaseRef: FirebaseDatabase.ref_driver_locations)
        
        FirebaseDatabase.ref_driver_locations.observe(.value, with: { snapshot in
            let query = geofire.query(at: location, withRadius: 50) // get drivers locations
            query.observe(.keyEntered, with: { uid, location in // gets driver uid location
                self.userService.fetchUserData(uid: uid) { user in // gets driver user data
                    // assign location to user
                    var driver = user
                    driver.location = location
                    completion(driver)
                }
            })
        })
    }
}
