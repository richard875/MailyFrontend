//
//  ComposeSessionViewController.swift
//  Maily
//
//  Created by Richard Lee on 6/11/2022.
//

import MailKit
import SwiftUI

class ComposeSessionViewController: MEExtensionViewController {
    let session: MEComposeSession
    
    init(session: MEComposeSession) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let hostingController = NSHostingController(rootView: ComposeView(session: session))
        self.view = hostingController.view
    }
}
