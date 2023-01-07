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
        // Create a window
        let invisibleWindow = NSWindow(contentRect: NSMakeRect(0, 0, 20, 5), styleMask: .borderless, backing: .buffered, defer: false)
        invisibleWindow.backgroundColor = .clear
        invisibleWindow.alphaValue = 0
        
        if let button = statusItem.button {
            if mainPopover.isShown {
                mainPopover.performClose(nil)
                // secondaryPopover.performClose(nil)
            } else {
                // find the coordinates of the statusBarItem in screen space
                let screenRect = button.window!.convertToScreen(button.bounds)
                
                // calculate the bottom center position (10 is the half of the window width)
                let posX = screenRect.origin.x + (screenRect.width / 2) - 10
                let posY = screenRect.origin.y
                
                // position and show the window
                invisibleWindow.setFrameOrigin(NSPoint(x: posX, y: posY))
                invisibleWindow.makeKeyAndOrderFront(self)
                
                // position and show the NSPopover
                mainPopover.show(relativeTo: invisibleWindow.contentView!.frame, of: invisibleWindow.contentView!, preferredEdge: NSRectEdge.minY)
                // secondaryPopover.show(relativeTo: CGRect(), of: mainPopover.contentViewController!.view, preferredEdge: NSRectEdge.minX)
                NSApp.activate(ignoringOtherApps: true)
            }
        }
    }
}
