//
//  ContextualNavigationTag.swift
//  Afloat
//
//  Created by Adélaïde Sky on 14/02/2026.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI

/// A Preference value associating a view with a title or a subtitle.
struct ContextualNavigationTag: Equatable, Identifiable {
    let id: String
    
    /// The tag's underlying content.
    let storage: Storage
    
    /// If the tag is eligible to display.
    var eligible: Bool
    
    // MARK: - Storage
    
    /// The storage
    enum Storage: Equatable {
        case title(Text)
        case subtitle(Text)
        
        // TODO: Toolbars
//        case toolbar(any ToolbarContent)
    }
    
    // MARK: - Init
    
    /// Creates a contextual navigation tag.
    /// - Parameters:
    ///   - id: A stable ID
    ///   - storage: The tag's underlying content
    ///   - eligible: If the tag is eligible to display
    init(id: String, storage: Storage, eligible: Bool = false) {
        self.id = id
        self.storage = storage
        self.eligible = eligible
    }
    
    // MARK: - Convenience
    
    /// Creates a title contextual navigation tag
    /// - Parameter text: The title's text
    /// - Returns: A contextual navigation tag representing a title
    static func title(_ text: Text) -> Self {
        self.init(id: UUID().uuidString, storage: .title(text))
    }
    
    /// Creates a subtitle contextual navigation tag
    /// - Parameter text: The subtitle's text
    /// - Returns: A contextual navigation tag representing a subtitle
    static func subtitle(_ text: Text) -> Self {
        self.init(id: UUID().uuidString, storage: .subtitle(text))
    }
}

// MARK: - Utils

extension ContextualNavigationTag {
    
    /// Whether or not this tag represents a title.
    ///
    /// KeyPath convenience.
    internal var isTitle: Bool {
        if case .title = storage { return true }
        return false
    }
    
    /// Whether or not this tag represents a subtitle.
    ///
    /// KeyPath convenience.
    internal var isSubtitle: Bool {
        if case .subtitle = storage { return true }
        return false
    }
}
