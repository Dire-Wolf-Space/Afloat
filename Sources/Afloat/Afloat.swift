//
//  Afloat
//
//  Created by Adélaïde Sky on 14/02/2026.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI

// MARK: - Navigation Title

extension View {
    /// Configures the view's title for purposes of navigation.
    ///
    /// A view's navigation title is used to visually display
    /// the current navigation state of an interface.
    /// On iOS and watchOS, when a view is navigated to inside
    /// of a navigation view, that view's title is displayed
    /// in the navigation bar. On iPadOS, the primary destination's
    /// navigation title is reflected as the window's title in the
    /// App Switcher. Similarly on macOS, the primary destination's title
    /// is used as the window title in the titlebar, Windows menu
    /// and Mission Control.
    ///
    /// Refer to the <doc:Configure-Your-Apps-Navigation-Titles> article
    /// for more information on navigation title modifiers.
    ///
    /// - Important: When using ``NavigationStyle/contextual``, apply this modifier
    ///   to the specific header view that should trigger the title change, not to
    ///   an entire section container. The modifier tracks when the view it's applied to
    ///   has scrolled past the top edge, so applying it to a large container will prevent
    ///   the title from appearing until the entire container has scrolled past.
    ///
    /// - Parameters:
    ///   - type: The style of navigation.
    ///   - text: The title to display.
    @ViewBuilder
    public func navigationTitle(_ type: NavigationStyle, _ text: Text) -> some View {
        switch type.storage {
            case .contextual(let hidesSourceView, let offset):
                modifier(ContextualNavigationTagModifier(.title(text), hidesSourceView: hidesSourceView, offset: offset))
            case .static:
                navigationTitle(text)
        }
    }
    
    /// Configures the view's title for purposes of navigation,
    /// using a localized string.
    ///
    /// A view's navigation title is used to visually display
    /// the current navigation state of an interface.
    /// On iOS and watchOS, when a view is navigated to inside
    /// of a navigation view, that view's title is displayed
    /// in the navigation bar. On iPadOS, the primary destination's
    /// navigation title is reflected as the window's title in the
    /// App Switcher. Similarly on macOS, the primary destination's title
    /// is used as the window title in the titlebar, Windows menu
    /// and Mission Control.
    ///
    /// Refer to the <doc:Configure-Your-Apps-Navigation-Titles> article
    /// for more information on navigation title modifiers.
    ///
    /// - Important: When using ``NavigationStyle/contextual``, apply this modifier
    ///   to the specific header view that should trigger the title change, not to
    ///   an entire section container. The modifier tracks when the view it's applied to
    ///   has scrolled past the top edge, so applying it to a large container will prevent
    ///   the title from appearing until the entire container has scrolled past.
    ///
    /// - Parameters:
    ///   - type: The style of navigation.
    ///   - titleKey: The key to a localized string to display.
    public func navigationTitle(_ type: NavigationStyle, _ titleKey: LocalizedStringKey) -> some View {
        navigationTitle(type, Text(titleKey))
    }

    /// Configures the view's title for purposes of navigation,
    /// using a localized string resource.
    ///
    /// A view's navigation title is used to visually display
    /// the current navigation state of an interface.
    /// On iOS and watchOS, when a view is navigated to inside
    /// of a navigation view, that view's title is displayed
    /// in the navigation bar. On iPadOS, the primary destination's
    /// navigation title is reflected as the window's title in the
    /// App Switcher. Similarly on macOS, the primary destination's title
    /// is used as the window title in the titlebar, Windows menu
    /// and Mission Control.
    ///
    /// Refer to the <doc:Configure-Your-Apps-Navigation-Titles> article
    /// for more information on navigation title modifiers.
    ///
    /// - Important: When using ``NavigationStyle/contextual``, apply this modifier
    ///   to the specific header view that should trigger the title change, not to
    ///   an entire section container. The modifier tracks when the view it's applied to
    ///   has scrolled past the top edge, so applying it to a large container will prevent
    ///   the title from appearing until the entire container has scrolled past.
    ///
    /// - Parameters:
    ///   - type: The style of navigation.
    ///   - titleResource: The key to a localized string to display.
    @inlinable
    @_alwaysEmitIntoClient
    public func navigationTitle(_ type: NavigationStyle, _ titleResource: LocalizedStringResource) -> some View {
        navigationTitle(type, Text(titleResource))
    }

    /// Configures the view's title for purposes of navigation, using a string.
    ///
    /// A view's navigation title is used to visually display
    /// the current navigation state of an interface.
    /// On iOS and watchOS, when a view is navigated to inside
    /// of a navigation view, that view's title is displayed
    /// in the navigation bar. On iPadOS, the primary destination's
    /// navigation title is reflected as the window's title in the
    /// App Switcher. Similarly on macOS, the primary destination's title
    /// is used as the window title in the titlebar, Windows menu
    /// and Mission Control.
    ///
    /// Refer to the <doc:Configure-Your-Apps-Navigation-Titles> article
    /// for more information on navigation title modifiers.
    ///
    /// - Important: When using ``NavigationStyle/contextual``, apply this modifier
    ///   to the specific header view that should trigger the title change, not to
    ///   an entire section container. The modifier tracks when the view it's applied to
    ///   has scrolled past the top edge, so applying it to a large container will prevent
    ///   the title from appearing until the entire container has scrolled past.
    ///
    /// - Parameters:
    ///   - type: The style of navigation.
    ///   - title: The string to display.
    @inlinable
    @_alwaysEmitIntoClient
    public func navigationTitle<S: StringProtocol>(_ type: NavigationStyle, _ title: S) -> some View {
        navigationTitle(type, Text(title))
    }
}

// MARK: - Navigation Subtitle

extension View {
    /// Configures the view's subtitle for purposes of navigation.
    ///
    /// A view's navigation subtitle is used to provide additional
    /// contextual information alongside the navigation title.
    /// On macOS, the primary destination's subtitle is displayed
    /// with the navigation title in the titlebar. On iOS and iPadOS,
    /// the subtitle is displayed with the navigation title in the
    /// navigation bar.
    ///
    /// - Important: When using ``NavigationStyle/contextual``, apply this modifier
    ///   to the specific header view that should trigger the subtitle change, not to
    ///   an entire section container. The modifier tracks when the view it's applied to
    ///   has scrolled past the top edge, so applying it to a large container will prevent
    ///   the subtitle from appearing until the entire container has scrolled past.
    ///
    /// - Parameters:
    ///   - type: The style of navigation
    ///   - text: The title to display
    @ViewBuilder
    public func navigationSubtitle(_ type: NavigationStyle, _ text: Text) -> some View {
        switch type.storage {
            case .contextual(let hidesSourceView, let offset):
                modifier(ContextualNavigationTagModifier(.subtitle(text), hidesSourceView: hidesSourceView, offset: offset))
            case .static:
                navigationSubtitle(text)
        }
    }
    
    /// Configures the view's subtitle for purposes of navigation, using a localized string.
    ///
    /// A view's navigation subtitle is used to provide additional
    /// contextual information alongside the navigation title.
    /// On macOS, the primary destination's subtitle is displayed
    /// with the navigation title in the titlebar. On iOS and iPadOS,
    /// the subtitle is displayed with the navigation title in the
    /// navigation bar.
    ///
    /// - Important: When using ``NavigationStyle/contextual``, apply this modifier
    ///   to the specific header view that should trigger the subtitle change, not to
    ///   an entire section container. The modifier tracks when the view it's applied to
    ///   has scrolled past the top edge, so applying it to a large container will prevent
    ///   the subtitle from appearing until the entire container has scrolled past.
    ///
    /// - Parameters:
    ///   - type: The style of navigation
    ///   - subtitleKey: The key to a localized string to display.
    @inlinable
    @_alwaysEmitIntoClient
    public func navigationSubtitle(_ type: NavigationStyle, _ subtitleKey: LocalizedStringKey) -> some View {
        navigationSubtitle(type, Text(subtitleKey))
    }
    
    /// Configures the view's subtitle for purposes of navigation, using a localized string resource.
    ///
    /// A view's navigation subtitle is used to provide additional
    /// contextual information alongside the navigation title.
    /// On macOS, the primary destination's subtitle is displayed
    /// with the navigation title in the titlebar. On iOS and iPadOS,
    /// the subtitle is displayed with the navigation title in the
    /// navigation bar.
    ///
    /// - Important: When using ``NavigationStyle/contextual``, apply this modifier
    ///   to the specific header view that should trigger the subtitle change, not to
    ///   an entire section container. The modifier tracks when the view it's applied to
    ///   has scrolled past the top edge, so applying it to a large container will prevent
    ///   the subtitle from appearing until the entire container has scrolled past.
    ///
    /// - Parameters:
    ///   - type: The style of navigation
    ///   - subtitleKey: The key to a localized string to display.
    @inlinable
    @_alwaysEmitIntoClient
    public func navigationSubtitle(_ type: NavigationStyle, _ subtitleKey: LocalizedStringResource) -> some View {
        navigationSubtitle(type, Text(subtitleKey))
    }
    
    /// Configures the view's subtitle for purposes of navigation, using a string.
    ///
    /// A view's navigation subtitle is used to provide additional
    /// contextual information alongside the navigation title.
    /// On macOS, the primary destination's subtitle is displayed
    /// with the navigation title in the titlebar. On iOS and iPadOS,
    /// the subtitle is displayed with the navigation title in the
    /// navigation bar.
    ///
    /// - Important: When using ``NavigationStyle/contextual``, apply this modifier
    ///   to the specific header view that should trigger the subtitle change, not to
    ///   an entire section container. The modifier tracks when the view it's applied to
    ///   has scrolled past the top edge, so applying it to a large container will prevent
    ///   the subtitle from appearing until the entire container has scrolled past.
    ///
    /// - Parameters:
    ///   - type: The style of navigation
    ///   - subtitle: The subtitle to display.
    @inlinable
    @_alwaysEmitIntoClient
    public func navigationSubtitle<S: StringProtocol>(_ type: NavigationStyle, _ subtitle: S) -> some View {
        navigationSubtitle(type, Text(subtitle))
    }
}

// MARK: - Contextual Navigation

extension View {
    /// Sets up contextual navigation for the view hierarchy.
    ///
    /// Apply this modifier to the root of your navigation content (typically a `ScrollView` or `List`)
    /// to enable contextual navigation titles and subtitles. Child views can then use
    /// ``SwiftUICore/View/navigationTitle(_:_:)-(_,Text)`` and ``SwiftUICore/View/navigationSubtitle(_:_:)-(_,Text)``
    /// with ``NavigationStyle/contextual`` to provide dynamic titles.
    ///
    /// ```swift
    /// NavigationStack {
    ///     ScrollView {
    ///         ForEach(sections) { section in
    ///             SectionView(section)
    ///                 .navigationTitle(.contextual, Text(section.name))
    ///         }
    ///     }
    ///     .contextualNavigation()
    /// }
    /// ```
    ///
    /// - Note: This modifier must be applied before any contextual navigation titles in the view hierarchy
    ///   will take effect. Apply it once at the root of your scrollable content.
    @ViewBuilder
    public func contextualNavigation() -> some View {
        modifier(ContextualNavigationModifier(defaultTitle: nil, defaultSubtitle: nil))
    }
    
    /// Sets up contextual navigation for the view hierarchy.
    ///
    /// Apply this modifier to the root of your navigation content (typically a `ScrollView` or `List`)
    /// to enable contextual navigation titles and subtitles. Child views can then use
    /// ``SwiftUICore/View/navigationTitle(_:_:)-(_,Text)`` and ``SwiftUICore/View/navigationSubtitle(_:_:)-(_,Text)``
    /// with ``NavigationStyle/contextual`` to provide dynamic titles.
    ///
    /// - Parameters:
    ///   - defaultTitle: The title displayed when no contextual title is visible, such as when
    ///     the user is at the top of the scroll view. If `nil`, no title is shown by default.
    ///   - defaultSubtitle: The subtitle displayed when no contextual subtitle is visible.
    ///     If `nil`, no subtitle is shown by default.
    ///
    /// ```swift
    /// NavigationStack {
    ///     ScrollView {
    ///         ForEach(sections) { section in
    ///             SectionView(section)
    ///                 .navigationTitle(.contextual, Text(section.name))
    ///         }
    ///     }
    ///     .contextualNavigation(defaultTitle: Text("All Sections"))
    /// }
    /// ```
    ///
    /// - Note: This modifier must be applied before any contextual navigation titles in the view hierarchy
    ///   will take effect. Apply it once at the root of your scrollable content.
    @ViewBuilder
    public func contextualNavigation(defaultTitle: Text? = nil, defaultSubtitle: Text? = nil) -> some View {
        modifier(ContextualNavigationModifier(defaultTitle: defaultTitle, defaultSubtitle: defaultSubtitle))
    }
    
    /// Sets up contextual navigation for the view hierarchy, using localized strings.
    ///
    /// Apply this modifier to the root of your navigation content (typically a `ScrollView` or `List`)
    /// to enable contextual navigation titles and subtitles. Child views can then use
    /// ``SwiftUICore/View/navigationTitle(_:_:)-(_,LocalizedStringKey)`` and ``SwiftUICore/View/navigationSubtitle(_:_:)-(_,LocalizedStringKey)``
    /// with ``NavigationStyle/contextual`` to provide dynamic titles.
    ///
    /// - Parameters:
    ///   - defaultTitle: The key to a localized string displayed when no contextual title is visible,
    ///     such as when the user is at the top of the scroll view. If `nil`, no title is shown by default.
    ///   - defaultSubtitle: The key to a localized string displayed when no contextual subtitle is visible.
    ///     If `nil`, no subtitle is shown by default.
    ///
    /// ```swift
    /// NavigationStack {
    ///     ScrollView {
    ///         ForEach(sections) { section in
    ///             SectionView(section)
    ///                 .navigationTitle(.contextual, section.name)
    ///         }
    ///     }
    ///     .contextualNavigation(defaultTitle: "all.sections")
    /// }
    /// ```
    ///
    /// - Note: This modifier must be applied before any contextual navigation titles in the view hierarchy
    ///   will take effect. Apply it once at the root of your scrollable content.
    @inlinable
    @_alwaysEmitIntoClient
    public func contextualNavigation(defaultTitle: LocalizedStringKey? = nil, defaultSubtitle: LocalizedStringKey? = nil) -> some View {
        contextualNavigation(
            defaultTitle: defaultTitle.map { Text($0) },
            defaultSubtitle: defaultSubtitle.map { Text($0) }
        )
    }
    
    /// Sets up contextual navigation for the view hierarchy, using localized string resources.
    ///
    /// Apply this modifier to the root of your navigation content (typically a `ScrollView` or `List`)
    /// to enable contextual navigation titles and subtitles. Child views can then use
    /// ``SwiftUICore/View/navigationTitle(_:_:)-(_,LocalizedStringResource)`` and ``SwiftUICore/View/navigationSubtitle(_:_:)-(_,LocalizedStringResource)``
    /// with ``NavigationStyle/contextual`` to provide dynamic titles.
    ///
    /// - Parameters:
    ///   - defaultTitleResource: The localized string resource displayed when no contextual title is visible,
    ///     such as when the user is at the top of the scroll view. If `nil`, no title is shown by default.
    ///   - defaultSubtitleResource: The localized string resource displayed when no contextual subtitle is visible.
    ///     If `nil`, no subtitle is shown by default.
    ///
    /// - Note: This modifier must be applied before any contextual navigation titles in the view hierarchy
    ///   will take effect. Apply it once at the root of your scrollable content.
    @inlinable
    @_alwaysEmitIntoClient
    public func contextualNavigation(defaultTitleResource: LocalizedStringResource? = nil, defaultSubtitleResource: LocalizedStringResource? = nil) -> some View {
        contextualNavigation(
            defaultTitle: defaultTitleResource.map { Text($0) },
            defaultSubtitle: defaultSubtitleResource.map { Text($0) }
        )
    }
    
    /// Sets up contextual navigation for the view hierarchy, using strings.
    ///
    /// Apply this modifier to the root of your navigation content (typically a `ScrollView` or `List`)
    /// to enable contextual navigation titles and subtitles. Child views can then use
    /// ``SwiftUICore/View/navigationTitle(_:_:)-(_,S)`` and ``SwiftUICore/View/navigationSubtitle(_:_:)-(_,S)``
    /// with ``NavigationStyle/contextual`` to provide dynamic titles.
    ///
    /// - Parameters:
    ///   - defaultTitle: The string displayed when no contextual title is visible, such as when
    ///     the user is at the top of the scroll view. If `nil`, no title is shown by default.
    ///   - defaultSubtitle: The string displayed when no contextual subtitle is visible.
    ///     If `nil`, no subtitle is shown by default.
    ///
    /// ```swift
    /// NavigationStack {
    ///     ScrollView {
    ///         ForEach(sections) { section in
    ///             SectionView(section)
    ///                 .navigationTitle(.contextual, section.name)
    ///         }
    ///     }
    ///     .contextualNavigation(defaultTitle: "All Sections")
    /// }
    /// ```
    ///
    /// - Note: This modifier must be applied before any contextual navigation titles in the view hierarchy
    ///   will take effect. Apply it once at the root of your scrollable content.
    @inlinable
    @_alwaysEmitIntoClient
    public func contextualNavigation<S1: StringProtocol, S2: StringProtocol>(defaultTitle: S1? = nil, defaultSubtitle: S2? = nil) -> some View {
        contextualNavigation(
            defaultTitle: defaultTitle.map { Text($0) },
            defaultSubtitle: defaultSubtitle.map { Text($0) }
        )
    }
}
