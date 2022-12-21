//
//  WebView.swift
//  Maily
//
//  Created by Richard Lee on 12/22/22.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    @Binding var html: String
    
    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(html, baseURL: nil)
    }
}
