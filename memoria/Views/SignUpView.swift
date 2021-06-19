//
//  SignUpView.swift
//  memoria
//
//  Created by Randell Quitain on 6/20/21.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State private var name = ""
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
                db.collection("users").document(result!.user.uid).setData(["name":name,"email":email,"uid":result!.user.uid]) { (error) in
                    if error != nil {
                        self.error = error?.localizedDescription ?? "An unknown error occurred"
                    }
                }
                self.name = ""
                self.email = ""
                self.password = ""
            }   
        }
    }
    
    var body: some View {
        if error != nil {
            Text(error ?? "There was an issue, please try again.")
                .foregroundColor(.red)
        }
        ZStack {
            Color("kobi")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                TextField("name", text: $name)
                    .font(.custom("Comfortaa-SemiBold", size: 21))
                    .foregroundColor(Color("richBlack"))
                    .padding()
                    .frame(width:320)
                    .background(Color("babyPowder"))
                    .cornerRadius(24)
                TextField("email", text: $email)
                    .font(.custom("Comfortaa-SemiBold", size: 21))
                    .foregroundColor(Color("richBlack"))
                    .padding()
                    .frame(width:320)
                    .background(Color("babyPowder"))
                    .cornerRadius(24)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("password", text: $password)
                    .font(.custom("Comfortaa-SemiBold", size: 21))
                    .foregroundColor(Color("richBlack"))
                    .padding()
                    .frame(width:320)
                    .background(Color("babyPowder"))
                    .cornerRadius(24)
                Button(action: onSignUp) {
                    Text("sign up")
                        .font(.custom("Comfortaa-SemiBold", size: 21))
                        .frame(width: 132, height: 50)
                        .foregroundColor(Color("richBlack"))
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color("babyPowder"))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color("babyPowder"), lineWidth: 1)
                        )
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
