//
//  ComposeSessionHandler.swift
//  Maily
//
//  Created by Richard Lee on 6/11/2022.
//

import MailKit

class ComposeSessionHandler: NSObject, MEComposeSessionHandler {
    private static let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
    private static let userToken = ComposeSessionHandler.defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
    
    private var trackingNumber: String? = nil
    
    // MARK: - Start composing an email
    func mailComposeSessionDidBegin(_ session: MEComposeSession) {
        GetUser(token: ComposeSessionHandler.userToken!) { response in
            if (response.httpStatus == HTTPResponseStatus.OK) {
                GetTracking(token: ComposeSessionHandler.userToken!)  { response in
                    if (response.returnStatus == ReturnStatus.SUCCESS && response.httpStatus == HTTPResponseStatus.OK) {
                        self.trackingNumber = response.data?.token
                    }
                }
            }
        }
    }
    
    // MARK: - Finish composing an email
    func mailComposeSessionDidEnd(_ session: MEComposeSession) {
        // Perform any cleanup now that the compose session is over.
        session.reload()
        
        // var clickedSend: true if message header contains the 'subject' key
        let clickedSend = session.mailMessage.headers?["subject"] != nil
        if (clickedSend) {
            // Collect and compute email message properties
            let composeAction = session.composeContext.action.rawValue
            let subject = session.mailMessage.subject
            let fromAddress = session.mailMessage.fromAddress.rawString
            let toAddresses = session.mailMessage.toAddresses.map { $0.rawString }.joined(separator: ",")
            let ccAddresses = session.mailMessage.ccAddresses.map { $0.rawString }.joined(separator: ",")
            let bccAddresses = session.mailMessage.bccAddresses.map { $0.rawString }.joined(separator: ",")
            let replyToAddresses = session.mailMessage.replyToAddresses.map { $0.rawString }.joined(separator: ",")
            let internalMessageID = (session.mailMessage.headers?["message-id"] as! [String]).first!
            
            AssignTracking(
                token: ComposeSessionHandler.userToken!,
                trackingNumber: self.trackingNumber!,
                composeAction: composeAction,
                subject: subject,
                fromAddress: fromAddress,
                toAddresses: toAddresses,
                ccAddresses: ccAddresses,
                bccAddresses: bccAddresses,
                replyToAddresses: replyToAddresses,
                internalMessageID: internalMessageID
            ) { response in
            }
        }
    }
    
    // MARK: - Displaying Custom Compose Options
    
    func viewController(for session: MEComposeSession) -> MEExtensionViewController {
        return ComposeSessionViewController(session: session, trackingNumber: self.trackingNumber)
    }
}

