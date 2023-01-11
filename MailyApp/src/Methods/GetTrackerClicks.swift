//
//  GetTrackerClicks.swift
//  MailyApp
//
//  Created by Richard Lee on 1/11/23.
//

import Foundation

internal func GetTrackerClicks(
    token: String,
    trackingNumber: String,
    emailViewSort: EmailViewSort,
    completion: @escaping (GetTrackerClicksResponse) -> Void
) {
    apiMethod(
        apiMethod: HTTPMethod.GET,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.TrackerClicks)/\(trackingNumber)/\(emailViewSort.self)",
        auth: true,
        token: token,
        completion: {(result, error) in completion(complete(result: (result as! ApiResponse), error: error))}
    )
}

func complete(result: ApiResponse, error: Optional<Error>) -> GetTrackerClicksResponse {
    // First check if there's errors. Return straight away if there are any
    if (error != nil) {
        return GetTrackerClicksResponse(
            returnStatus: ReturnStatus.ERROR,
            httpStatus: result.status,
            TrackerRecords: nil
        )
    }
    
    // Continue if no error
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx"
    
    guard let recordArray = result.data as? [[String: Any]] else {
        return GetTrackerClicksResponse(
            returnStatus: ReturnStatus.ERROR,
            httpStatus: result.status,
            TrackerRecords: []
        )
    }
    
    let records = recordArray.compactMap {(record) -> Record in
        let id = record["id"] as! String
        let createdAt = dateFormatter.date(from: record["CreatedAt"] as? String ?? "")
        let updatedAt = dateFormatter.date(from: record["UpdatedAt"] as? String ?? "")
        let deletedAt = dateFormatter.date(from: record["DeletedAt"] as? String ?? "")
        let publicTrackingNumber = record["publicTrackingNumber"] as! String
        let ipAddress = record["ipAddress"] as! String
        let ipCity = record["ipCity"] as? String ?? ""
        let ipCountry = record["ipCountry"] as! String
        let isEu = record["isEu"] as? Bool ?? false
        let isTor = record["isTor"] as! Bool
        let isProxy = record["isProxy"] as! Bool
        let isAnonymous = record["isAnonymous"] as! Bool
        let isKnownAttacker = record["isKnownAttacker"] as! Bool
        let isKnownAbuser = record["isKnownAbuser"] as! Bool
        let isThreat = record["isThreat"] as! Bool
        let isBogon = record["isBogon"] as! Bool
        let confidentWithEmailClient = record["confidentWithEmailClient"] as! Bool
        
        return Record(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            publicTrackingNumber: publicTrackingNumber,
            ipAddress: ipAddress,
            ipCity: ipCity,
            ipCountry: ipCountry,
            isEu: isEu,
            isTor: isTor,
            isProxy: isProxy,
            isAnonymous: isAnonymous,
            isKnownAttacker: isKnownAttacker,
            isKnownAbuser: isKnownAbuser,
            isThreat: isThreat,
            isBogon: isBogon,
            confidentWithEmailClient: confidentWithEmailClient
        )
    }
    
    return GetTrackerClicksResponse(
        returnStatus: ReturnStatus.SUCCESS,
        httpStatus: result.status,
        TrackerRecords: records
    )
}
