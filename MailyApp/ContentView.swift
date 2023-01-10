//
//  ContentView.swift
//  MailyApp
//
//  Created by Richard Lee on 6/11/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        VStack(spacing: 0) {
            switch self.appDelegate.route {
            case Route.INDEX:
                Index(setRoute: setRoute)
            case Route.LOGIN:
                Login(setRoute: setRoute)
                BottomBar()
            case Route.LOADING:
                Loading()
            default:
                Text("Route not found")
            }
        }
    }
    
    private func setRoute(newPage: Route) -> Void {
        self.appDelegate.route = newPage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
