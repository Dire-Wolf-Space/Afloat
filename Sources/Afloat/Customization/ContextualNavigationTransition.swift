//
//  ContextualNavigationTransitionKey.swift
//  Afloat
//
//  Created by Adélaïde Sky on 22/02/2026.
//

import SwiftUI

struct ContextualNavigationTransitionKey: EnvironmentKey {
    static var defaultValue: ContentTransition { .identity }
}

extension EnvironmentValues {
    var contextualNavigationTransition: ContentTransition {
        get { self[ContextualNavigationTransitionKey.self] }
        set { self[ContextualNavigationTransitionKey.self] = newValue }
    }
}

extension View {
    /// Customizes the transitions between different contextual navigation titles and subtitles.
    ///
    /// The default value is .identity, meaning no animation is applied.
    /// - Parameter transition: The content transition applied to the contextual navigation titles and subtitles.
    public func contextualNavigationTransition(_ transition: ContentTransition) -> some View {
        environment(\.contextualNavigationTransition, transition)
    }
}
