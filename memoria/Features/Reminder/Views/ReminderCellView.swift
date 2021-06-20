//
//  ReminderCellView.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import Foundation
import SwiftUI

struct ReminderCell: View {
    
    @ObservedObject var reminderCellVM: ReminderCellViewModel
    
    var onCommit: (Reminder) -> (Void) = { _ in }
    
    var body: some View {
        HStack {
            TextField("title", text: $reminderCellVM.reminder.title)
            TextField("description", text: $reminderCellVM.reminder.description)
            Button(action: { self.onCommit(reminderCellVM.reminder) }) {
                HStack {
                    Text("+")
                }
            }
        }
    }
}
