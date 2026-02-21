//
//  ContextualNavigationTagModifier.swift
//  Afloat
//
//  Created by Adélaïde Sky on 14/02/2026.
//
//  Copyright © 2025 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI

/// A modifier applying a contextual navigation tag to a view.
struct ContextualNavigationTagModifier: ViewModifier {
    let hidesSourceView: Bool
    let offset: CGFloat
    
    @State private var tag: ContextualNavigationTag
    
    /// Creates a new contextual navigation tag modifier.
    /// - Parameters:
    ///   - tag: The tag to apply
    ///   - hidesSourceView: If the source view should disappear when out of bounds
    ///   - offset: The offset to pass to the overflow logic
    init(_ tag: ContextualNavigationTag, hidesSourceView: Bool, offset: CGFloat) {
        self.hidesSourceView = hidesSourceView
        self.offset = offset
        self.tag = tag
    }
    
    func body(content: Content) -> some View {
        content
            .animation(.snappy(duration: 0.3)) {
                $0.opacity(hidesSourceView && tag.eligible ? 0 : 1)
            }
            .onVisibilityChanged(offset: offset, edges: .top) { isVisible in
                tag.eligible = !isVisible
            }
            .transformPreference(ContextualNavigationPreferenceKey.self) { value in
                value.append(tag)
            }
    }
}
