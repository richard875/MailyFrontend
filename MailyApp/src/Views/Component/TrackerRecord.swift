//
//  TrackerRecord.swift
//  MailyApp
//
//  Created by Richard Lee on 1/12/23.
//

import Foundation
import SwiftUI

struct TrackerRecord: View {
    var trackerRecord: Record
    var last: Bool
    let dateFormatter = DateFormatter()
    
    init(trackerRecord: Record, last: Bool) {
        self.trackerRecord = trackerRecord
        self.last = last
        self.dateFormatter.dateFormat = "EEEE, MMM d 'at' h:mm a"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                if (!trackerRecord.isTor &&
                    !trackerRecord.isProxy &&
                    !trackerRecord.isAnonymous &&
                    !trackerRecord.isKnownAttacker &&
                    !trackerRecord.isKnownAbuser &&
                    !trackerRecord.isThreat &&
                    !trackerRecord.isBogon) {
                    Button {} label: {
                        HStack(spacing: 0) {
                            Text("IP Address is ")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Green Tag Text"))
                            Text("Safe")
                                .font(.system(size: 10))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Green Tag Text"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 105, height: 20)
                    .background(Color("Green Tag Fill"))
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Green Tag Stroke"), lineWidth: 1)
                    )
                    .cornerRadius(5)
                } else {
                    Button {} label: {
                        HStack(spacing: 0) {
                            Text("IP Address is ")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Red Tag Text"))
                            Text("Suspicious")
                                .font(.system(size: 10))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Red Tag Text"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 135, height: 20)
                    .background(Color("Red Tag Fill"))
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Red Tag Stroke"), lineWidth: 1)
                    )
                    .cornerRadius(5)
                }
                if (trackerRecord.confidentWithEmailClient) {
                    Button {} label: {
                        HStack(spacing: 0) {
                            Text("Verified")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Blue Tag Text"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 51, height: 20)
                    .background(Color("Blue Tag Fill"))
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Blue Tag Stroke"), lineWidth: 1)
                    )
                    .cornerRadius(5)
                    .padding(.leading, 5)
                }
            }
            HStack(spacing: 0) {
                Text("Opened: ")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Text"))
                Text("\(self.dateFormatter.string(from: trackerRecord.createdAt ?? Date())) (\(timeAgoSinceDate(trackerRecord.createdAt ?? Date())))")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("Text"))
            }
            .padding(.top, 6)
            HStack(spacing: 0) {
                Text("IP Address: ")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Text"))
                Text(trackerRecord.ipAddress)
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("Text"))
                if (trackerRecord.ipCity != "" || trackerRecord.ipCountry != "") {
                    Text(" | ")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text"))
                }
                if (trackerRecord.ipCity != "") {
                    Text(trackerRecord.ipCity!)
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text"))
                }
                if (trackerRecord.ipCity != "" && trackerRecord.ipCountry != "") {
                    Text(", ")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text"))
                }
                if (trackerRecord.ipCountry != "") {
                    Text("\(trackerRecord.ipCountry!) 🇦🇺")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text"))
                }
            }
            .padding(.top, 4)
            VStack(spacing: 0) {
                Text("Map")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("Text Grey"))
            }
            .frame(width: 290, height: 100)
            .background(Color("Grey Background"))
            .overlay(RoundedRectangle(cornerRadius: 7)
                .stroke(Color("Border"), lineWidth: 1)
            )
            .cornerRadius(7)
            .padding(.top, 6)
        }
        .padding(.top, 10)
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .frame(
            width: 310,
            height: 182,
            alignment: .topLeading
        )
        .overlay(RoundedRectangle(cornerRadius: 7)
            .stroke(Color("Border"), lineWidth: 1)
        )
        .cornerRadius(7)
        .padding(.bottom, self.last ? 15 : 2)
    }
}
