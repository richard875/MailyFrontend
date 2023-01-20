//
//  Tracker.swift
//  MailyApp
//
//  Created by Richard Lee on 1/9/23.
//

import Foundation
import SwiftUI

struct EmailTracker: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var userTracker: Tracker
    var last: Bool
    var addNewPaginateData: ([Tracker]) -> Void
    var selectedIndexEmail: IndexEmail
    var searchQuery: String
    
    var toAddresses: [String] = []
    var dateViewFormatter = DateFormatter()
    var timeViewFormatter = DateFormatter()
    
    @State private var hoverOverFrame = false
    @State private var heldDownOverFrame = false
    @State private var unopened = true
    @State private var notFristLoad = false // (Paginate) Set to true on the first appear on screen
    @State private var finishedPaginate = false // (Paginate) Set to true when finished loading the next batch of data
    
    init(
        userTracker: Tracker,
        last: Bool,
        addNewPaginateData: @escaping ([Tracker]) -> Void,
        selectedIndexEmail: IndexEmail,
        searchQuery: String
    ) {
        self.userTracker = userTracker // Tracker Data
        self.last = last
        self.addNewPaginateData = addNewPaginateData
        self.selectedIndexEmail = selectedIndexEmail
        self.searchQuery = searchQuery
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
                if (self.userTracker.updated && self.unopened) {
                    HStack(spacing: 0) {
                        Image(systemName: "circle.fill")
                            .scaleEffect(0.4)
                            .foregroundColor(Color.blue)
                    }
                    .padding(.top, 2)
                }
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
                .padding(.top, self.userTracker.updated && self.unopened ? 1 : 2)
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
                            Text(" Click\(userTracker.timesOpened > 1 ? "s" : "")")
                                .font(.system(size: 10))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Green Tag Text"))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 48, height: 20)
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
                    .frame(width: 197, height: 20)
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
            if (self.last) {
                VStack(spacing: 0) {}
                    .frame(width: 0, height: 0)
                    .onAppear {
                        if (self.notFristLoad) {
                            if (!self.finishedPaginate) {
                                if (self.selectedIndexEmail == IndexEmail.SEARCH) { self.paginateSearchTrackers() }
                                else { self.paginateTrackers() }
                            }
                        } else {
                            self.notFristLoad = true
                        }
                    }
            }
        }
        .padding(.top, self.userTracker.updated && self.unopened ? 8 : 10)
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
        .background(self.setEmailBackgroundColor(hover: self.hoverOverFrame, press: self.heldDownOverFrame))
        .cornerRadius(7)
        .padding(.bottom, self.last ? 10 : 0)
        .onHover { over in withAnimation(.easeInOut(duration: 0.15)) {
            self.hoverOverFrame = over
        }}
        .gesture(DragGesture(minimumDistance: 0.0)
            .onChanged {_ in withAnimation(.easeInOut(duration: 0.15)) {
                self.heldDownOverFrame = true
                
                // Mark tracker as opened
                self.unopened = false
                
                // Open detailed popover and load userTracker (Tracker) data
                self.appDelegate.selectedUserTracker = self.userTracker
                self.appDelegate.secondaryPopover.show(relativeTo: CGRect(), of: self.appDelegate.mainPopover.contentViewController!.view, preferredEdge: NSRectEdge.minX)
                self.appDelegate.triggerSecondaryPopover += 1 // Trigger the switch and fetch data
            }}
            .onEnded {_ in withAnimation(.easeInOut(duration: 0.15)) {
                self.heldDownOverFrame = false
            }}
        )
    }
    
    private func setEmailBackgroundColor(hover: Bool, press: Bool) -> Color {
        if (hover && !press) { return Color("Grey Background") }
        if (hover && press) { return Color("Background")  }
        if (!hover && press) { return Color("Background")  }
        if (!hover && !press) { return Color("Background")  }
        
        return Color("Background")
    }
    
    private func paginateTrackers() {
        let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
        let token = defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
        
        GetUserTrackers(token: token!, indexEmail: self.selectedIndexEmail, page: self.appDelegate.indexPageNumber) { response in
            if response.returnStatus == ReturnStatus.SUCCESS, let userTrackers = response.userTrackers {
                self.appDelegate.indexPageNumber += 1
                self.finishedPaginate = true
                self.addNewPaginateData(userTrackers)
            }
        }
    }
    
    private func paginateSearchTrackers() {
        let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
        let token = defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
        
        SearchUserTrackers(token: token!, searchQuery: self.searchQuery, page: self.appDelegate.indexPageNumber) { response in
            if response.returnStatus == ReturnStatus.SUCCESS, let userTrackers = response.userTrackers {
                self.appDelegate.indexPageNumber += 1
                self.finishedPaginate = true
                self.addNewPaginateData(userTrackers)
            }
        }
    }
}
