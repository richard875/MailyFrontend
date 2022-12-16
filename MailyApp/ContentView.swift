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
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome to Maily")
                .font(.system(size: 25, weight: .bold))
            Text("Login to continue")
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            Button(action: {}) {
                Text("Sign In")
                    .padding(22)
                    .frame(width: 222, height: 44)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }.frame(width: 222, height: 44)
             .background(Color.blue).cornerRadius(10)
            
//            Button("Store local storage 2 (myUserName)") {
//                sharedUserDefaults?.set("myUserName", forKey: SharedUserDefaults.Keys.username)
//            }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
          .background(Color.white)
        .frame(width: 300, height: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
