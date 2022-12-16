//
//  BottomBar.swift
//  MailyApp
//
//  Created by Richard Lee on 12/17/22.
//

import Foundation
import SwiftUI

struct BottomBar: View {
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .frame(width: 260)
                .overlay(Color("Divider"))
            HStack {
                Text("Forgot Password?")
                    .font(.system(size: 10))
                    .foregroundColor(Color("LoginBlue"))
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                Text("Sign up")
                    .font(.system(size: 10))
                    .foregroundColor(Color("LoginBlue"))
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
            }.frame(
                width: 260
            )
            .padding(.top, 15)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .frame(
            width: 300,
            height: 61,
            alignment: .topLeading
        )
        .background(Color("Background"))
    }
}
