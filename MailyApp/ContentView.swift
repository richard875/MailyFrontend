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
    @State private var loggedIn: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Login(setLoggedIn: setLoggedIn)
            BottomBar()
        }
    }
    
    private func setLoggedIn(newLoggedIn: Bool) -> Void {
        loggedIn = newLoggedIn
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
