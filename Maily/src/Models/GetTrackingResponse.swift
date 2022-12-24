//
//  GetTokenResponse.swift
//  Maily
//
//  Created by Richard Lee on 12/24/22.
//

import Foundation

struct GetTrackingResponse {
    let returnStatus: ReturnStatus
    let httpStatus: HTTPResponseStatus
    let data: TrackingResponse?
}
