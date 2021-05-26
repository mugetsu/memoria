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
    static var id: String = ""
    static var ref: DatabaseReference?
    
    func setRef(url: String) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = url
        PostService.ref = Database.database(url: components.url?.absoluteString ?? "").reference()
    }
    
    func setUser(uuid: String) {
        
        PostService.id = "user_\(uuid)"
        let userRef = PostService.ref?.child("users").child(PostService.id)
        userRef?.setValue(["id": PostService.id])
    }
    
    func userRef() -> DatabaseReference {
        return (PostService.ref?.child("users").child(PostService.id))!
    }
    
    func setNewReminder(id: String, title: String, body: String, date: TimeInterval) {
        
        let container = "reminders"
        let reminder: NSDictionary = [
            "title": title,
            "body": body,
            "date": date
        ]
        
        userRef()
            .child(container)
            .child(id)
            .setValue(reminder)
    }
}
