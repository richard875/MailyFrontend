//
//  Loading.swift
//  MailyApp
//
//  Created by Richard Lee on 12/24/22.
//

import Foundation
import SwiftUI

struct Loading: View {
    var body: some View {
        VStack(spacing: 0) {
            ProgressView()
                .scaleEffect(0.7)
                .offset(y: 25)
        }
        .frame(width: 300, height: 439)
        .background(Color("Background"))
    }
}
