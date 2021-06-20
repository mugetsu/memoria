//
//  DashboardView.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI
import Firebase

struct DashboardView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State private var error: String? = nil
    @State private var userName: String? = nil
//    @State private var editNum: Int = 0
    
    func onLogOut() {
        let logInSuccess = session.logOut()
        if (!logInSuccess) {
            self.error = "Log out failed"
        }
    }
    
    func saveNumber(num: Int) {
        let db = Firestore.firestore()
        let numRef = db.collection("users").document(session.sessionUID ?? "")
        numRef.updateData([
            "number": num
        ]) { err in
            if let err = err {
                self.error = err.localizedDescription
            }
        }
    }
    
    func fetchUser() {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(session.sessionUID ?? "invaliduser")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.userName = document.data()?["name"] as? String
//                self.editNum = document.data()?["number"] as? Int ?? 0
            } else {
                self.error = error?.localizedDescription
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color("ivory")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                if userName == nil {
                    ProgressView()
                } else {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("welcome")
                            .font(.custom("Comfortaa-light", size: 42))
                            .foregroundColor(Color("gunMetal"))
                        Text(self.userName?.lowercased() ?? "")
                            .font(.custom("Comfortaa-Medium", size: 30))
                            .foregroundColor(Color("gunMetal"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    Spacer()
                        
                }
//                HStack(spacing: 12) {
//                    Button(action: {
//                        self.editNum = self.editNum - 1
//                        saveNumber(num: self.editNum)
//                    }) {
//                        Text("-")
//                            .font(.headline)
//                            .frame(width:20,height:20)
//                            .foregroundColor(.black)
//                            .overlay(
//                                Circle()
//                                    .stroke(Color.black, lineWidth: 1)
//                            )
//                    }
//                    Text(String(editNum))
//                    Button(action: {
//                        self.editNum = self.editNum + 1
//                        saveNumber(num: self.editNum)
//                    }) {
//                        Text("+")
//                            .font(.headline)
//                            .frame(width:20,height:20)
//                            .foregroundColor(.black)
//                            .overlay(
//                                Circle()
//                                    .stroke(Color.black, lineWidth: 1)
//                            )
//                    }
//                }
                Button(action: onLogOut) {
                    Text("log out")
                        .kerning(-1)
                        .textStyle(TextBButtonActiveStyle())
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
