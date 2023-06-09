//
//  UserDefaultsManager.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 05/01/2023.
//

import UIKit


class UserDefaultsManager{
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    private var manager = UserDefaults.standard
    
    func setUserFullName(fullName: String){
        manager.setValue(fullName, forKey: "fullname")
    }
    
    func setUserEmail(email: String){
        manager.setValue(email, forKey: "email")
    }
    
    func getUserFullName() -> String{
        let name = manager.string(forKey: "fullname")
        return name ?? "No Name"
    }
    
    func getUserEmail() -> String{
        let name = manager.string(forKey: "email")
        return name ?? "No Email"
    }
    
    func removeFullName(){
        manager.removeObject(forKey: "fullname")
    }
}
