//
//  ReminderList.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI

struct ReminderList: View {
    
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        ZStack {
            Color("ivory")
                .edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    ForEach (self.session.reminders) { reminder in
                        ReminderCell(reminder: reminder)
                            .listRowBackground(Color("ivory"))
                    }
                }
                Button(action: {}) {
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
        ReminderList()
    }
}
