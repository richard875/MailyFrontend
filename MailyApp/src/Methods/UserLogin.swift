//
//  Login.swift
//  MailyApp
//
//  Created by Richard Lee on 12/17/22.
//

import Foundation

public func login(email: String, password: String) {
    apiMethod(
        apiMethod: HTTPMethod.POST,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.Login)",
        apiBody: ["email": email, "password": password],
        completion: {(result, error) in loginComplete(result: result, error: error)}
    )
}

func loginComplete(result: Optional<Any>, error: Optional<Error>) {
    let apiResult = error != nil ? error : result // Assign error if it exists, otherwise assign result
    print(apiResult)
}
