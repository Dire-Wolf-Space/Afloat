//
//  ContextualNavigationModifier.swift
//  Afloat
//
//  Created by Adélaïde Sky on 14/02/2026.
//

import SwiftUI
import Observation

/// A modifier displaying underlying view's contextual navigation tags.
struct ContextualNavigationModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    let animation: Animation = .snappy(duration: 0.4, extraBounce: 0.2)

    @State private var manager: ContextualNavigationManager
    
    init(defaultTitle: Text? = nil, defaultSubtitle: Text? = nil) {
        self.manager = .init(defaultTitle: defaultTitle, defaultSubtitle: defaultSubtitle)
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            // Watch the preferences and forward to the manager.
            .onPreferenceChange(ContextualNavigationPreferenceKey.self) { manager.process($0) }
            
        #if canImport(UIKit)
            .navigationBarTitleDisplayMode(.inline) // TODO: Remove this restriction. Needs a lot of work so for now the SDK forces inline appearance.
            .toolbar {
                ToolbarItem(placement: .title) { title }
                ToolbarItem(placement: .subtitle) { subtitle }
            }
        #else
            // On macOS, .title and .subtitle placements are unavailable.
            // Therefore, applying the plain modifiers without any animation.
            .navigationTitle(manager.showTitle ? manager.title : .init(""))
            .navigationSubtitle(manager.showSubtitle ? manager.subtitle : .init(""))
        #endif
    }
    
    // MARK: - Subviews
    
    /// The navigation title
    @ViewBuilder
    var title: some View {
        manager.title
            .font(.headline)
        
            .modifier(
                NavigationTitleAppearAnimationModifier(
                    isVisible: manager.showTitle,
                    animation: animation
                )
            )
    }
    
    /// The navigation subtitle
    @ViewBuilder
    var subtitle: some View {
        manager.subtitle
            .font(.caption2.weight(.medium))
        
            .opacity(0.5)
            .blendMode(colorScheme == .dark ? .plusLighter : .plusDarker)
            .offset(x: 0.2) // Fix a small drift
        
            .modifier(
                NavigationTitleAppearAnimationModifier(
                    isVisible: manager.showSubtitle,
                    animation: animation
                        .delay(manager.showSubtitle && manager.showTitle && manager.defaultTitle == nil ? 0.05 : 0) // Small delay on appear
                )
            )
    }
}
