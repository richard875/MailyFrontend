//
//  ReplaceHttpWithWs.swift
//  MailyApp
//
//  Created by Richard Lee on 1/16/23.
//

import Foundation

func replaceHttpWithWs(string: String) -> String {
    return string.replacingOccurrences(of: "http", with: "ws").replacingOccurrences(of: "https", with: "ws")
}
