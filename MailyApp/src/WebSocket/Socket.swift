//
//  Socket.swift
//  MailyApp
//
//  Created by Richard Lee on 1/15/23.
//

import Foundation

struct Socket {
    private var appDelegate: AppDelegate
    private var indexOnAppear: (IndexEmail) -> Void
    private var webSocketTask = URLSession.shared.webSocketTask(
        with: URL(string: replaceHttpWithWs(string: "\(ApiEndpoints.ServerUrl)/\(ApiEndpoints.Websocket)"))!
    )
    
    init(appDelegate: AppDelegate, indexOnAppear: @escaping (IndexEmail) -> Void) {
        self.appDelegate = appDelegate
        self.indexOnAppear = indexOnAppear
        self.establishSocket()
        self.ping()
    }
    
    private func establishSocket() {
        self.webSocketTask.resume()
        
        self.webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("Failed to receive message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    let messageList = text.components(separatedBy: SocketParameters.Delimiter)
                    if (messageList[0] == SocketParameters.UpdateSignal) {
                        self.update(messageList: messageList)
                    }
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    fatalError()
                }
                
                self.establishSocket()
            }
        }
    }
    
    private func ping() {
        self.webSocketTask.sendPing { (error) in
            if let error = error {
                print("Ping failed: \(error)")
            }
            self.scheduleNextPing()
        }
    }
    
    private func scheduleNextPing() {
        let nextPingInterval: TimeInterval = 20 // 4 minutes
        Timer.scheduledTimer(withTimeInterval: nextPingInterval, repeats: false) { _ in
            self.ping()
        }
    }
    
    private func update(messageList: [String]) {
        self.indexOnAppear(IndexEmail.ALL)  // Refresh API call
        self.appDelegate.newNotification.toggle() // Display badge menu icon
        if (messageList.count > 1) {
            // Display notification
            schedulePushNotification(
                emailSubject: messageList[1],
                emailCity: messageList[2],
                emailCountry: messageList[3],
                emailCountryFlag: messageList[4]
            )
        }
    }
}
