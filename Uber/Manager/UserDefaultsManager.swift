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
    
    private let USER_OBJECT_KEY: String = "userInfo"
    
    func saveUserInfo(user: [String: Any]) {
        manager.set(user, forKey: USER_OBJECT_KEY)
    }
    
    func getUserInfo() -> User? {
        guard let info = manager.object(forKey: USER_OBJECT_KEY) as? [String: Any] else { return nil}
        let user = User(uid: info["uid"] as! String, dictionary: info)
        return user
    }
    
    func getUserFullname() -> String {
        guard let info = getUserInfo() else { return " " }
        return info.fullname
    }
    
    func getUserEmail() -> String {
        guard let info = getUserInfo() else { return " " }
        return info.email
    }
    
    func removeUserInfo(){
        manager.removeObject(forKey: USER_OBJECT_KEY)
    }
}
