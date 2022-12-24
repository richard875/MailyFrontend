//
//  TrackingResponse.swift
//  Maily
//
//  Created by Richard Lee on 12/24/22.
//

import Foundation

struct TrackingResponse: Codable {
    let token: String
    let url: String
    let usage: String
}
