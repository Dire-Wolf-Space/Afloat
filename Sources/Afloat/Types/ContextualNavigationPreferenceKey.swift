//
//  ContextualNavigationPreferenceKey.swift
//  Afloat
//
//  Created by Adélaïde Sky on 14/02/2026.
//

import SwiftUI

/// A preference key aggregating all contextual navigation tags.
struct ContextualNavigationPreferenceKey: PreferenceKey {
    static let defaultValue: [ContextualNavigationTag] = []

    static func reduce(value: inout [ContextualNavigationTag], nextValue: () -> [ContextualNavigationTag]) {
        value.append(contentsOf: nextValue())
    }
}
