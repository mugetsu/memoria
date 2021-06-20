//
//  ReminderCellViewModel.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import Foundation
import Combine

class ReminderCellViewModel: ObservableObject, Identifiable {
    
    @Published var reminderRepository = ReminderRepository()
    @Published var reminder: Reminder
    
    private var cancellables = Set<AnyCancellable>()
    var id = ""
    
    init(reminder: Reminder) {
        
        self.reminder = reminder
        
        $reminder
            .compactMap { reminder in
                reminder.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
