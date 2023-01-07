//
//  Index.swift
//  MailyApp
//
//  Created by Richard Lee on 12/18/22.
//

import Foundation
import SwiftUI

struct Index: View {
    var setRoute: ((Route) -> Void)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top Section
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Image("profile\(Int.random(in: 1...33))")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 7)
                            .stroke(Color("Border"), lineWidth: 1)
                        )
                        .cornerRadius(13)
                }
                .frame(width: 105, alignment: .topLeading)
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
                    Button {} label: {
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
                    Button {} label: {
                        Image("Settings Inverse")
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
                    
                }
                .frame(height: 40, alignment: .topLeading)
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                }
            }
            .frame(
                width: 260,
                height: 40,
                alignment: .topLeading
            )
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Richard Lee")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Text"))
                    Text(verbatim: "richard@apple.com")
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
                    Button {} label: {
                        Text("Email Verified")
                            .font(.system(size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Green Tag Text"))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 83, height: 24)
                    .background(Color("Green Tag Fill"))
                    .overlay(RoundedRectangle(cornerRadius: 7)
                        .stroke(Color("Green Tag Stroke"), lineWidth: 1)
                    )
                    .cornerRadius(5)
                }
                .frame(height: 32, alignment: .topLeading)
            }
            .frame(
                width: 260,
                height: 32,
                alignment: .topLeading
            )
            .padding(.top, 14)
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image("Click")
                        .padding(.trailing, 7)
                    Text("117")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Text"))
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
                    Text("155")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Text"))
                    Text(" Emails Sent")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Text"))
                }
                .frame(height: 14)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(
                width: 260,
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
                    width: 260,
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
                    Text("All Emails")
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Text"))
                    Image("Arrow Down")
                        .padding(.leading, 5)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
            }
            .frame(width: 260)
            .padding(.top, 17)
        }
        .padding(.top, 17)
        .padding(.leading, 20)
        .frame(
            width: 300,
            height: 500,
            alignment: .topLeading
        )
        .background(Color("Background"))
    }
}
