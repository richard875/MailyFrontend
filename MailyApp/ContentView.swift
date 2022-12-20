//
//  ContentView.swift
//  MailyApp
//
//  Created by Richard Lee on 6/11/2022.
//

import SwiftUI

struct ContentView: View {
    // Temp code
    let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)
    let localS = UserDefaults.standard
    
    // Actual code
    @State private var route: Route = Route.LOGIN
    
    var body: some View {
        VStack(spacing: 0) {
            switch route {
            case Route.INDEX:
                Index(setRoute: setRoute)
            case Route.LOGIN:
                Login(setRoute: setRoute)
            default:
                Text("Route not found")
            }
            BottomBar()
        }.onAppear(perform: fetchUser)
    }
    
    private func setRoute(newPage: Route) -> Void {
        route = newPage
    }
    
    private func fetchUser() {
        let defaults = UserDefaults.standard
        let token = defaults.value(forKey: "loginToken") as? String
        
        GetUser(token: token!) { response in
            self.route = response.httpStatus == HTTPResponseStatus.UNAUTHORIZED ? Route.LOGIN : Route.INDEX
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Button("Store local storage 2 (myUserName)") {
//   sharedUserDefaults?.set("myUserName", forKey: SharedUserDefaults.Keys.username)
// }
