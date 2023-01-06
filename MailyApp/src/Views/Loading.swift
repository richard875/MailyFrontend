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
        }
        .frame(width: 300, height: 500)
        .background(Color("Background"))
    }
}
