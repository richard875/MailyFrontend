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
        //        print(message.state)
        //        print(message.headers)
        //        print(message.rawData)
        if let messageData =  message.rawData {
            print("messageData = \(messageData)")
            let dataStr = String(data: messageData, encoding: .utf8)!.replacingOccurrences(of: "[\n=]", with: "", options: .regularExpression)
            print(dataStr)


            let pattern = "http://maily.loca.lt/api/beep/"

            // Use a regular expression to find all occurrences of the pattern in the big string
            let regex = try! NSRegularExpression(pattern: pattern)
            let matches = regex.matches(in: dataStr, range: NSRange(dataStr.startIndex..., in: dataStr))

            // Extract the random strings from the matches
            let randomStrings = matches.map { match in
                let range = Range(match.range, in: dataStr)!
                let endRange = dataStr[range.upperBound...].range(of: ".png")!
                let randomString = String(dataStr[range.upperBound..<endRange.lowerBound])
                return randomString
            }

            print("=================================")
            print(randomStrings)
        } else {
            action = MEMessageActionDecision.invokeAgainWithBody
        }
        completionHandler(action)
    }
}
