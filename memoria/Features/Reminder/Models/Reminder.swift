//
//  Reminder.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI
import FirebaseDatabase

struct Reminder: Identifiable {
    
    let ref: DatabaseReference?
    let key: String
    let id: String
    var title: String
    var description: String
    var timestamp: Double
    
    
    init(key: String = "", title: String = "", description: String = "", timestamp: Double = 0) {
        self.ref = nil
        self.key = key
        self.id = key
        self.title = title
        self.description = description
        self.timestamp = timestamp
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let title = value["title"] as? String,
            let description = value["description"] as? String,
            let timestamp = value["timestamp"] as? Double else {
                return nil
            }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.id = snapshot.key
        self.title = title
        self.description = description
        self.timestamp = timestamp
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "description": description,
            "timestamp": timestamp
        ]
    }
}
