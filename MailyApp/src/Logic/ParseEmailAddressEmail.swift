//
//  ParseEmailAddressEmail.swift
//  MailyApp
//
//  Created by Richard Lee on 1/9/23.
//

import Foundation

func ParseEmailAddressEmail(emailAddress: String) -> String {
    let email: String
    if let start = emailAddress.firstIndex(of: "<"), let end = emailAddress.firstIndex(of: ">") {
        email = String(emailAddress[emailAddress.index(start, offsetBy: 1)..<end])
    } else {
        email = ""
    }
    
    return email
}
