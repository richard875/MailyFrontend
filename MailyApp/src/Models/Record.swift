//
//  Record.swift
//  MailyApp
//
//  Created by Richard Lee on 1/12/23.
//

import Foundation

struct Record {
    let id: String
    let createdAt: Date?
    let updatedAt: Date?
    let deletedAt: Date?
    let publicTrackingNumber: String
    let ipAddress: String
    let ipCity: String?
    let ipCountry: String?
    let isEu: Bool?
    let isTor: Bool
    let isProxy: Bool
    let isAnonymous: Bool
    let isKnownAttacker: Bool
    let isKnownAbuser: Bool
    let isThreat: Bool
    let isBogon: Bool
    let confidentWithEmailClient: Bool
}
