//
//  ContentView.swift
//  MailyApp
//
//  Created by Richard Lee on 6/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var route: Route = Route.LOADING
    
    var body: some View {
        VStack(spacing: 0) {
            switch route {
            case Route.INDEX:
                Index(setRoute: setRoute)
            case Route.LOGIN:
                Login(setRoute: setRoute)
            case Route.LOADING:
                Loading()
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
        let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
        let token = defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
        if (token == nil) { return }
        
        GetUser(token: token!) { response in
            self.route = response.httpStatus == HTTPResponseStatus.OK ? Route.INDEX : Route.LOGIN
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
