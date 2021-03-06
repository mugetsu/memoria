//
//  FirebaseSession.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI
import Firebase

class FirebaseSession: ObservableObject {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @Published var sessionUID: String?
    
    func listen() {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.sessionUID = user.uid
            } else {
                // if we don't have a user, set our session to nil
                self.sessionUID = nil
            }
        }
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func logOut() -> Bool {
        do {
            try Auth.auth().signOut()
            self.sessionUID = nil
            return true
        } catch {
            return false
        }
    }
}
