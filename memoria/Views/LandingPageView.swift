//
//  LandingPageView.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("ivory")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 16) {
                    Text("memoria")
                        .font(.custom("Comfortaa-Bold", size: 42))
                        .foregroundColor(Color("gunMetal"))
                        .padding()
                    NavigationLink(destination: LogInView()) {
                        Text("log in")
                            .kerning(-1)
                            .textStyle(TextBButtonActiveStyle())
                    }
                    NavigationLink(destination: SignUpView()) {
                        Text("sign up")
                            .kerning(-1)
                            .textStyle(TextBButtonDefaultStyle())
                    }
                }
            }
        }.accentColor(Color("carolinaBlue"))
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
