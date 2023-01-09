//
//  Tracker.swift
//  MailyApp
//
//  Created by Richard Lee on 1/8/23.
//

import Foundation

struct Tracker {
    let id: String
    let createdAt: Date?
    let updatedAt: Date?
    let deletedAt: Date?
    let userID: String
    let timesOpened: Int
    let composeAction: Int
    let subject: String?
    let fromAddress: String
    let toAddresses: String
    let ccAddress: String?
    let bccAddress: String?
    let replyToAddress: String?
    let internalMessageId: String?
}

extension Tracker: Equatable {
    static func == (lhs: Tracker, rhs: Tracker) -> Bool {
        // Compare the two instances of Tracker and return true if they are equal, false otherwise
        return lhs.id == rhs.id
    }
}
