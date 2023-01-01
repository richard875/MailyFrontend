//
//  ComposeSessionViewController.swift
//  Maily
//
//  Created by Richard Lee on 6/11/2022.
//

import MailKit
import SwiftUI

class ComposeSessionViewController: MEExtensionViewController {
    private let session: MEComposeSession
    private var html: String
    private let trackingNumber: String?
    private var trackingNumberLoaded: Bool
    
    init(session: MEComposeSession, trackingNumber: String?) {
        self.session = session
        self.html = "<div></div>"
        self.trackingNumber = trackingNumber
        self.trackingNumberLoaded = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        // Load the HTML page into the web view and replace witht the tracking URL
        let htmlPath = Bundle.main.path(forResource: "tracking", ofType: "html")
        let url = URL(fileURLWithPath: htmlPath!)
        
        if let trackingNumber = self.trackingNumber {
            self.html = try! String(contentsOf: url).replacingOccurrences(of: "{{beacon}}", with: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.Beep)/\(trackingNumber).png")
            self.trackingNumberLoaded = true
        }
                        
        // Load view
        let hostingController = NSHostingController(rootView: ComposeView(session: session, html: self.html, trackingNumberLoaded: self.trackingNumberLoaded))
        self.view = hostingController.view
    }
}
