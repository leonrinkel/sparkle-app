//
//  Helper.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftUI

#if os(macOS)
typealias EventForm = List
typealias EventGroupBox = GroupBox
#else
typealias EventForm = Form
typealias EventGroupBox = Group
#endif

struct LayoutConstants {
    static let sheetIdealWidth = 400.0
    static let sheetIdealHeight = 500.0
}
