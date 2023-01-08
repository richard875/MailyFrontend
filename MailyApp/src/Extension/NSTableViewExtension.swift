//
//  NSTableViewExtension.swift
//  MailyApp
//
//  Created by Richard Lee on 1/9/23.
//

import Foundation
import SwiftUI

extension NSTableView {
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        backgroundColor = NSColor.clear
        enclosingScrollView!.drawsBackground = false
    }
}
