//
//  Reminder.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Reminder: Codable, Identifiable {
    var id: String?
    var title: String
    var description: String
    var uid: String
    @ServerTimestamp var timestamp: Timestamp?
}
