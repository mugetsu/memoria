//
//  SignUpView.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @EnvironmentObject var session: FirebaseSession
    
    @State private var displayName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var error: String? = nil
    
    func onSignUp() {
        error = nil
        session.signUp(email: email, password: password) { (result, error) in
            if error != nil {
                self.error = error?.localizedDescription
            } else {
                let db = Firestore.firestore()
                db.collection("users")
                    .document(result!.user.uid)
                    .setData(["displayName": displayName, "email": email, "uid" :result!.user.uid]) { error in
                    if error != nil {
                        self.error = error?.localizedDescription ?? "An unknown error occurred"
                    }
                }
                self.displayName = ""
                self.email = ""
                self.password = ""
            }   
        }
    }
    
    var body: some View {
        if error != nil {
            Text(error ?? "There was an issue, please try again.")
                .foregroundColor(Color("blush"))
        }
        ZStack {
            Color("ivory")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                TextField("nickname", text: $displayName)
                    .font(.custom("Comfortaa-SemiBold", size: 21))
                    .foregroundColor(Color("gunMetal"))
                    .padding()
                    .frame(width: 320)
                    .background(Color("timberWolf"))
                    .cornerRadius(24)
                TextField("email", text: $email)
                    .font(.custom("Comfortaa-SemiBold", size: 21))
                    .foregroundColor(Color("gunMetal"))
                    .padding()
                    .frame(width: 320)
                    .background(Color("timberWolf"))
                    .cornerRadius(24)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("password", text: $password)
                    .font(.custom("Comfortaa-SemiBold", size: 21))
                    .foregroundColor(Color("gunMetal"))
                    .padding()
                    .frame(width: 320)
                    .background(Color("timberWolf"))
                    .cornerRadius(24)
                Button(action: onSignUp) {
                    Text("sign up")
                        .kerning(-1)
                        .textStyle(TextBButtonActiveStyle())
                        .padding()
                }
            }.padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
