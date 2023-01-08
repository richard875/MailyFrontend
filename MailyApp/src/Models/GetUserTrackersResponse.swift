//
//  GetUserTrackersResponse.swift
//  MailyApp
//
//  Created by Richard Lee on 1/8/23.
//

import Foundation

struct GetUserTrackersResponse {
    let returnStatus: ReturnStatus
    let httpStatus: HTTPResponseStatus
    let userTrackers: [Tracker]?
}
