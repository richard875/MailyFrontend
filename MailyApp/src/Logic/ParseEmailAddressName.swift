//
//  ParseEmailAddress.swift
//  MailyApp
//
//  Created by Richard Lee on 1/9/23.
//

import Foundation

func ParseEmailAddressName(emailAddress: String) -> String {
    let name: String
    if let start = emailAddress.lastIndex(of: " ") {
        name = String(emailAddress[..<start])
    } else {
        name = emailAddress
    }
    
    return name
}
