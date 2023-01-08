//
//  User.swift
//  MailyApp
//
//  Created by Richard Lee on 1/8/23.
//

import Foundation

struct User {
    struct LoginCheck {
        let id: String
        let createdAt: Date?
        let updatedAt: Date?
        let deletedAt: Date?
        let firstName: String
        let lastName: String
        let email: String
        let password: String
        let emailVerified: Bool
        let totalClicks: Int
        let emailsSent: Int
    }
    
    let loginCheck: LoginCheck
    let message: String
}
