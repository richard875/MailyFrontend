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
    private var serverAddress: String?
    private var trackingNumber: String?
    
    init(session: MEComposeSession, serverAddress: String?, trackingNumber: String?) {
        self.session = session
        self.serverAddress = serverAddress
        self.trackingNumber = trackingNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        // Load the HTML page into the web view and replace witht the tracking URL
        let htmlPath = Bundle.main.path(forResource: "tracking", ofType: "html")
        let url = URL(fileURLWithPath: htmlPath!)
        let html = try? String(contentsOf: url).replacingOccurrences(of: "{{beacon}}", with: "\(self.serverAddress!)\(self.trackingNumber!)")
        
        // Load view
        let hostingController = NSHostingController(rootView: ComposeView(session: session, html: html!))
        self.view = hostingController.view
    }
}
