//
//  ComposeSessionHandler.swift
//  Maily
//
//  Created by Richard Lee on 6/11/2022.
//

import MailKit

class ComposeSessionHandler: NSObject, MEComposeSessionHandler {
    private var trackingNumber: String? = nil
    private static let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
    
    
    // MARK: - Start composing an email
    func mailComposeSessionDidBegin(_ session: MEComposeSession) {
        // Get userToken from shared suite
        let userToken = ComposeSessionHandler.defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
        if (userToken == nil) { return }
        
        GetUser(token: userToken!) { response in
            if (response.httpStatus == HTTPResponseStatus.OK || response.returnStatus == ReturnStatus.SUCCESS) {
                GetTracking(token: userToken!)  { response in
                    if (response.returnStatus == ReturnStatus.SUCCESS && response.httpStatus == HTTPResponseStatus.OK) {
                        self.trackingNumber = response.data?.token
                    }
                }
            }
        }
    }
    
    // MARK: - Finish composing an email
    func mailComposeSessionDidEnd(_ session: MEComposeSession) {
        // Get userToken from shared suite
        let userToken = ComposeSessionHandler.defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
        
        // Perform any cleanup now that the compose session is over.
        session.reload()
        
        // var clickedSend: true if message header contains the 'subject' key
        let clickedSend = session.mailMessage.headers?["subject"] != nil
        if (clickedSend && self.trackingNumber != nil) {
            // Collect and compute email message properties
            let composeAction = session.composeContext.action.rawValue
            let subject = session.mailMessage.subject
            let fromAddress = session.mailMessage.fromAddress.rawString
            let toAddresses = session.mailMessage.toAddresses.map { $0.rawString }.joined(separator: ",")
            let ccAddresses = session.mailMessage.ccAddresses.map { $0.rawString }.joined(separator: ",")
            let bccAddresses = session.mailMessage.bccAddresses.map { $0.rawString }.joined(separator: ",")
            let replyToAddresses = session.mailMessage.replyToAddresses.map { $0.rawString }.joined(separator: ",")
            let internalMessageID = ((session.mailMessage.headers?["message-id"] as? [String])?.first) ?? ""
            
            AssignTracking(
                token: userToken!,
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
    
    // MARK: - Confirming Message Delivery
    func allowMessageSendForSession(_ session: MEComposeSession, completion: @escaping (Error?) -> Void) {
        // Determine if tracker is placed in the message
        let dataStr = String(data: session.mailMessage.rawData!, encoding: .utf8)!.replacingOccurrences(of: "[\n=]", with: "", options: .regularExpression)
        
        // Use a regular expression to find all occurrences of the tracking number in the email message string
        let pattern = "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.Beep)/"
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: dataStr, range: NSRange(dataStr.startIndex..., in: dataStr))
        
        // Extract the random strings from the matches
        let trackers = matches.map { tracker in
            let range = Range(tracker.range, in: dataStr)!
            let endRange = dataStr[range.upperBound...].range(of: ".png")!
            return String(dataStr[range.upperBound..<endRange.lowerBound])
        }
        
        // Throw warning if there are no trackers in the email message ("trackers" list is empty)
        if (trackers.isEmpty) {
            completion(NSError(
                domain: "error",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Message is not tracked, sand anyway?"
                ]
            ))
        } else {
            completion(nil)
        }
    }
}

