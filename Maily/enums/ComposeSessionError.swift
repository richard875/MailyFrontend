//
//  ComposeSessionError.swift
//  Maily
//
//  Created by Richard Lee on 12/15/22.
//

import Foundation

enum ComposeSessionError: LocalizedError {
    case invalidRecipientDomain
    
    var errorDescription: String? {
        switch self {
        case .invalidRecipientDomain:
            return "example.com is not a valid recipient domain"
        }
    }
}
