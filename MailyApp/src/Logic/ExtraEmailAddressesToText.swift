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
        emailText += "\(name) (\(email)), "
    }
    
    let end = emailText.index(emailText.endIndex, offsetBy: -2)
    let range = emailText.startIndex..<end
    return String(emailText[range])
}
