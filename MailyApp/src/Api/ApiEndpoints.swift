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
    static let User = "api/admin/user"
}
