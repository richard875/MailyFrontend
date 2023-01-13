//
//  login.swift
//  MailyApp
//
//  Created by Richard Lee on 12/16/22.
//

import Foundation
import SwiftUI

struct Login: View {
    var setRoute: ((Route) -> Void)
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var loading: Bool = false
    @State private var message : String = " "
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                if (loading) {
                    ProgressView()
                        .scaleEffect(0.5)
                        .offset(x: 235)
                }
                Text("Welcome to Maily")
                    .font(.system(size: 23))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Text"))
                Text("Login to continue")
                    .padding(.top, 5)
                    .font(.system(size: 13))
                    .foregroundColor(Color("Text"))
                Text(message)
                    .font(.system(size: 10))
                    .foregroundColor(Color.red)
                    .padding(.top, 15)
                TextField("Email", text: $email)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 10)
                    .font(.system(size: 10))
                    .frame(width: 260, height: 35)
                    .background(Color("Grey Background"))
                    .overlay(RoundedRectangle(cornerRadius: 7)
                        .stroke(Color("Border"), lineWidth: 1)
                    )
                    .cornerRadius(7)
                    .padding(.top, 5)
                    .onSubmit {
                        self.login()
                    }
                SecureField("Password", text: $password)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 10)
                    .font(.system(size: 10))
                    .frame(width: 260, height: 35)
                    .background(Color("Grey Background"))
                    .overlay(RoundedRectangle(cornerRadius: 7)
                        .stroke(Color("Border"), lineWidth: 1)
                    )
                    .cornerRadius(7)
                    .padding(.top, 10)
                    .onSubmit {
                        self.login()
                    }
                HStack {
                    Text("Forgot Password?")
                        .onHover { hovering in
                            hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                        }
                        .font(.system(size: 10))
                        .foregroundColor(Color.blue)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    Text("Sign up")
                        .onHover { hovering in
                            hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                        }
                        .font(.system(size: 10))
                        .foregroundColor(Color.blue)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .trailing
                        )
                }.frame(
                    width: 260
                )
                .padding(.top, 10)
            }
            .padding(.top, loading ? 10 : 42)
            .padding(.leading, 20)
            .frame(
                width: 300,
                height: 250,
                alignment: .topLeading
            )
            VStack(spacing: 0) {
                Button {
                    self.login()
                } label: {
                    Text("Login")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Text - Inverse"))
                }
                .buttonStyle(PlainButtonStyle())
                .frame(
                    width: 260,
                    height: 35
                )
                .background(Color("Button on Black"))
                .cornerRadius(7)
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                }
                HStack(spacing: 0) {
                    Text("By signing in you accept our ")
                        .font(.system(size: 9))
                        .foregroundColor(Color("Text"))
                    Text("Terms of use")
                        .underline()
                        .font(.system(size: 9))
                        .foregroundColor(Color("Text"))
                        .onHover { hovering in
                            hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                        }
                }
                .padding(.top, 12)
                HStack(spacing: 0) {
                    Text("and ")
                        .font(.system(size: 9))
                        .foregroundColor(Color("Text"))
                    Text("Privacy Policy")
                        .underline()
                        .font(.system(size: 9))
                        .foregroundColor(Color("Text"))
                        .onHover { hovering in
                            hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                        }
                }.padding(.top, 2)
            }
            .padding(.top, 105)
            .padding(.leading, 20)
            .frame(
                width: 300,
                height: 189,
                alignment: .topLeading
            )
        }
        .frame(width: 300, height: 439)
        .background(Color("Background"))
    }
    
    private func login() {
        loading.toggle()
        self.message = ""
        
        if (self.email.trimmingCharacters(in: .whitespaces) == "" || self.password.trimmingCharacters(in: .whitespaces) == "") {
            self.message = "Please complete the login and password fields"
            loading.toggle()
            return
        }
        
        UserLogin(email: email, password: password) { loginResponse in
            // Use the loginResponse object as needed
            if (loginResponse.returnStatus == ReturnStatus.ERROR) {
                self.message = loginResponse.message
            } else {
                let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
                defaults.set(loginResponse.message, forKey: SharedUserDefaults.Keys.loginToken)
                defaults.synchronize()
                setRoute(Route.INDEX)
            }
            
            loading.toggle()
        }
    }
}
