//
//  GetUser.swift
//  MailyApp
//
//  Created by Richard Lee on 12/20/22.
//

import Foundation

internal func GetUser(token: String, completion: @escaping (GetUserResponse) -> Void) {
    apiMethod(
        apiMethod: HTTPMethod.GET,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.User)",
        auth: true,
        token: token,
        completion: {(result, error) in completion(complete(result: (result as! ApiResponse), error: error))}
    )
}

func complete(result: ApiResponse, error: Optional<Error>) -> GetUserResponse {
    // First check if there's errors. Return straight away if there are any
    if (error != nil) {
        return GetUserResponse(
            returnStatus: ReturnStatus.ERROR,
            httpStatus: result.status,
            user: nil
        )
    }
    
    // Return false if returned as no user
    if (result.data == nil || result.status == HTTPResponseStatus.UNAUTHORIZED) {
        return GetUserResponse(
            returnStatus: ReturnStatus.ERROR,
            httpStatus: result.status,
            user: nil
        )
    }
    
    // Return success if no error
    return GetUserResponse(
        returnStatus: ReturnStatus.SUCCESS,
        httpStatus: result.status,
        user: result.data
    )
}
