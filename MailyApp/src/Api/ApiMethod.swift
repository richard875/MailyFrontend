//
//  ApiMethod.swift
//  MailyApp
//
//  Created by Richard Lee on 12/17/22.
//

import Foundation

func apiMethod(apiMethod: HTTPMethod, apiEndpoint: String, apiBody: Any, completion: @escaping (Any?, Error?) -> Void) {
    // Set up the URL request
    guard let url = URL(string: apiEndpoint) else {
        completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        return
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = apiMethod.rawValue
    
    // Set up the HTTP body
    let jsonBody: Data
    do {
        jsonBody = try JSONSerialization.data(withJSONObject: apiBody, options: [])
        urlRequest.httpBody = jsonBody
    } catch {
        completion(nil, NSError(domain: "Invalid JSON body", code: 0, userInfo: nil))
        return
    }
    
    // Set up the HTTP header
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Make the request
    let session = URLSession.shared
    let task = session.dataTask(with: urlRequest) { (data, response, error) in
        // Check for any errors
        if let error = error {
            completion(nil, error)
            return
        }
        // Check that we received data
        guard let responseData = data else {
            completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
            return
        }
        
        // Return received data
        do {
            let httpResponse = response as! HTTPURLResponse
            
            let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: [])
            let statusCode = httpResponse.statusCode
            completion(ApiResponse(data: jsonObject, status: HTTPResponseStatus(rawValue: statusCode)!), nil)
        } catch  {
            completion(nil, NSError(domain: "Error parsing response", code: 0, userInfo: nil))
        }
    }
    task.resume()
}
