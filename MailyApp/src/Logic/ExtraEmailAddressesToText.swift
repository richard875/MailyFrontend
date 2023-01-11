//
//  ExtraEmailAddressesToText.swift
//  MailyApp
//
//  Created by Richard Lee on 1/11/23.
//

import Foundation

func extraEmailAddressesToText(addressArray: [String]) -> String {
    var emailText = ""
    
    for i in 1..<addressArray.count {
        let name = ParseEmailAddressName(emailAddress: addressArray[i])
        let email = ParseEmailAddressEmail(emailAddress: addressArray[i])
        emailText += "\n\(name) (\(email))"
    }
    
    let start = emailText.index(emailText.startIndex, offsetBy: 1)
    let range = start..<emailText.endIndex
    return String(emailText[range])
}
