//
//  ReminderList.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI

struct ReminderListView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var reminderListVM = ReminderListViewModel()
    @State var presentAddNewItem = false
    
    var body: some View {
        ZStack {
            Color("ivory")
                .edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    ForEach(reminderListVM.reminderCellViewModels) { reminderCellVM in
                        ReminderCell(reminderCellVM: reminderCellVM)
                    }
                    if presentAddNewItem {
                        ReminderCell(reminderCellVM: ReminderCellViewModel(reminder: Reminder(id: "", title: "", description: "", uid: ""))) { reminder in
                            self.reminderListVM.addReminder(reminder: reminder)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { presentAddNewItem.toggle() }) {
                    HStack {
                        Text("new reminder")
                    }
                }
                .frame(width: 180, height: 42)
                .font(.custom("Comfortaa-SemiBold", size: 21))
                .foregroundColor(Color("ivory"))
                .background(Color("carolinaBlue"))
                .cornerRadius(24)
                .padding()
            }
        }
    }
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color("ivory"))
        UITableViewCell.appearance().backgroundColor = UIColor(Color("ivory"))
    }
}

struct ReminderList_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView()
    }
}
