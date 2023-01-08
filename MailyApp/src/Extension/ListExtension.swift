//
//  ListExtension.swift
//  MailyApp
//
//  Created by Richard Lee on 1/8/23.
//

import Foundation
import SwiftUI
import Introspect

extension List {
  /// List on macOS uses an opaque background with no option for
  /// removing/changing it. listRowBackground() doesn't work either.
  /// This workaround works because List is backed by NSTableView.
  func removeBackground() -> some View {
    return introspectTableView { tableView in
      tableView.backgroundColor = .clear
      tableView.enclosingScrollView!.drawsBackground = false
    }
  }
}
