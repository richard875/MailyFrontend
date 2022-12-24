//
//  GetToken.swift
//  Maily
//
//  Created by Richard Lee on 12/24/22.
//

import Foundation

internal func GetTracking(token: String, completion: @escaping (GetTrackingResponse) -> Void) {
    apiMethod(
        apiMethod: HTTPMethod.GET,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.Generate)",
        auth: true,
        token: token,
        completion: {(result, error) in completion(complete(result: (result as! ApiResponse), error: error))}
    )
}

func complete(result: ApiResponse, error: Optional<Error>) -> GetTrackingResponse {
    // First check if there's errors. Return straight away if there are any
    if (error != nil || result.status != HTTPResponseStatus.OK) {
        return GetTrackingResponse(
            returnStatus: ReturnStatus.ERROR,
            httpStatus: result.status,
            data: nil
        )
    }
    
    // Continue of no error
    let returnedData = result.data as! [String: String]
    let jsonData = try? JSONSerialization.data(withJSONObject: returnedData,options: .prettyPrinted)
    let trackingResponse = try? JSONDecoder().decode(TrackingResponse.self, from: jsonData!)
    
    return GetTrackingResponse(
        returnStatus: ReturnStatus.SUCCESS,
        httpStatus: result.status,
        data: trackingResponse
    )
}
