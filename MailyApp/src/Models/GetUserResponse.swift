//
//  GetUserResponse.swift
//  MailyApp
//
//  Created by Richard Lee on 12/20/22.
//

import Foundation

struct GetUserResponse {
    let returnStatus: ReturnStatus
    let httpStatus: HTTPResponseStatus
    let user: Any?
}
