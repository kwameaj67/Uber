//
//  AuthManager.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 12/12/2022.
//

import Foundation
import Firebase


struct FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    private let auth =  Auth.auth()
    private let ref = Database.database().reference()

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
            if let user = results?.user {
                let values:[String: Any] = [
                    "email": emailAddress,
                    "fullname": fullname,
                    "accountType": self.resolveAccountType(index: accountType)
                ]
                
                // store user in db
                ref.child("users").child(user.uid).updateChildValues(values) { error, ref in
                    if let err = error {
                        completion(nil,err)
                        return
                    }
                    print("User Successfully created!")
                    completion(user.uid,nil)
                }
            }
        }
    }
    // login user
    func signInUserAccount(emailAddress: String, password: String, completion: @escaping (String?,Error?) -> Void){
        auth.signIn(withEmail: emailAddress, password: password) { results, error in
            if let err = error {
                completion(nil,err)
            }
            guard let user = results?.user else { return }
            completion(user.uid,nil)
        }
    }
    // log out user
    func logOutUser() -> Result<Void,Error>{
        do {
            try auth.signOut()
            //remove user object from userDefaults
            
            return .success(())
        }
        catch let error {
            return .failure(error)
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
