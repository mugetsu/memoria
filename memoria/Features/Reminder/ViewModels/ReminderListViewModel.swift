//
//  ReminderListViewModel.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import Foundation
import Combine

class ReminderListViewModel: ObservableObject {
    @Published var reminderRepository = ReminderRepository()
    @Published var reminderCellViewModels = [ReminderCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        reminderRepository.$reminders.map { reminders in
            reminders.map { reminder in
               ReminderCellViewModel(reminder: reminder)
            }
        }
        .assign(to: \.reminderCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addReminder(reminder: Reminder) {
        reminderRepository.addReminder(reminder)
    }
}

