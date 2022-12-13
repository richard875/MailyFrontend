//
//  ContentView.swift
//  MailyApp
//
//  Created by Richard Lee on 6/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showDetails = false
    let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)
    let localS = UserDefaults.standard
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello World!")
            Button("Store local storage 2 (myUserName)") {
                print("Clicked One!")
                showDetails.toggle()
                
                sharedUserDefaults?.set("myUserName", forKey: SharedUserDefaults.Keys.username)
                let stringOne = sharedUserDefaults!.string(forKey: SharedUserDefaults.Keys.username)
                
                print("Test Suite: ", stringOne! as String)
            }
            
            Button("Store local storage 2 (localSetting)") {
                print("Clicked Two!")
                showDetails.toggle()
                
                sharedUserDefaults?.set("localSetting", forKey: SharedUserDefaults.Keys.username)
                let stringTwo = sharedUserDefaults!.string(forKey: SharedUserDefaults.Keys.username)
                
                print("Test Suite: ", stringTwo! as String)
            }
            
            if showDetails {
                Text("You should follow me on Twitter: @twostraws")
                    .font(.largeTitle)
            }
        }
        .frame(width: 300, height: 300)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
