//
//  Socket.swift
//  MailyApp
//
//  Created by Richard Lee on 1/15/23.
//

import Foundation

struct Socket {
    private var indexOnAppear: (IndexEmail) -> Void
    private var indexEmail: IndexEmail
    private var webSocketTask = URLSession.shared.webSocketTask(with: URL(string: "ws://maily.richardlee.dev/api/ws")!)
    
    init(indexOnAppear: @escaping (IndexEmail) -> Void, indexEmail: IndexEmail) {
        self.indexOnAppear = indexOnAppear
        self.indexEmail = indexEmail
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
                    if (text == SocketParameters.UpdateSignal) {
                        self.indexOnAppear(self.indexEmail)
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
}
