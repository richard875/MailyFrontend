//
//  DetailedContentView.swift
//  MailyApp
//
//  Created by Richard Lee on 1/7/23.
//

import Foundation
import SwiftUI

struct DetailedContentView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        timeFormatter.dateFormat = "hh:mm a"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(self.appDelegate.selectedUserTracker != nil ? self.appDelegate.selectedUserTracker.subject! : "")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .lineSpacing(1.5)
                    .foregroundColor(Color("Text"))
                    .fixedSize(horizontal: false, vertical: true)
                HStack(spacing: 0) {
                    Text("Sent: ")
                        .font(.system(size: 11))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Text"))
                    Text("\(self.dateFormatter.string(from: self.appDelegate.selectedUserTracker != nil ? self.appDelegate.selectedUserTracker.createdAt! : Date())) (\(self.appDelegate.selectedUserTracker != nil ? timeAgoSinceDate(self.appDelegate.selectedUserTracker.createdAt!) : timeAgoSinceDate(Date())))")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text Grey"))
                }
                .frame(height: 13)
                .padding(.top, 6)
                HStack(spacing: 0) {
                    Text("From: ")
                        .font(.system(size: 11))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Text"))
                    Text("\(self.appDelegate.selectedUserTracker != nil ? ParseEmailAddressName(emailAddress: self.appDelegate.selectedUserTracker.fromAddress) : "") (\(self.appDelegate.selectedUserTracker != nil ? ParseEmailAddressEmail(emailAddress: self.appDelegate.selectedUserTracker.fromAddress) : ""))")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text Grey"))
                }
                .frame(height: 13)
                .padding(.top, 5)
                HStack(spacing: 0) {
                    Text("To: ")
                        .font(.system(size: 11))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Text"))
                    Text("\(self.appDelegate.selectedUserTracker != nil ? ParseEmailAddressName(emailAddress: self.appDelegate.selectedUserTracker.toAddresses.components(separatedBy: ",")[0]) : "") (\(self.appDelegate.selectedUserTracker != nil ? ParseEmailAddressEmail(emailAddress: self.appDelegate.selectedUserTracker.toAddresses.components(separatedBy: ",")[0]) : ""))")
                        .font(.system(size: 11))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text Grey"))
                    if (self.appDelegate.selectedUserTracker != nil && self.appDelegate.selectedUserTracker.toAddresses.components(separatedBy: ",").count > 1) {
                        Text(" and")
                            .font(.system(size: 11))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Text Grey"))
                        Text(" more")
                            .font(.system(size: 11))
                            .fontWeight(.regular)
                            .foregroundColor(Color.blue)
                            .underline()
                            .help(extraEmailAddressesToText(addressArray: self.appDelegate.selectedUserTracker.toAddresses.components(separatedBy: ",")))
                    }
                }
                .frame(height: 13)
                .padding(.top, 5)
                if (self.appDelegate.selectedUserTracker != nil) {
                    if (self.appDelegate.selectedUserTracker.ccAddresses != "") {
                        HStack(spacing: 0) {
                            Text("CC: ")
                                .font(.system(size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(Color("Text"))
                            Text("\(ParseEmailAddressName(emailAddress: self.appDelegate.selectedUserTracker.ccAddresses!.components(separatedBy: ",")[0])) (\(ParseEmailAddressEmail(emailAddress: self.appDelegate.selectedUserTracker.ccAddresses!.components(separatedBy: ",")[0])))")
                                .font(.system(size: 11))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Text Grey"))
                            if (self.appDelegate.selectedUserTracker.ccAddresses!.components(separatedBy: ",").count > 1) {
                                Text(" and")
                                    .font(.system(size: 11))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("Text Grey"))
                                Text(" more")
                                    .font(.system(size: 11))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.blue)
                                    .underline()
                                    .help(extraEmailAddressesToText(addressArray: self.appDelegate.selectedUserTracker.ccAddresses!.components(separatedBy: ",")))
                            }
                        }
                        .frame(height: 13)
                        .padding(.top, 5)
                    }
                }
                if (self.appDelegate.selectedUserTracker != nil) {
                    if (self.appDelegate.selectedUserTracker.bccAddresses != "") {
                        HStack(spacing: 0) {
                            Text("BCC: ")
                                .font(.system(size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(Color("Text"))
                            Text("\(ParseEmailAddressName(emailAddress: self.appDelegate.selectedUserTracker.bccAddresses!.components(separatedBy: ",")[0])) (\(ParseEmailAddressEmail(emailAddress: self.appDelegate.selectedUserTracker.bccAddresses!.components(separatedBy: ",")[0])))")
                                .font(.system(size: 11))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Text Grey"))
                            if (self.appDelegate.selectedUserTracker.bccAddresses!.components(separatedBy: ",").count > 1) {
                                Text(" and")
                                    .font(.system(size: 11))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("Text Grey"))
                                Text(" more")
                                    .font(.system(size: 11))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.blue)
                                    .underline()
                                    .help(extraEmailAddressesToText(addressArray: self.appDelegate.selectedUserTracker.bccAddresses!.components(separatedBy: ",")))
                            }
                        }
                        .frame(height: 13)
                        .padding(.top, 5)
                    }
                }
                if (self.appDelegate.selectedUserTracker != nil) {
                    if (self.appDelegate.selectedUserTracker.replyToAddresses != "") {
                        HStack(spacing: 0) {
                            Text("Reply-To: ")
                                .font(.system(size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(Color("Text"))
                            Text("\(ParseEmailAddressName(emailAddress: self.appDelegate.selectedUserTracker.replyToAddresses!.components(separatedBy: ",")[0])) (\(ParseEmailAddressEmail(emailAddress: self.appDelegate.selectedUserTracker.replyToAddresses!.components(separatedBy: ",")[0])))")
                                .font(.system(size: 11))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Text Grey"))
                            if (self.appDelegate.selectedUserTracker.replyToAddresses!.components(separatedBy: ",").count > 1) {
                                Text(" and")
                                    .font(.system(size: 11))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("Text Grey"))
                                Text(" more")
                                    .font(.system(size: 11))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.blue)
                                    .underline()
                                    .help(extraEmailAddressesToText(addressArray: self.appDelegate.selectedUserTracker.replyToAddresses!.components(separatedBy: ",")))
                            }
                        }
                        .frame(height: 13)
                        .padding(.top, 5)
                    }
                }
                HStack(spacing: 0) {
                    if (self.appDelegate.selectedUserTracker != nil) {
                        if (self.appDelegate.selectedUserTracker.timesOpened > 0) {
                            Button {} label: {
                                HStack(spacing: 0) {
                                    Text(String(self.appDelegate.selectedUserTracker.timesOpened))
                                        .font(.system(size: 10))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Green Tag Text"))
                                    Text(" Click\(self.appDelegate.selectedUserTracker.timesOpened > 1 ? "s" : "")")
                                        .font(.system(size: 10))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Green Tag Text"))
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 50, height: 22)
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
                                    Text(timeAgoSinceDate(self.appDelegate.selectedUserTracker.updatedAt ?? Date()))
                                        .font(.system(size: 10))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Yellow Tag Text"))
                                    Text(" at \(timeFormatter.string(from: self.appDelegate.selectedUserTracker.updatedAt ?? Date()))")
                                        .font(.system(size: 10))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Yellow Tag Text"))
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 200, height: 22)
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
                            .frame(width: 62, height: 22)
                            .background(Color("Red Tag Fill"))
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("Red Tag Stroke"), lineWidth: 1)
                            )
                            .cornerRadius(5)
                        }
                    }
                    Button {} label: {
                        Text(self.appDelegate.selectedUserTracker != nil ? MessageSendAction(rawValue: self.appDelegate.selectedUserTracker.composeAction)!.rawValue : "")
                            .font(.system(size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Blue Tag Text"))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 50, height: 22)
                    .background(Color("Blue Tag Fill"))
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("Blue Tag Stroke"), lineWidth: 1)
                    )
                    .cornerRadius(5)
                    .padding(.leading, 5)
                }
                .padding(.top, 7)
                Line()
                    .stroke(
                        Color("Seperate Line"),
                        style: StrokeStyle(lineWidth: 1, dash: [2])
                    )
                    .frame(
                        width: 310,
                        height: 1
                    )
                    .padding(.top, 12)
                // Bottom Section
                if (self.appDelegate.selectedUserTracker != nil && self.appDelegate.selectedUserTracker.timesOpened > 0) {
                    HStack(spacing: 0) {
                        Text("Email Views")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(Color("Text"))
                        HStack(spacing: 0) {
                            Text("Sort: ")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Text Grey"))
                            Menu {
                                if (self.appDelegate.selectedEmailView != EmailViewSort.LATEST_TO_OLDEST) {
                                    Button(EmailViewSort.LATEST_TO_OLDEST.rawValue) {
                                        self.appDelegate.selectedEmailView = EmailViewSort.LATEST_TO_OLDEST
                                    }
                                }
                                if (self.appDelegate.selectedEmailView != EmailViewSort.OLDEST_TO_LATEST) {
                                    Button(EmailViewSort.OLDEST_TO_LATEST.rawValue) {
                                        self.appDelegate.selectedEmailView = EmailViewSort.OLDEST_TO_LATEST
                                    }
                                }
                            } label: {
                                Text("\(self.appDelegate.selectedEmailView.rawValue)  \(Image("Arrow Down"))")
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
                    .frame(width: 310)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                }
            }
            // List
            if (self.appDelegate.secondaryPopoverLoading) {
                VStack(spacing: 0) {
                    ProgressView()
                        .scaleEffect(0.7)
                }
                .frame(width: 310, height: 250)
            } else {
                if (self.appDelegate.selectedUserTracker != nil) {
                    if (self.appDelegate.selectedUserTracker.timesOpened > 0) {
                        ScrollViewReader { proxy in
                            List(self.appDelegate.secondaryPopoverEmailRecords, id: \.id) {trackerRecord in
                                TrackerRecord(
                                    trackerRecord: trackerRecord,
                                    last: trackerRecord == self.appDelegate.secondaryPopoverEmailRecords.last
                                )
                            }
                            .padding(.leading, -8)
                            .padding(.trailing, -9)
                            .listStyle(PlainListStyle())
                            .frame(width: 320)
                            .onChange(of: self.appDelegate.secondaryPopoverEmailRecords) { data in
                                proxy.scrollTo(data[0].id)
                            }
                        }
                    } else {
                        VStack(spacing: 0) {
                            Text("Email not opened")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color("Text"))
                        }
                        .frame(width: 310, height: 250)
                    }
                }
            }
        }
        .padding(.top, 17)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .frame(
            width: 350,
            height: 500,
            alignment: .topLeading
        )
        .background(Color("Background"))
    }
}

struct DetailedContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedContentView()
    }
}
