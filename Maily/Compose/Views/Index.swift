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
    @State var trackingNumberLoaded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Tracker Code")
                .font(.system(size: 23))
                .fontWeight(.semibold)
            Text("Paste the HTML into Email (⌘ + A)")
                .padding(.top, 5)
                .font(.system(size: 13))
            if (trackingNumberLoaded) {
                WebView(html: $html)
                    .frame(width: 260, height: 130)
                    .border(Color("Border"), width: 1)
                    .cornerRadius(7)
                    .padding(.top, 12)
            } else {
                ZStack {
                    Rectangle()
                        .frame(width: 260, height: 130)
                        .cornerRadius(7)
                        .foregroundColor(Color("Border"))
                    Text("Please login first and try again")
                        .font(.system(size: 13))
                }.padding(.top, 12)
            }
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
