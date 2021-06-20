//
//  FirebaseSession.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseSession: ObservableObject {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @Published var sessionUID: String?
    @Published var reminders = [Reminder]()
    
    var ref: DatabaseReference = Database.database().reference(withPath: "\(String(describing: Auth.auth().currentUser?.uid ?? "invaliduser"))")
    
    func listen() {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.sessionUID = user.uid
                self.getReminders()
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
    
    func getReminders() {
        ref.observe(DataEventType.value) { snapshot in
            self.reminders = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let reminder = Reminder(snapshot: snapshot) {
                    self.reminders.append(reminder)
                }
            }
        }
    }
}
