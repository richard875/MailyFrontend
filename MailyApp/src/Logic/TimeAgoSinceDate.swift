//
//  TimeAgoSinceDate.swift
//  MailyApp
//
//  Created by Richard Lee on 1/9/23.
//

import Foundation

func timeAgoSinceDate(_ date: Date, numericDates: Bool = false) -> String {
    let calendar = Calendar.current
    let now = Date()
    let earliest = (now as NSDate).earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest)
    
    var result = ""
    
    if components.year! >= 2 {
        result = "\(components.year!) years ago"
    } else if components.year! >= 1 {
        if numericDates {
            result = "1 year ago"
        } else {
            result = "last year"
        }
    } else if components.month! >= 2 {
        result = "\(components.month!) months ago"
    } else if components.month! >= 1 {
        if numericDates {
            result = "1 month ago"
        } else {
            result = "last month"
        }
    } else if components.weekOfYear! >= 2 {
        result = "\(components.weekOfYear!) weeks ago"
    } else if components.weekOfYear! >= 1 {
        if numericDates {
            result = "1 week ago"
        } else {
            result = "last week"
        }
    } else if components.day! >= 2 {
        result = "\(components.day!) days ago"
    } else if components.day! >= 1 {
        if numericDates {
            result = "1 day ago"
        } else {
            result = "yesterday"
        }
    } else if components.hour! >= 2 {
        result = "\(components.hour!) hours ago"
    } else if components.hour! >= 1 {
        if numericDates {
            result = "1 hour ago"
        } else {
            result = "an hour ago"
        }
    } else if components.minute! >= 2 {
        result = "\(components.minute!) minutes ago"
    } else if components.minute! >= 1 {
        if numericDates {
            result = "1 minute ago"
        } else {
            result = "a minute ago"
        }
    } else if components.second! >= 3 {
        result = "\(components.second!) seconds ago"
    } else {
        result = "just now"
    }
    
    return result
}
