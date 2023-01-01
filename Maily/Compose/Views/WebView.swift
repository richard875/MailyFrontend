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
        // Define a content rule list that blocks all outgoing connections
        let blockAllRule = """
            [{
                "trigger": {
                    "url-filter": ".*"
                },
                "action": {
                    "type": "block"
                }
            }]
        """
        
        // Convert the rule list string to data and then back to a string
        let blockAllRuleData = blockAllRule.data(using: .utf8)!
        let blockAllRuleString = String(data: blockAllRuleData, encoding: .utf8)!
        
        // Create a WKWebView
        let webView = WKWebView()
        
        // Create a WKContentRuleListStore and compile the rule list
        if let ruleListStore = WKContentRuleListStore.default() {
            ruleListStore.compileContentRuleList(forIdentifier: "BlockAllRuleList", encodedContentRuleList: blockAllRuleString) { (ruleList, error) in
                if let error = error {
                    print("Error compiling content rule list: \(error)")
                } else if let ruleList = ruleList {
                    // Add the compiled rule list to the user content controller
                    webView.configuration.userContentController.add(ruleList)
                }
            }
        }
        
        return webView
    }
    
    
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(html, baseURL: nil)
    }
}
