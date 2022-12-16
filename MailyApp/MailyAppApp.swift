//
//  MailyAppApp.swift
//  MailyApp
//
//  Created by Richard Lee on 6/11/2022.
//

import SwiftUI

@main
struct MailyAppApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "envelope.fill", accessibilityDescription: "Maily")
            statusButton.action = #selector(togglePopover)
        }
        
        popover = NSPopover()
        popover.contentSize = NSSize(width: 300, height: 500)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView())
        popover.setValue(true, forKeyPath: "shouldHideAnchor")
        
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            popover.isShown ? popover.performClose(nil) : popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
}
