//
//  MessageActionHandler.swift
//  Maily
//
//  Created by Richard Lee on 6/11/2022.
//

import MailKit

// Reserve for future features
class MessageActionHandler: NSObject, MEMessageActionHandler {

    static let shared = MessageActionHandler()
    
    func decideAction(for message: MEMessage, completionHandler: @escaping (MEMessageActionDecision?) -> Void) {
        // The action to take on the message, if any.
         var action: MEMessageActionDecision? = nil
        
         completionHandler(action)
    }
}
