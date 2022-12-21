//
//  ComposeSessionHandler.swift
//  Maily
//
//  Created by Richard Lee on 6/11/2022.
//

import MailKit

class ComposeSessionHandler: NSObject, MEComposeSessionHandler {
    // MARK: - Start composing an email
    func mailComposeSessionDidBegin(_ session: MEComposeSession) {
        // Perform any setup necessary for handling the compose session.
        let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
        let token = defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
    }
    
    // MARK: - Finish composing an email
    func mailComposeSessionDidEnd(_ session: MEComposeSession) {
        // Perform any cleanup now that the compose session is over.
        session.reload()
        
        // var clickedSend: true if message header contains the 'subject' key
        let clickedSend = session.mailMessage.headers?["subject"] != nil
    }
    
    // MARK: - Displaying Custom Compose Options
    
    func viewController(for session: MEComposeSession) -> MEExtensionViewController {
        return ComposeSessionViewController(nibName: "ComposeSessionViewController", bundle: Bundle.main)
    }
    
    // MARK: - Confirming Message Delivery
    func allowMessageSendForSession(_ session: MEComposeSession, completion: @escaping (Error?) -> Void) {
        // Before Mail sends a message, your extension can validate the
        // contents of the compose session. If the message is ready to be sent,
        // call the compltion block with nil. If the message isn't ready to be
        // sent, call the completion with an error.
        if session.mailMessage.allRecipientAddresses.contains(where: { $0.rawString.hasSuffix("@example.com")}) {
            completion(ComposeSessionError.invalidRecipientDomain)
        } else {
            completion(nil)
        }
    }
}

