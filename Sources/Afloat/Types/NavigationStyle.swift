//
//  NavigationType.swift
//  Afloat
//
//  Created by Adélaïde Sky on 14/02/2026.
//

import Foundation

/// A style for configuring navigation title behavior.
///
/// Use navigation styles to control how titles and subtitles appear in your app's navigation interface.
/// Afloat extends SwiftUI's navigation system with contextual styles that respond to scroll position.
///
/// ## Topics
///
/// ### Getting Navigation Styles
///
/// - ``automatic``
/// - ``contextual``
/// - ``contextual(hidesSourceView:offset:)``
public struct NavigationStyle {
    
    /// Underlying storage
    enum Storage: Equatable {
        /// Default system behavior
        case `static`
        /// Custom contextual behavior
        case contextual(hidesSourceView: Bool, offset: CGFloat)
    }
    
    /// The style's raw storage
    let storage: Storage
    
    // MARK: - Presets
    
    /// The system's default navigation style.
    ///
    /// Use this style to apply standard SwiftUI navigation behavior without any contextual changes.
    ///
    /// ```swift
    /// .navigationTitle(.automatic, "Settings")
    /// ```
    public static var automatic: NavigationStyle {
        .init(storage: .static)
    }
    
    /// A contextual navigation style with default settings.
    ///
    /// Enables dynamic navigation titles that update based on scroll position.
    /// The title appears when the tagged view reaches the navigation bar without any fade effect.
    ///
    /// ```swift
    /// .navigationTitle(.contextual, Text("Section Title"))
    /// ```
    ///
    /// For more control over the transition behavior, use ``contextual(hidesSourceView:offset:)``.
    public static var contextual: NavigationStyle {
        .init(storage: .contextual(hidesSourceView: false, offset: 0))
    }
    
    /// A contextual navigation style with custom transition behavior.
    ///
    /// Enables dynamic navigation titles that update based on scroll position with fine-grained control
    /// over how the transition occurs.
    ///
    /// - Parameters:
    ///   - hidesSourceView: When `true`, the source view fades out as it passes under the toolbar,
    ///     creating a smooth transition effect. When `false`, the source view remains visible.
    ///     Default is `false`.
    ///   - offset: Additional offset in points before the title appears in the toolbar.
    ///     Positive values delay the transition (appear later), negative values trigger it earlier.
    ///     Default is `0`.
    ///
    /// ```swift
    /// // Fade out source and delay transition by 20 points
    /// .navigationTitle(
    ///     .contextual(hidesSourceView: true, offset: 20),
    ///     Text("Section Title")
    /// )
    /// ```
    public static func contextual(hidesSourceView: Bool = false, offset: CGFloat = 0) -> NavigationStyle {
        .init(storage: .contextual(hidesSourceView: hidesSourceView, offset: offset))
    }
}
