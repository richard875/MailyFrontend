//
//  Login.swift
//  MailyApp
//
//  Created by Richard Lee on 12/17/22.
//

import Foundation

internal func login(email: String, password: String, completion: @escaping (LoginResponse) -> Void) {
    apiMethod(
        apiMethod: HTTPMethod.POST,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.Login)",
        apiBody: ["email": email, "password": password],
        completion: {(result, error) in completion(loginComplete(result: result, error: error))}
    )
}

func loginComplete(result: Optional<Any>, error: Optional<Error>) -> LoginResponse {
//    let defaults = UserDefaults.standard
    let apiResult = error != nil ? error : result // Assign error if it exists, otherwise assign result
    
    // Check if the "status" property is in the result
    if let apiResultDict = apiResult as? [String: Any], apiResultDict["status"] != nil {
        return LoginResponse(status: ReturnStatus.ERROR, message: "Username/Password is incorrect")
    }
    
    // If the "status" property is not in the result, then it is a success
    // Try to cast the result to a dictionary
    guard let apiResultDict = apiResult as? [String: Any] else {
        return LoginResponse(status: ReturnStatus.ERROR, message: "Unknown error") // Result cannot be cast to a dictionary
    }
    
    // Get the value of the "token" variable
    let token = apiResultDict["token"] as? String
    return LoginResponse(status: ReturnStatus.SUCCESS, message: token!)
}
