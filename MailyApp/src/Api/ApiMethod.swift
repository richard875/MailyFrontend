//
//  ApiMethod.swift
//  MailyApp
//
//  Created by Richard Lee on 12/17/22.
//

import Foundation

func apiMethod(
    apiMethod: HTTPMethod,
    apiEndpoint: String,
    apiBody: Any? = nil, // Optional
    auth: Bool = false,  // Optional
    token: String = "",  // Optional
    completion: @escaping (Any?, Error?) -> Void) {
        // Set up the URL request
        guard let url = URL(string: apiEndpoint) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiMethod.rawValue
        
        if (auth) {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Set up the HTTP body
        if (apiBody != nil) {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: apiBody!, options: [])
            } catch {
                completion(nil, NSError(domain: "Invalid JSON body", code: 0, userInfo: nil))
                return
            }
        }
        
        // Set up the HTTP header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the request
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // Check for any errors
            if let error = error {
                completion(nil, error)
                return
            }
            
            // Return received data
            let httpResponse = response as! HTTPURLResponse
            
            let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: []) // Try serialize data to JSON, return nil if failed
            let statusCode = httpResponse.statusCode
            
            completion(ApiResponse(data: jsonObject, status: HTTPResponseStatus(rawValue: statusCode)!), nil)
        }
        task.resume()
    }
