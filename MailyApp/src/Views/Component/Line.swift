//
//  Line.swift
//  MailyApp
//
//  Created by Richard Lee on 1/6/23.
//

import Foundation
import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
