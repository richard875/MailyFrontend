//
//  GetUser.swift
//  MailyApp
//
//  Created by Richard Lee on 12/20/22.
//

import Foundation

internal func GetUser(token: String, completion: @escaping (Void) -> Void) {
    apiMethod(
        apiMethod: HTTPMethod.GET,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.User)",
        auth: true,
        token: token,
        completion: {(result, error) in completion(getComplete(result: (result as! ApiResponse), error: error))}
    )
}

func getComplete(result: Any, error: Optional<Error>) -> Void {
    print(result)
}
