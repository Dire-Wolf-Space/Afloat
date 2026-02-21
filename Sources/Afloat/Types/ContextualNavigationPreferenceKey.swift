//
//  ContextualNavigationPreferenceKey.swift
//  Afloat
//
//  Created by Adélaïde Sky on 14/02/2026.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI

/// A preference key aggregating all contextual navigation tags.
struct ContextualNavigationPreferenceKey: PreferenceKey {
    static let defaultValue: [ContextualNavigationTag] = []

    static func reduce(value: inout [ContextualNavigationTag], nextValue: () -> [ContextualNavigationTag]) {
        value.append(contentsOf: nextValue())
    }
}
