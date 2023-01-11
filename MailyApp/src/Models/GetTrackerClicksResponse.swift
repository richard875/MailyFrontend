//
//  GetTrackerClicksResponse.swift
//  MailyApp
//
//  Created by Richard Lee on 1/12/23.
//

import Foundation

struct GetTrackerClicksResponse {
    let returnStatus: ReturnStatus
    let httpStatus: HTTPResponseStatus
    let userTrackers: [Record]?
}
