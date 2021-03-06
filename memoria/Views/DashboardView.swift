//
//  DashboardView.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI
import Firebase

struct DashboardView: View {
    
    @EnvironmentObject var session: FirebaseSession
    
    @State private var error: String? = nil
    @State private var displayName: String? = nil
    
    func onLogOut() {
        let logInSuccess = session.logOut()
        if (!logInSuccess) {
            self.error = "Log out failed"
        }
    }
    
    func fetchUser() {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(session.sessionUID ?? "invaliduser")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.displayName = document.data()?["displayName"] as? String
            } else {
                self.error = error?.localizedDescription
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color("ivory")
                .edgesIgnoringSafeArea(.all)
            VStack {
                if displayName == nil {
                    ProgressView()
                } else {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("welcome")
                            .font(.custom("Comfortaa-light", size: 42))
                            .foregroundColor(Color("gunMetal"))
                        Text(self.displayName?.lowercased() ?? "")
                            .font(.custom("Comfortaa-Medium", size: 30))
                            .foregroundColor(Color("gunMetal"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    Spacer()
                }
                ReminderListView()
                Button(action: onLogOut) {
                    Text("log out")
                        .kerning(-1)
                        .textStyle(TextBButtonDefaultStyle())
                }
            }.onAppear(perform: fetchUser)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
