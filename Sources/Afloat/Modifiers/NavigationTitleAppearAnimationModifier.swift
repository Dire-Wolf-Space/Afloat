//
//  NavigationTitleAppearAnimationModifier.swift
//  Afloat
//
//  Created by Adélaïde Sky on 21/02/2026.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI

/// A modifier managing a view's appearance, applying an animation suitable for inline navigation titles.
struct NavigationTitleAppearAnimationModifier: ViewModifier {
    let isVisible: Bool
    let animation: Animation
    
    /// Creates a new navigation title appear animation modifier
    /// - Parameters:
    ///   - isVisible: If the view should display
    ///   - animation: What animation to apply
    init(isVisible: Bool, animation: Animation) {
        self.isVisible = isVisible
        self.animation = animation
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .blur(radius: isVisible ? 0 : 3)
            .offset(y: isVisible ? 0 : 10)
            .animation(animation, value: isVisible)
    }
}
