//
//  LogInView.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State private var email = ""
    @State private var password = ""
    @State private var error: String? = nil
    
    func onLogIn() {
        error = nil
        session.signIn(email: email, password: password) { (result, error) in
            if error != nil {
                self.error = error?.localizedDescription
            } else {
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
                Button(action: onLogIn) {
                    Text("log in")
                        .kerning(-1)
                        .textStyle(TextBButtonActiveStyle())
                        .padding()
                }
            }.padding()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
