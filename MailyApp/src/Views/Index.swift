//
//  Index.swift
//  MailyApp
//
//  Created by Richard Lee on 12/18/22.
//

import Foundation
import SwiftUI

struct Index: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var setRoute: ((Route) -> Void)
    var mainPopover: NSPopover!
    var secondaryPopover: NSPopover!
    var profilePictureNumber: Int
    
    @State private var socket: Socket!
    @State private var timer: Timer? = nil
    @State private var loading: Bool = false
    @State private var user: User? = nil
    @State private var searchQuery: String = ""
    @State private var userTrackers: [Tracker] = []
    @State private var selectedIndexEmail: IndexEmail = IndexEmail.ALL
    
    init(
        setRoute: @escaping (Route) -> Void,
        mainPopover: NSPopover!,
        secondaryPopover: NSPopover!,
        profilePictureNumber: Int
    ) {
        self.setRoute = setRoute
        self.mainPopover = mainPopover
        self.secondaryPopover = secondaryPopover
        self.profilePictureNumber = profilePictureNumber
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top Section
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Image("profile\(profilePictureNumber)")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 7)
                            .stroke(Color("Border"), lineWidth: 1)
                        )
                        .cornerRadius(13)
                }
                .frame(width: 115, alignment: .topLeading)
                HStack(spacing: 0) {
                    Button {} label: {
                        Text("Edit Profile")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Text"))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(
                        width: 85,
                        height: 30
                    )
                    .overlay(RoundedRectangle(cornerRadius: 7)
                        .stroke(Color("Border"), lineWidth: 1)
                    )
                    .cornerRadius(7)
                    .onHover { hovering in
                        hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                    }
                    Button {
                        self.indexOnAppear(indexEmail: selectedIndexEmail)
                    } label: {
                        Image("Refresh")
                            .padding(.bottom, 2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(
                        width: 30,
                        height: 30
                    )
                    .overlay(RoundedRectangle(cornerRadius: 7)
                        .stroke(Color("Border"), lineWidth: 1)
                    )
                    .cornerRadius(7)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .onHover { hovering in
                        hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                    }
                    Menu {
                        Button("Logout") {
                            setRoute(Route.LOGIN)
                            let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
                            defaults.set(nil, forKey: SharedUserDefaults.Keys.loginToken)
                            defaults.synchronize()
                        }
                        Divider()
                        Button("Quit Maily") {
                            NSApp.terminate(self)
                        }
                    } label: {
                        Image("Settings Inverse")
                            .buttonStyle(PlainButtonStyle())
                    }
                    .menuStyle(BorderlessButtonMenuStyle())
                    .menuIndicator(.hidden)
                    .fixedSize() // Otherwise will be the width of your menu options.
                    .frame(
                        width: 30,
                        height: 30
                    )
                    .overlay(RoundedRectangle(cornerRadius: 7)
                        .stroke(Color("Border"), lineWidth: 1)
                    )
                    .cornerRadius(7)
                    .frame(
                        maxWidth: 30,
                        alignment: .trailing
                    )
                    .onHover { hovering in
                        hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                    }
                }
                .frame(height: 40, alignment: .topLeading)
            }
            .frame(
                width: 270,
                height: 40,
                alignment: .topLeading
            )
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(self.user?.loginCheck.firstName ?? "") \(self.user?.loginCheck.lastName ?? "")")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Text"))
                    Text(verbatim: self.user?.loginCheck.email ?? "")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Text Grey"))
                        .padding(.top, 4)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                VStack(alignment: .leading, spacing: 0) {
                    if let userEmailVerified = self.user?.loginCheck.emailVerified {
                        if userEmailVerified {
                            Button {} label: {
                                Text("Email Verified")
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("Green Tag Text"))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 83, height: 24)
                            .background(Color("Green Tag Fill"))
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("Green Tag Stroke"), lineWidth: 1)
                            )
                            .cornerRadius(5)
                        } else {
                            Button {} label: {
                                Text("Email not Verified")
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("Red Tag Text"))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 101, height: 24)
                            .background(Color("Red Tag Fill"))
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("Red Tag Stroke"), lineWidth: 1)
                            )
                            .cornerRadius(5)
                        }
                    }
                }
                .frame(height: 32, alignment: .topLeading)
            }
            .frame(
                width: 270,
                height: 32,
                alignment: .topLeading
            )
            .padding(.top, 14)
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image("Click")
                        .padding(.trailing, 7)
                    if let totalClicks = self.user?.loginCheck.totalClicks {
                        Text("\(totalClicks)")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Text"))
                    } else {
                        Text("0")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Text"))
                    }
                    Text(" Total Clicks")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Text"))
                }
                .frame(height: 14)
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 0) {
                    Image("Send")
                        .padding(.trailing, 7)
                    if let emailSent = self.user?.loginCheck.emailsSent {
                        Text("\(emailSent)")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Text"))
                    } else {
                        Text("0")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Text"))
                    }
                    Text(" Emails Sent")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Text"))
                }
                .frame(height: 14)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(
                width: 270,
                height: 14,
                alignment: .topLeading
            )
            .padding(.top, 15)
            Line()
                .stroke(
                    Color("Seperate Line"),
                    style: StrokeStyle(lineWidth: 1, dash: [2])
                )
                .frame(
                    width: 270,
                    height: 1
                )
                .padding(.top, 17)
            // Bottom Section
            HStack(spacing: 0) {
                Text("Emails")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(Color("Text"))
                HStack(spacing: 0) {
                    Text("View: ")
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text Grey"))
                    Menu {
                        if (self.selectedIndexEmail != IndexEmail.SEARCH) {
                            if (self.selectedIndexEmail != IndexEmail.ALL) {
                                Button(IndexEmail.ALL.rawValue) {
                                    self.searchQuery = ""
                                    self.indexOnAppear(indexEmail: IndexEmail.ALL)
                                }
                            }
                            if (self.selectedIndexEmail != IndexEmail.OPENED) {
                                Button(IndexEmail.OPENED.rawValue) {
                                    self.searchQuery = ""
                                    self.indexOnAppear(indexEmail: IndexEmail.OPENED)
                                }
                            }
                            if (self.selectedIndexEmail != IndexEmail.UNOPENED) {
                                Button(IndexEmail.UNOPENED.rawValue) {
                                    self.searchQuery = ""
                                    self.indexOnAppear(indexEmail: IndexEmail.UNOPENED)
                                }
                            }
                        }
                    } label: {
                        Text("\(selectedIndexEmail.rawValue)  \(self.selectedIndexEmail != IndexEmail.SEARCH ? Image("Arrow Down") : Image(""))")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Text"))
                    }
                    .menuStyle(BorderlessButtonMenuStyle())
                    .menuIndicator(.hidden)
                    .fixedSize() // Otherwise will be the width of your menu options.
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
            }
            .frame(width: 270)
            .padding(.top, 17)
            HStack(spacing: 0) {
                Image("Search")
                TextField("Search emails...", text: $searchQuery)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 10))
                    .padding(.leading, 8)
                    .onSubmit {
                        if (self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).sanitized() != "") {
                            self.searchTrackers(searchQuery: self.searchQuery)
                        }
                    }
                if (self.searchQuery != "" || self.selectedIndexEmail == IndexEmail.SEARCH) {
                    VStack(spacing: 0) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color("Text Grey"))
                    }
                    .padding(.trailing, 10)
                    .onTapGesture {
                        self.searchQuery = ""
                        if (self.selectedIndexEmail == IndexEmail.SEARCH) {
                            self.indexOnAppear(indexEmail: IndexEmail.ALL)
                        }
                    }
                    .onHover { hovering in
                        hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                    }
                }
            }
            .padding(.leading, 10)
            .frame(width: 270, height: 30)
            .background(Color("Grey Background"))
            .overlay(RoundedRectangle(cornerRadius: 7)
                .stroke(Color("Border"), lineWidth: 1)
            )
            .cornerRadius(7)
            .padding(.top, 10)
            .padding(.bottom, 5)
            // List
            if (self.loading) {
                VStack(spacing: 0) {
                    ProgressView()
                        .scaleEffect(0.7)
                }
                .frame(width: 270, height: 250)
            } else {
                if (self.userTrackers.isEmpty) {
                    VStack(spacing: 0) {
                        Text("No emails")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Text"))
                    }
                    .frame(width: 270, height: 250)
                } else {
                    List(self.userTrackers, id: \.id) {userTracker in
                        EmailTracker(
                            mainPopover: self.mainPopover,
                            secondaryPopover: self.secondaryPopover,
                            userTracker: userTracker,
                            last: userTracker == self.userTrackers.last,
                            addNewPaginateData: self.addNewPaginateData,
                            selectedIndexEmail: self.selectedIndexEmail
                        )
                    }
                    .padding(.leading, -8)
                    .padding(.trailing, -9)
                    .listStyle(PlainListStyle())
                    .frame(width: 276)
                }
            }
        }
        .padding(.top, 17)
        .padding(.leading, 15)
        .frame(
            width: 300,
            height: 500,
            alignment: .topLeading
        )
        .background(Color("Background"))
        .onAppear {
            self.indexOnAppear(indexEmail: selectedIndexEmail)
        }
        .onDisappear {
            self.socket.disconnect()
        }
    }
    
    private func indexOnAppear(indexEmail: IndexEmail) {
        // Start loading
        self.loading = true
        self.userTrackers = []
        self.selectedIndexEmail = indexEmail
        let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
        let token = defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
        
        // Return to the login screen if the user is logged out
        if (token == nil) {
            self.setRoute(Route.LOGIN)
            return
        }
        
        GetUser(token: token!) { response in
            if response.returnStatus == ReturnStatus.SUCCESS {
                let dictionary = response.user as! [String: Any]
                let loginCheck = dictionary["loginCheck"] as! [String: Any]
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx"
                
                // Convert the loginCheck dictionary to a LoginCheck struct
                let loginCheckStruct = User.LoginCheck(
                    id: loginCheck["id"] as! String,
                    createdAt: dateFormatter.date(from: loginCheck["CreatedAt"] as? String ?? ""),
                    updatedAt: dateFormatter.date(from: loginCheck["UpdatedAt"] as? String ?? ""),
                    deletedAt: dateFormatter.date(from: loginCheck["DeletedAt"] as? String ?? ""),
                    firstName: loginCheck["firstName"] as! String,
                    lastName: loginCheck["lastName"] as! String,
                    email: loginCheck["email"] as! String,
                    password: loginCheck["password"] as! String,
                    emailVerified: loginCheck["emailVerified"] as! Bool,
                    totalClicks: loginCheck["totalClicks"] as! Int,
                    emailsSent: loginCheck["emailsSent"] as! Int
                )
                
                // Create a User struct with the loginCheck struct and the message
                self.user = User(loginCheck: loginCheckStruct, message: dictionary["message"] as! String)
            } else {
                self.setRoute(Route.LOGIN)
                return
            }
        }
        
        GetUserTrackers(token: token!, indexEmail: indexEmail, page: 1) { response in
            if response.returnStatus == ReturnStatus.SUCCESS, let userTrackers = response.userTrackers {
                self.userTrackers = userTrackers
                
                // Establish Web Socket
                if (self.socket == nil) {
                    self.socket = Socket(appDelegate: self.appDelegate, indexOnAppear: self.indexOnAppear)
                }
                
                // Stop loading
                self.loading = false
            }
        }
    }
    
    private func searchTrackers(searchQuery: String) {
        // Start loading
        self.loading = true
        let defaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)!
        let token = defaults.value(forKey: SharedUserDefaults.Keys.loginToken) as? String
        
        // Return to the login screen if the user is logged out
        if (token == nil) {
            self.setRoute(Route.LOGIN)
            return
        }
        
        SearchUserTrackers(token: token!, searchQuery: searchQuery) { response in
            if response.returnStatus == ReturnStatus.SUCCESS, let userTrackers = response.userTrackers {
                self.userTrackers = userTrackers
                
                // Stop loading
                self.loading = false
                self.selectedIndexEmail = IndexEmail.SEARCH
            }
        }
    }
    
    private func addNewPaginateData(userTrackers: [Tracker]) {
        self.userTrackers += userTrackers
    }
}
