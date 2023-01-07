//
//  DetailedContentView.swift
//  MailyApp
//
//  Created by Richard Lee on 1/7/23.
//

import Foundation
import SwiftUI

struct DetailedContentView: View {
    var body: some View {
        VStack {
            Text("This is the DetailedContentView")
                .font(.title)
                .foregroundColor(.green)
            Spacer()
        }
        .frame(minWidth: 350, minHeight: 500)
        .background(Color.yellow)
    }
}
