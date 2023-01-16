//
//  PushNotification.swift
//  MailyApp
//
//  Created by Richard Lee on 1/16/23.
//

import Foundation
import UserNotifications

func schedulePushNotification(
    emailSubject: String,
    emailCity: String,
    emailCountry: String,
    emailCountryFlag: String
) {
    let content = UNMutableNotificationContent()
    content.sound = UNNotificationSound.default
    
    // Notification info
    content.title = emailSubject == "" ? "Maily" : emailSubject
    content.subtitle = "Email opened in \(emailCity == "" ? "" : "\(emailCity), ")\(emailCountry) \(emailCountryFlag)"
    
    // show this notification 0.1 second from now (almost instently)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
    
    // Display (add) notification
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
}
