//
//  MessageSendAction.swift
//  MailyApp
//
//  Created by Richard Lee on 1/11/23.
//

import Foundation

enum MessageSendAction: String {
    case send = "Send"
    case reply = "Reply"
    case replyAll = "Reply All"
    case forward = "Forward"
    
    init?(rawValue: Int) {
        switch rawValue {
        case 1: self = .send
        case 2: self = .reply
        case 3: self = .replyAll
        case 4: self = .forward
        default: return nil
        }
    }
}
