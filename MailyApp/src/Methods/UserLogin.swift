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
        completion: {(result, error) in completion(loginComplete(result: (result as! ApiResponse), error: error))}
    )
}

func loginComplete(result: ApiResponse, error: Optional<Error>) -> LoginResponse {
    if (error != nil) {
        return LoginResponse(returnStatus: ReturnStatus.ERROR, httpStatus: result.status, message: error!.localizedDescription)
    }
    
    // Check if the "status" property is in the result
    if let apiResultDict = result.data as? [String: Any], apiResultDict["status"] != nil {
        return LoginResponse(returnStatus: ReturnStatus.ERROR, httpStatus: result.status, message: "Username or Password is incorrect")
    }
    
    // If the "status" property is not in the result, then it is a success
    // Try to cast the result to a dictionary, throw error if result cannot be cast to a dictionary
    guard let apiResultDict = result.data as? [String: Any] else {
        return LoginResponse(returnStatus: ReturnStatus.ERROR, httpStatus: result.status, message: "Unknown error")
    }
    
    // Get the value of the "token" variable
    let token = apiResultDict["token"] as? String
    return LoginResponse(returnStatus: ReturnStatus.SUCCESS, httpStatus: result.status, message: token!)
}
