//
//  TelegramRegenerateResponse.swift
//  MailyApp
//
//  Created by Richard Lee on 1/20/23.
//

import Foundation

struct TelegramRegenerateResponse {
    let returnStatus: ReturnStatus
    let httpStatus: HTTPResponseStatus
    let newTelegramToken: String
}
