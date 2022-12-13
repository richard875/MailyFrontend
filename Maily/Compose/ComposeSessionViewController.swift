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
        
        // Load an HTML page into the web view.
        let htmlString = "<div style='background-color: red; width: 100%; height: 100%;'><h1>Hello World!</h1></div>"
        webView1.loadHTMLString(htmlString, baseURL: nil)
    }
}
