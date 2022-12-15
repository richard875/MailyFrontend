//
//  MailExtension.swift
//  Maily
//
//  Created by Richard Lee on 6/11/2022.
//

import MailKit

class MailExtension: NSObject, MEExtension {
    func handlerForMessageActions() -> MEMessageActionHandler {
        // Use a shared instance for all messages, since there's
        // no state associated with performing actions.
        return MessageActionHandler.shared
    }

    func handler(for session: MEComposeSession) -> MEComposeSessionHandler {
        // Create a unique instance, since each compose window is separate.
        return ComposeSessionHandler()
    }
}
