//
//  login.swift
//  MailyApp
//
//  Created by Richard Lee on 12/16/22.
//

import Foundation
import SwiftUI

struct Login: View {
    var setLoggedIn: ((Bool) -> Void)
    
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
                Text("Login to continue")
                    .padding(.top, 5)
                    .font(.system(size: 13))
                Text(message)
                    .font(.system(size: 10))
                    .foregroundColor(Color.red)
                    .padding(.top, 15)
                TextField("Email", text: $email)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 10)
                    .font(.system(size: 10))
                    .frame(width: 260, height: 35)
                    .background(Color("InputBackgroundGray"))
                    .cornerRadius(7)
                    .padding(.top, 5)
                SecureField("Password", text: $password)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 10)
                    .font(.system(size: 10))
                    .frame(width: 260, height: 35)
                    .background(Color("InputBackgroundGray"))
                    .cornerRadius(7)
                    .padding(.top, 10)
                HStack {
                    Text("Forgot Password?")
                        .onHover { hovering in
                            hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                        }
                        .font(.system(size: 10))
                        .foregroundColor(Color("LoginBlue"))
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    Text("Sign up")
                        .onHover { hovering in
                            hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                        }
                        .font(.system(size: 10))
                        .foregroundColor(Color("LoginBlue"))
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
                    loading.toggle()
                    message = " "
                    
                    login(email: email, password: password) { loginResponse in
                        // Use the loginResponse object as needed
                        if (loginResponse.returnStatus == ReturnStatus.ERROR) {
                            message = loginResponse.message
                        } else {
                            let defaults = UserDefaults.standard
                            defaults.set(loginResponse.message, forKey: "loginToken")
                            defaults.synchronize()
                            setLoggedIn(true)
                        }
                        
                        loading.toggle()
                    }
                } label: {
                    Text("Login")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Background"))
                }
                .buttonStyle(PlainButtonStyle())
                .frame(
                    width: 260,
                    height: 35
                )
                .background(Color("BackgroundInverse"))
                .cornerRadius(7)
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                }
                HStack(spacing: 0) {
                    Text("By signing in you accept our ")
                        .font(.system(size: 9))
                        .foregroundColor(Color("TextGray"))
                    Text("Terms of use")
                        .underline()
                        .font(.system(size: 9))
                        .foregroundColor(Color("TextGray"))
                        .onHover { hovering in
                            hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                        }
                }
                .padding(.top, 12)
                HStack(spacing: 0) {
                    Text("and ")
                        .font(.system(size: 9))
                        .foregroundColor(Color("TextGray"))
                    Text("Privacy Policy")
                        .underline()
                        .font(.system(size: 9))
                        .foregroundColor(Color("TextGray"))
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
}
