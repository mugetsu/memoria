//
//  StartingView.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI

struct StartingView: View {
    
    @EnvironmentObject var session: FirebaseSession
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.sessionUID != nil) {
                DashboardView()
            }
            else {
                LandingPageView()
            }
        }.onAppear(perform: getUser)
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
