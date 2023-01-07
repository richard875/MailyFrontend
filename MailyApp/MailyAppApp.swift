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
            DetailedContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var statusItem: NSStatusItem!
    private var mainPopover: NSPopover!
    private var secondaryPopover: NSPopover!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first { window.close() }
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "envelope.fill", accessibilityDescription: "Maily")
            statusButton.action = #selector(togglePopover)
        }
        
        mainPopover = NSPopover()
        mainPopover.contentSize = NSSize(width: 300, height: 500)
        mainPopover.behavior = .transient
        mainPopover.contentViewController = NSHostingController(rootView: ContentView())
        mainPopover.setValue(true, forKeyPath: "shouldHideAnchor")
        
        // Create and show the second content view window as a popup
        secondaryPopover = NSPopover()
        secondaryPopover.contentSize = NSSize(width: 350, height: 500)
        secondaryPopover.behavior = .transient
        secondaryPopover.contentViewController = NSHostingController(rootView: DetailedContentView())
        secondaryPopover.setValue(true, forKeyPath: "shouldHideAnchor")
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            popover.isShown ? popover.performClose(nil) : popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
}
