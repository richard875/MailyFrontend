//
//  MailyAppApp.swift
//  MailyApp
//
//  Created by Richard Lee on 6/11/2022.
//

import SwiftUI
import Combine
import UserNotifications

@main
struct MailyAppApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appDelegate)
            DetailedContentView().environmentObject(appDelegate)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
    private var statusItem: NSStatusItem!
    @Published var mainPopover: NSPopover!
    @Published var secondaryPopover: NSPopover!
    @Published var secondaryPopoverEmailRecords: [Record] = []
    @Published var secondaryPopoverLoading: Bool = false
    @Published var route: Route = Route.LOADING
    @Published var selectedUserTracker: Tracker!
    @Published var profilePictureNumber: Int = Int.random(in: 1...33)
    @Published var selectedEmailView: EmailViewSort = EmailViewSort.LATEST_TO_OLDEST
    @Published var newNotification: Bool = false
    @Published var indexPageNumber: Int = 2
    private var selectedEmailViewCancellable: AnyCancellable?
    private var newNotificationCancellable = Set<AnyCancellable>()
    private var newNotificationPublisher: AnyPublisher<Bool, Never> {
        $newNotification.eraseToAnyPublisher()
    }
    
    private func fetchUser() {
        let token = self.defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
        if (token == nil) {
            self.route = Route.LOGIN
            return
        }
        
        GetUser(token: token!) { response in
            self.route = response.httpStatus == HTTPResponseStatus.OK ? Route.INDEX : Route.LOGIN
        }
    }
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        // Ask for notification permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in }
        
        // Get mail clicks when user change selectedEmailView
        selectedEmailViewCancellable = $selectedEmailView.sink { value in
            let token = self.defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
            if (token == nil) {
                self.route = Route.LOGIN
                return
            }
            
            if (self.selectedUserTracker != nil) {
                self.secondaryPopoverLoading = true
                
                GetTrackerClicks(token: token!, trackingNumber: self.selectedUserTracker.id, emailViewSort: value) { response in
                    if response.returnStatus == ReturnStatus.SUCCESS, let trackerRecords = response.TrackerRecords {
                        self.secondaryPopoverEmailRecords = trackerRecords
                        self.secondaryPopoverLoading = false
                    } else {
                        self.route = Route.LOGIN
                        self.secondaryPopover.close()
                        return
                    }
                }
            }
        }
        
        if let window = NSApplication.shared.windows.first { window.close() }
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        self.newNotificationPublisher
            .receive(on: DispatchQueue.main)
            .sink { newNotification in
                if let statusButton = self.statusItem.button {
                    statusButton.image = NSImage(systemSymbolName: newNotification ? "envelope.badge.fill" : "envelope.fill", accessibilityDescription: "Maily")
                    statusButton.action = #selector(self.togglePopover)
                }
            }
            .store(in: &newNotificationCancellable)
        
        mainPopover = NSPopover()
        mainPopover.contentSize = NSSize(width: 300, height: 500)
        mainPopover.behavior = .transient
        mainPopover.contentViewController = NSHostingController(rootView: ContentView().environmentObject(self))
        mainPopover.setValue(true, forKeyPath: "shouldHideAnchor")
        
        // Create and show the second content view window as a popup
        secondaryPopover = NSPopover()
        secondaryPopover.contentSize = NSSize(width: 350, height: 500)
        secondaryPopover.behavior = .transient
        secondaryPopover.contentViewController = NSHostingController(rootView: DetailedContentView().environmentObject(self))
        secondaryPopover.setValue(true, forKeyPath: "shouldHideAnchor")
    }
    
    deinit {
        selectedEmailViewCancellable?.cancel()
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
                self.newNotification = false
                self.fetchUser()
                NSApp.activate(ignoringOtherApps: true)
            }
        }
    }
}
