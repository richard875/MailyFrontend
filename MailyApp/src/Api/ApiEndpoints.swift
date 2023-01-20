//
//  ApiEndpoints.swift
//  MailyApp
//
//  Created by Richard Lee on 12/18/22.
//

import Foundation

struct ApiEndpoints {
    static let ServerUrl = ProcessInfo.processInfo.environment["SERVER_URL"] ?? ""
    
    static let Login = "api/login"
    static let Generate = "api/generate"
    static let AssignTrackingNumber = "api/assign-tracking-number"
    static let Beep = "api/beep"
    static let UserTrackers = "api/user-trackers"
    static let SearchTrackers = "api/search-trackers"
    static let TrackerClicks = "api/tracker-clicks"
    static let TelegramRegenerate = "api/telegram-regenerate"
    static let Websocket = "api/ws"
    static let User = "api/admin/user"
}
