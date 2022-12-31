//
//  AssignTracking.swift
//  Maily
//
//  Created by Richard Lee on 12/31/22.
//

import Foundation

internal func AssignTracking(token: String, trackingNumber: String, completion: @escaping (AssignTrackingResponse) -> Void) {
    apiMethod(
        apiMethod: HTTPMethod.POST,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.AssignTrackingNumber)",
        apiBody: ["trackingNumber": trackingNumber],
        auth: true,
        token: token,
        completion: {(result, error) in completion(complete(result: (result as! ApiResponse), error: error))}
    )
}

func complete(result: ApiResponse, error: Optional<Error>) -> AssignTrackingResponse {
    let failed = error != nil || result.status != HTTPResponseStatus.OK
    
    return AssignTrackingResponse(
        returnStatus: failed ? ReturnStatus.ERROR : ReturnStatus.SUCCESS,
        httpStatus: result.status,
        data: result.data
    )
}
