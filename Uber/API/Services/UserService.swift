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
    func fetchRiderData(){
        guard let currentUserId = authManager.currentUser else { return }
        FirebaseDatabase.ref_users.child(currentUserId).observeSingleEvent(of: .value) { snapshot in
            guard let response = snapshot.value as? [String: Any] else { return }
            let user = User(uid: snapshot.key, dictionary: response)
            dump("\(user)")
           
        } withCancel: { error in
            print("DEBUG: \(error.localizedDescription)")
        }

    }
    
    func fetchUserData(uid: String, completion: @escaping (User) -> Void){
        FirebaseDatabase.ref_users.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let response = snapshot.value as? [String: Any] else { return }
            let user = User(uid: snapshot.key, dictionary: response)
            completion(user)
        } withCancel: { error in
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}





