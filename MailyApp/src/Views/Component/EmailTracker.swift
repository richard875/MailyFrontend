//
//  Tracker.swift
//  MailyApp
//
//  Created by Richard Lee on 1/9/23.
//

import Foundation
import SwiftUI

struct EmailTracker: View {
    var userTracker: Tracker
    var last: Bool
    
    var toAddresses: [String] = []
    var dateViewFormatter = DateFormatter()
    var timeViewFormatter = DateFormatter()
    
    @State private var hoverOverFrame = false
    
    init(userTracker: Tracker, last: Bool) {
        self.userTracker = userTracker
        self.last = last
        self.toAddresses = userTracker.toAddresses.components(separatedBy: ",")
        self.dateViewFormatter.dateFormat = "MMM dd, yyyy"
        self.timeViewFormatter.dateFormat = "hh:mm a"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(ParseEmailAddressName(emailAddress: self.toAddresses[0]))
                    .font(.system(size: 11))
                    .fontWeight(.medium)
                    .foregroundColor(Color("Text"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(self.dateViewFormatter.string(from: userTracker.createdAt ?? Date()))
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Text Grey"))
            }
            Text(verbatim: ParseEmailAddressEmail(emailAddress: self.toAddresses[0]))
                .font(.system(size: 11))
                .fontWeight(.regular)
                .foregroundColor(Color("Text"))
                .frame(alignment: .topLeading)
                .padding(.top, 3)
            Text(userTracker.subject ?? "")
                .font(.system(size: 11))
                .fontWeight(.regular)
                .foregroundColor(Color("Text Grey"))
                .frame(alignment: .topLeading)
                .padding(.top, 3)
            HStack(spacing: 0) {
                if (userTracker.timesOpened > 0) {
                    Button {} label: {
                        HStack(spacing: 0) {
                            Text(String(userTracker.timesOpened))
                                .font(.system(size: 10))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Green Tag Text"))
                            Text(" Clicks")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Green Tag Text"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 45, height: 20)
                    .background(Color("Green Tag Fill"))
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Green Tag Stroke"), lineWidth: 1)
                    )
                    .cornerRadius(5)
                    Button {} label: {
                        HStack(spacing: 0) {
                            Text("Last opened ")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Yellow Tag Text"))
                            Text(timeAgoSinceDate(userTracker.updatedAt ?? Date()))
                                .font(.system(size: 10))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Yellow Tag Text"))
                            Text(" at \(timeViewFormatter.string(from: userTracker.updatedAt ?? Date()))")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Yellow Tag Text"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 200, height: 20)
                    .background(Color("Yellow Tag Fill"))
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Yellow Tag Stroke"), lineWidth: 1)
                    )
                    .cornerRadius(5)
                    .padding(.leading, 5)
                } else {
                    Button {} label: {
                        HStack(spacing: 0) {
                            Text("Unopened")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Red Tag Text"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 62, height: 20)
                    .background(Color("Red Tag Fill"))
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Red Tag Stroke"), lineWidth: 1)
                    )
                    .cornerRadius(5)
                }
            }
            .padding(.top, 6)
        }
        .padding(.top, 10)
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .frame(
            width: 270,
            height: 92,
            alignment: .topLeading
        )
        .overlay(RoundedRectangle(cornerRadius: 7)
            .stroke(hoverOverFrame ? Color("Icon Stoke") : Color("Border"), lineWidth: 1)
        )
        .background(hoverOverFrame ? Color("Grey Background") : Color("Background"))
        .cornerRadius(7)
        .padding(.bottom, self.last ? 10 : 0)
        .onHover { over in
            withAnimation(.easeInOut(duration: 0.15)) {
                hoverOverFrame = over
            }
        }
    }
}
