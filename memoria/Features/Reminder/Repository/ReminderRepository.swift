//
//  ReminderRepository.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ReminderRepository: ObservableObject {
    
    @Published var reminders = [Reminder]()
    
    let db = Firestore.firestore()
    
    init() {
        loadData()
    }
    
    func getUID() -> String {
        guard let uid = Auth.auth().currentUser?.uid else {
            return ""
        }
        return uid
    }
    
    func loadData() {
        db.collection("reminders")
            .order(by: "timestamp")
            .whereField("uid", isEqualTo: getUID())
            .addSnapshotListener { (querySnapShot, error) in
            if let querySnapshot = querySnapShot {
                self.reminders = querySnapshot.documents.compactMap { document in
                    do {
                        let items = try document.data(as: Reminder.self)
                        return items
                    } catch {
                        print(error)
                    }
                    return nil
                }
            }
        }
    }

    func addReminder(_ reminder: Reminder) {
        var addedReminder = reminder
        addedReminder.uid = getUID()
        addedReminder.id = UUID().uuidString.lowercased()
        do {
            let _ = try db.collection("reminders").addDocument(from: addedReminder)
        } catch {
            fatalError("Unable to encode reminder \(error.localizedDescription)")
        }
        
    }
}
