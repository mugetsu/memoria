//
//  ReminderCell.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI

struct ReminderCell: View {
    
    var reminder: Reminder
    
    var body: some View {
        Text(reminder.title)
    }
}
