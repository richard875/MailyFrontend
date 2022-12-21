//
//  ComposeView.swift
//  Maily
//
//  Created by Richard Lee on 12/21/22.
//

import Foundation
import SwiftUI
import MailKit

struct ComposeView: View {
    let session: MEComposeSession
    @State var html: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Tracker Code")
                .font(.system(size: 23))
                .fontWeight(.semibold)
            Text("Paste the HTML into Email")
                .padding(.top, 5)
                .font(.system(size: 13))
            Divider()
                .frame(width: 260)
                .overlay(Color("Divider"))
                .padding(.top, 12)
            WebView(html: $html)
                .frame(width: 260, height: 115)
                .border(Color("Divider"), width: 1)
                .cornerRadius(3)
                .padding(.top, 15)
        }
        .padding(.top, 20)
        .padding(.leading, 20)
        .frame(
            width: 300,
            height: 230,
            alignment: .topLeading
        )
        .background(Color("Background"))
    }
}
