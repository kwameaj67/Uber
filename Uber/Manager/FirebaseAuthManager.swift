//
//  AuthManager.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 12/12/2022.
//

import Foundation
import Firebase
import GeoFire


struct FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    private let locationManager = LocationManager.shared.locationManager
    private let userDefaultManager = UserDefaultsManager.shared
    private let auth =  Auth.auth()
   
    private init() {}
    
    // check user is logged in
    var isLoggedIn: Bool {
        return auth.currentUser != nil
    }
    
    // get current user signed in
    var currentUser : String? {
        if let uid = auth.currentUser?.uid {
            return uid
        }
        return nil
    }
    // create user
    func createUserAccount(emailAddress: String, password: String, fullname: String, accountType: Int, completion: @escaping (String?,Error?) -> Void){
        auth.createUser(withEmail: emailAddress, password: password) { results, error in
            if let err = error {
                completion(nil,err)
                return
            }
            guard let uid = results?.user.uid else { return }
            
            let values:[String: Any] = [
                "email": emailAddress,
                "fullname": fullname,
                "accountType": self.resolveAccountType(index: accountType)
            ]
            if accountType == 1 { // added locations for drivers to track them
                let geofire = GeoFire(firebaseRef: FirebaseDatabase.ref_driver_locations)
                guard let location = locationManager?.location else { return }
                geofire.setLocation(location, forKey: uid) { error in
                    self.uploadUserToDb(uid: uid, values: values, completion: completion)
                }
            }
            self.uploadUserToDb(uid: uid, values: values, completion: completion)
        }
    }
    func uploadUserToDb(uid: String,values: [String: Any],completion: @escaping (String?,Error?) -> Void){
        FirebaseDatabase.ref_users.child(uid).updateChildValues(values) { error, ref in    // store user in db
            if let err = error {
                completion(nil,err)
                return
            }
            print("User Successfully created!")
            self.userDefaultManager.setUserFullName(fullName: values["fullname"] as! String)
            completion(uid,nil)
        }
    }
    // login user
    func signInUserAccount(emailAddress: String, password: String, completion: @escaping (String?,Error?) -> Void){
        auth.signIn(withEmail: emailAddress, password: password) { results, error in
            if let err = error {
                completion(nil,err)
            }
            guard let user = results?.user else { return }
//            self.userDefaultManager.setUserFullName(fullName: auth.currentUser. as! String)
            completion(user.uid,nil)
        }
    }
    // log out user
    func logOutUser(completion: @escaping (Result<Void,Error>)-> Void){
        do {
            try auth.signOut()
            userDefaultManager.removeFullName() //remove user name from userDefaults
            completion(.success(()))
        }
        catch let error {
            return completion(.failure(error))
        }
    }
    
    //resolve account type
    func resolveAccountType(index: Int) -> String{
        switch index {
        case 0:
            return "rider"
        case 1:
            return "driver"
        default:
            return "rider"
        }
    }
}
