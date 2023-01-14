//
//  BottomBar.swift
//  MailyApp
//
//  Created by Richard Lee on 12/17/22.
//

import SwiftUI

struct BottomBar: View {
    var body: some View {
        VStack(spacing: 0) {
            Line()
                .stroke(
                    Color("Seperate Line"),
                    style: StrokeStyle(lineWidth: 1, dash: [2])
                )
                .frame(
                    width: 260,
                    height: 1
                )
            HStack {
                Button {
                    if let url = URL(string: "https://www.google.com") {
                        NSWorkspace.shared.open(url)
                    }
                } label: {
                    Image("Website")
                        .padding(.trailing, -2)
                    Text("Website")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(
                    width: 86,
                    height: 30
                )
                .background(Color.blue)
                .cornerRadius(15)
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                }
                Button {} label: {
                    Image("Share")
                        .padding(.trailing, 3)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(
                    width: 30,
                    height: 30
                )
                .background(Color("Button Orange"))
                .cornerRadius(15)
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                }.frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
                Menu {
                    Button("Quit Maily") {
                        NSApp.terminate(self)
                    }
                } label: {
                    Image("Settings")
                        .buttonStyle(PlainButtonStyle())
                }
                .menuStyle(BorderlessButtonMenuStyle())
                .menuIndicator(.hidden)
                .fixedSize() // Otherwise will be the width of your menu options.
                .frame(width: 30, height: 30)
                .background(Color("Button on Black"))
                .cornerRadius(15)
                .frame(
                    maxWidth: 30,
                    alignment: .trailing
                )
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.set() : NSCursor.arrow.set()
                }
            }.frame(
                width: 260
            )
            .padding(.top, 15)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .frame(
            width: 300,
            height: 61,
            alignment: .topLeading
        )
        .background(Color("Background"))
    }
}
