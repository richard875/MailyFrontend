//
//  SearchUserTrackers.swift
//  MailyApp
//
//  Created by Richard Lee on 1/9/23.
//

import Foundation

internal func SearchUserTrackers(token: String, searchQuery: String, page: Int, completion: @escaping (GetUserTrackersResponse) -> Void) {
    apiMethod(
        apiMethod: HTTPMethod.GET,
        apiEndpoint: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.SearchTrackers)/\(searchQuery)/\(page)",
        auth: true,
        token: token,
        completion: {(result, error) in completion(completeSearch(result: (result as! ApiResponse), error: error))}
    )
}

func completeSearch(result: ApiResponse, error: Optional<Error>) -> GetUserTrackersResponse {
    // First check if there's errors. Return straight away if there are any
    if (error != nil) {
        return GetUserTrackersResponse(
            returnStatus: ReturnStatus.ERROR,
            httpStatus: result.status,
            userTrackers: nil
        )
    }
    
    // Continue if no error
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx"
    
    guard let trackerArray = result.data as? [[String: Any]] else {
        return GetUserTrackersResponse(
            returnStatus: ReturnStatus.ERROR,
            httpStatus: result.status,
            userTrackers: []
        )
    }
    
    let trackers = trackerArray.compactMap {(tracker) -> Tracker in
        let id = tracker["id"] as! String
        let createdAt = dateFormatter.date(from: tracker["CreatedAt"] as? String ?? "")
        let updatedAt = dateFormatter.date(from: tracker["UpdatedAt"] as? String ?? "")
        let deletedAt = dateFormatter.date(from: tracker["DeletedAt"] as? String ?? "")
        let userID = tracker["userId"] as! String
        let timesOpened = tracker["timesOpened"] as! Int
        let composeAction = tracker["composeAction"] as! Int
        let subject = tracker["subject"] as? String
        let fromAddress = tracker["fromAddress"] as! String
        let toAddresses = tracker["toAddresses"] as! String
        let ccAddresses = tracker["ccAddresses"] as? String
        let bccAddresses = tracker["bccAddresses"] as? String
        let replyToAddresses = tracker["replyToAddresses"] as? String
        let internalMessageID = tracker["internalMessageID"] as? String
        let updated = tracker["updated"] as! Bool
        
        return Tracker(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            userID: userID,
            timesOpened: timesOpened,
            composeAction: composeAction,
            subject: subject,
            fromAddress: fromAddress,
            toAddresses: toAddresses,
            ccAddresses: ccAddresses,
            bccAddresses: bccAddresses,
            replyToAddresses: replyToAddresses,
            internalMessageId: internalMessageID,
            updated: updated
        )
    }
    
    return GetUserTrackersResponse(
        returnStatus: ReturnStatus.SUCCESS,
        httpStatus: result.status,
        userTrackers: trackers
    )
}
