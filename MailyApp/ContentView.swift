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
    var body: some View {
        Login()
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
