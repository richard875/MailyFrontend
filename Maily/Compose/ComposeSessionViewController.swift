//
//  ComposeSessionViewController.swift
//  Maily
//
//  Created by Richard Lee on 6/11/2022.
//

//import AppKit
import WebKit
import MailKit

class ComposeSessionViewController: MEExtensionViewController {
    @IBOutlet weak var webView1: WKWebView!
    
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        // Set the dimensions of the window.
        let newFrame = NSMakeRect(0, 0, 400, 200)
        self.view.window?.setFrame(newFrame, display: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        // Load the HTML page into the web view.
        let htmlPath = Bundle.main.path(forResource: "tracking", ofType: "html")
        let url = URL(fileURLWithPath: htmlPath!)
        let html = try? String(contentsOf: url)
        
        webView1.loadHTMLString(html!, baseURL: nil)
    }
}
