//
//  UserService.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 04/01/2023.
//

import UIKit
import Firebase


class UserService {
    
    static let shared = UserService()
    private let ref = Database.database().reference()
    private let authManager = FirebaseAuthManager.shared
    let userDefaultManager = UserDefaultsManager.shared
    
    private init() {}
        
    // MARK: API -
    func fetchUserData(){
        let currentUserId = authManager.currentUser!
        let users = ref.child("users")
        users.child(currentUserId).observeSingleEvent(of: .value) { snapshot in
            guard let response = snapshot.value as? [String: Any] else { return }
            let user = User(dictionary: response)
//            guard let fullname = res["fullname"] as? String else { return }
            print("DEBUG: Fullname: \(user.fullname)")
            self.userDefaultManager.setUserFullName(fullName: user.fullname)
        } withCancel: { error in
            print("DEBUG: \(error.localizedDescription)")
        }

    }
}





