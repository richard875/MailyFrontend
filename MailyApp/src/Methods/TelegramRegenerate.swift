//
//  TelegramRegenerate.swift
//  MailyApp
//
//  Created by Richard Lee on 1/20/23.
//

import Foundation

internal func TelegramRegenerate(token: String, completion: @escaping (TelegramRegenerateResponse) -> Void) {
    apiMethod(
        apiMethod: HTTPMethod.GET,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.TelegramRegenerate)",
        auth: true,
        token: token,
        completion: {(result, error) in completion(complete(result: (result as! ApiResponse), error: error))}
    )
}

func complete(result: ApiResponse, error: Optional<Error>) -> TelegramRegenerateResponse {
    // First check if there's errors. Return straight away if there are any
    if (error != nil) {
        return TelegramRegenerateResponse(
            returnStatus: ReturnStatus.ERROR,
            httpStatus: result.status,
            newTelegramToken: ""
        )
    }
    
    // Continue and return if no errors occurred
    let response = result.data as! [String: Any]
    
    return TelegramRegenerateResponse(
        returnStatus: ReturnStatus.SUCCESS,
        httpStatus: result.status,
        newTelegramToken: response["newTelegramToken"] as! String
    )
}
