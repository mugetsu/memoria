//
//  LandingPageView.swift
//  memoria
//
//  Created by Randell Quitain on 6/20/21.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("kobi")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("memoria")
                        .font(.custom("Comfortaa-Bold", size: 42))
                        .foregroundColor(Color("babyPowder"))
                    NavigationLink(destination: LogInView()) {
                        Text("log in")
                            .font(.custom("Comfortaa-SemiBold", size: 21))
                            .frame(width: 180, height: 50)
                            .foregroundColor(Color("babyPowder"))
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color("independence"))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color("independence"), lineWidth: 1)
                            )
                    }
                    NavigationLink(destination: SignUpView()) {
                        Text("sign up")
                            .font(.custom("Comfortaa-SemiBold", size: 21))
                            .frame(width: 180, height: 50)
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
                }
            }
        }.accentColor(Color("richBlack"))
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
