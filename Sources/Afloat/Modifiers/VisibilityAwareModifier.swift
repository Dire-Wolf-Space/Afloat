//
//  VisibilityAwareModifier.swift
//  Afloat
//
//  Created by Adélaïde Humez on 22/07/2025.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//
 
import SwiftUI

/// A modifier providing a closure called whenever the view enters or exits the view via a given edge.
struct VisibilityAwareModifier: ViewModifier {
    /// The closure
    let onVisibilityChanged: (Bool) -> Void
    /// An optional offset to append to the out-of-bounds logic
    let offset: CGFloat
    /// The edges to watch for
    let edges: Edge.Set

    func body(content: Content) -> some View {
        content
            .onGeometryChange(for: Bool.self) { proxy in
                
                let frame = proxy.frame(in: .scrollView)
                let bounds = proxy.bounds(of: .scrollView) ?? .zero
                
                return isVisible(frame, in: bounds)
            } action: { isVisible in
                onVisibilityChanged(isVisible)
            }
    }
    
    /// Check if the given frame is contained in the defined bounds on specific angles.
    private nonisolated func isVisible(_ frame: CGRect, in bounds: CGRect) -> Bool {
        var isVisible = true
        
        // Check top edge - view is visible if its bottom edge is past the top offset
        if edges.contains(.top) {
            isVisible = isVisible && frame.maxY > offset
        }
        
        // Check bottom edge - view is visible if its top edge is before the bottom boundary
        if edges.contains(.bottom) {
            isVisible = isVisible && frame.minY < (bounds.height - offset)
        }
        
        // Check leading edge - view is visible if its trailing edge is past the leading offset
        if edges.contains(.leading) {
            isVisible = isVisible && frame.maxX > offset
        }
        
        // Check trailing edge - view is visible if its leading edge is before the trailing boundary
        if edges.contains(.trailing) {
            isVisible = isVisible && frame.minX < (bounds.width - offset)
        }
        
        return isVisible
    }
}

extension View {
    /// Adds a closure that's called whenever the view's visibility changes relative to its scroll container.
    ///
    /// Use this modifier to detect when a view enters or exits the visible bounds of a scroll view.
    /// This is useful for triggering animations, loading content, or tracking user interaction.
    ///
    /// The visibility is calculated based on the view's frame within the scroll view's coordinate space
    /// and the specified edges.
    ///
    /// - Parameters:
    ///   - offset: An offset in points to adjust the detection logic. Positive values shrink the detection
    ///     area (view must be further inside to be considered visible), negative values expand it
    ///     (view is considered visible earlier). Default is `0`.
    ///   - edges: The edges to monitor for visibility changes. Default is `.all`, which checks all edges.
    ///     Use specific edges like `.top` or `.bottom` for more precise control.
    ///   - action: A closure called with `true` when the view becomes visible and `false` when it becomes hidden.
    ///
    /// ```swift
    /// ScrollView {
    ///     ForEach(items) { item in
    ///         ItemView(item)
    ///             .onVisibilityChanged(offset: 20, edges: .top) { isVisible in
    ///                 if isVisible {
    ///                     print("\(item.name) is visible")
    ///                 }
    ///             }
    ///     }
    /// }
    /// ```
    ///
    /// - Note: The action closure may be called frequently as the user scrolls. Avoid performing
    ///   expensive operations directly in the closure.
    public func onVisibilityChanged(offset: CGFloat = 0, edges: Edge.Set = .all, _ action: @escaping (Bool) -> Void) -> some View {
        self.modifier(VisibilityAwareModifier(onVisibilityChanged: action, offset: offset, edges: edges))
    }
}
