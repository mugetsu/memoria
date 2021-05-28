//
//  PostService.swift
//  memoria
//
//  Created by Randell Quitain on 26/5/21.
//

import UIKit
import Firebase

struct PostService {
    
    static let shared = PostService()
    static var id: String!
    static var ref: DatabaseReference!
    static var reminders = [Reminder<Double>]()
    static var users = [User]()
    private var databaseHandle: DatabaseHandle!
    
    func setRef(url: String) {
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = url
        PostService.ref = Database.database(url: components.url?.absoluteString ?? "").reference()
    }
    
    func setUser(uuid: String) {
        
        let container = "users"
        let ref = PostService.ref.child(container)
        PostService.id = "user_\(uuid)"
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.hasChild(PostService.id) {
                let userRef = ref.child(PostService.id)
                userRef.setValue(["id": PostService.id])
            }
        })
    }
    
    func userRef() -> DatabaseReference {
        
        let container = "users"
        return (PostService.ref?.child(container).child(PostService.id))!
    }
    
    func setNewReminder(id: String, title: String, body: String, date: TimeInterval) {
        
        let container = "reminders"
        let reminder: NSDictionary = [
            "id": id,
            "title": title,
            "body": body,
            "date": date
        ]
        
        userRef().child(container).child(id).setValue(reminder)
    }
}
