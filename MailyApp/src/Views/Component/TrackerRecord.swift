//
//  TrackerRecord.swift
//  MailyApp
//
//  Created by Richard Lee on 1/12/23.
//

import Foundation
import SwiftUI
import MapKit

struct TrackerRecord: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var trackerRecord: Record
    var last: Bool
    let dateFormatter = DateFormatter()
    
    @State private var region: MKCoordinateRegion
    @State private var notFristLoad = false // (Paginate) Set to true on the first appear on screen
    @State private var finishedPaginate = false // (Paginate) Set to true when finished loading the next batch of data
    
    init(trackerRecord: Record, last: Bool) {
        self.trackerRecord = trackerRecord
        self.last = last
        self.dateFormatter.dateFormat = "EEEE, MMM d 'at' h:mm a"
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: trackerRecord.latitude,
                longitude: trackerRecord.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.1,
                longitudeDelta: 0.1
            )
        ))
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
                if (trackerRecord.ipCity! == "") {
                    Button {} label: {
                        HStack(spacing: 0) {
                            Text("Bot")
                                .font(.system(size: 10))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Red Tag Text"))
                            Text(" Likely")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Red Tag Text"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 60, height: 20)
                    .background(Color("Red Tag Fill"))
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Red Tag Stroke"), lineWidth: 1)
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
            }
            .padding(.top, 4)
            HStack(spacing: 0) {
                Text("Location: ")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Text"))
                if (trackerRecord.ipCity != "") {
                    Text("\(trackerRecord.ipCity!), ")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text"))
                }
                Text("\(trackerRecord.ipCountry) \(trackerRecord.emojiFlag)")
                    .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color("Text"))
            }
            .padding(.top, 4)
            Map(coordinateRegion: $region, interactionModes: .zoom)
                .frame(width: 290, height: 100)
                .background(Color("Grey Background"))
                .overlay(RoundedRectangle(cornerRadius: 7)
                    .stroke(Color("Border"), lineWidth: 1)
                )
                .cornerRadius(7)
                .padding(.top, 6)
            if (self.last) {
                VStack(spacing: 0) {}
                    .frame(width: 0, height: 0)
                    .onAppear {
                        if (!self.finishedPaginate && self.notFristLoad) { self.paginateTrackerRecords() }
                        self.notFristLoad = true;
                    }
            }
        }
        .padding(.top, 10)
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .frame(
            width: 310,
            height: 202,
            alignment: .topLeading
        )
        .overlay(RoundedRectangle(cornerRadius: 7)
            .stroke(Color("Border"), lineWidth: 1)
        )
        .cornerRadius(7)
        .padding(.bottom, self.last ? 15 : 2)
        .onChange(of: self.appDelegate.secondaryPopoverEmailRecords) { data in
            self.finishedPaginate = false
        }
    }
    
    private func paginateTrackerRecords() {
        let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
        let token = defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
        
        GetTrackerClicks(
            token: token!,
            trackingNumber: self.trackerRecord.publicTrackingNumber,
            emailViewSort: self.appDelegate.selectedEmailView,
            page: self.appDelegate.trackerClicksPageNumber
        ) { response in
            if response.returnStatus == ReturnStatus.SUCCESS, let trackerRecords = response.TrackerRecords {
                self.appDelegate.trackerClicksPageNumber += 1
                self.appDelegate.secondaryPopoverEmailRecords += trackerRecords
                self.finishedPaginate = true
            }
        }
    }
}
