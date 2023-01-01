//
//  AssignTracking.swift
//  Maily
//
//  Created by Richard Lee on 12/31/22.
//

import Foundation

internal func AssignTracking(
    token: String,
    trackingNumber: String,
    composeAction: Int,
    subject: String,
    fromAddress: String,
    toAddresses: String,
    ccAddresses: String,
    bccAddresses: String,
    replyToAddresses: String,
    internalMessageID: String,
    completion: @escaping (AssignTrackingResponse) -> Void
) {
    apiMethod(
        apiMethod: HTTPMethod.POST,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.AssignTrackingNumber)",
        apiBody: [
            "trackingNumber": trackingNumber,
            "composeAction": composeAction,
            "subject": subject,
            "fromAddress": fromAddress,
            "toAddresses": toAddresses,
            "ccAddresses": ccAddresses,
            "bccAddresses": bccAddresses,
            "replyToAddresses": replyToAddresses,
            "internalMessageID": internalMessageID
        ],
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
