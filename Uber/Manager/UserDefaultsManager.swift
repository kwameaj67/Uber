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
        guard let info = manager.object(forKey: USER_OBJECT_KEY) as? [String: Any] else { return nil }
        let user = User(uid: info["uid"] as! String, dictionary: info)
        return user
    }
    
    private func getUserProperty<T>(_ key: String) -> T? {
        guard let info = getUserInfo() else { return nil }
        return info[key] as? T
    }
    
    func getUserFullname() -> String {
       return getUserProperty("fullname") ?? ""
    }
    
    func getUserEmail() -> String {
        return getUserProperty("email") ?? ""
    }
    
    func removeUserInfo(){
        manager.removeObject(forKey: USER_OBJECT_KEY)
    }
}
