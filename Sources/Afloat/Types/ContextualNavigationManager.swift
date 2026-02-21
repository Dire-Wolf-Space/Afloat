//
//  ContextualNavigationManager.swift
//  Afloat
//
//  Created by Adélaïde Sky on 21/02/2026.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI
import Observation

/// Manager tracking the state of a contextual navigation context.
@Observable
final class ContextualNavigationManager {
    
    /// The currently displayed title.
    var title: Text = Text("")
    /// The currently displayed subtitle.
    var subtitle: Text = Text("")
    
    /// If the title should be visible.
    var showTitle: Bool = false
    /// If the subtitle should be visible.
    var showSubtitle: Bool = false
    
    /// The default title, if any.
    @ObservationIgnored var defaultTitle: Text? = nil
    /// The default subtitle, if any.
    @ObservationIgnored var defaultSubtitle: Text? = nil
    
    /// The tag stack
    ///
    /// As the user scrolls and tags come and go in the view hierarchy, they get appended to this stack.
    /// When scrolling back up, they are removed one by one, so that the manager always knows what's the current title or subtitle to display,
    /// even if the currently displayed title's view disappeared from the hierarchy (for example when using LazyVStack).
    ///
    private var tagStack: [ContextualNavigationTag] = []
    
    // MARK: - Init
    
    init(defaultTitle: Text? = nil, defaultSubtitle: Text? = nil) {
        if let defaultTitle {
            self.defaultTitle = defaultTitle
            self.title = defaultTitle
            self.showTitle = true
        }
        
        if let defaultSubtitle {
            self.defaultSubtitle = defaultSubtitle
            self.subtitle = defaultSubtitle
            self.showSubtitle = true
        }
    }
    
    // MARK: - Methods
    
    /// Process a new batch of navigation tags
    ///
    /// Called from a view whenever the underlying view hierarchy reports a change in tags.
    ///
    /// - Parameter tags: The tags to process
    func process(_ tags: [ContextualNavigationTag]) {
        let nonEligibleIds = Set(tags.filter { !$0.eligible }.map { $0.id })
        
        if title == Text("") {
            // Find first title and set it
            title = findText(in: tags, matching: \.isTitle, position: .first) ?? Text("")
        }
        
        if subtitle == Text("") {
            // Find first subtitle and set it
            subtitle = findText(in: tags, matching: \.isSubtitle, position: .first) ?? Text("")
        }
        
        // Add newly eligible tags to stack
        for tag in tags where tag.eligible {
            if !tagStack.contains(where: { $0.id == tag.id }) {
                tagStack.append(tag)
            }
        }
        
        // Remove non-eligible tags from stack
        tagStack.removeAll { nonEligibleIds.contains($0.id) }
        
        // Update navigation title and subtitle
        updateNavigationElements()
    }
    
    /// Updates the currently displayed navigation elements.
    private func updateNavigationElements() {
        // Find the last title and subtitle in the stack
        if let latestTitle = findText(in: tagStack, matching: \.isTitle, position: .last) {
            title = latestTitle
            showTitle = true
        } else if let defaultTitle {
            title = defaultTitle
        } else {
            showTitle = false
        }
        
        if let latestSubtitle = findText(in: tagStack, matching: \.isSubtitle, position: .last) {
            subtitle = latestSubtitle
            showSubtitle = true
        } else if let defaultSubtitle {
            subtitle = defaultSubtitle
        } else {
            showSubtitle = false
        }
    }
    
    // MARK: - Utilities
    
    /// A position to look for in an array.
    private enum SearchPosition {
        case first, last
    }
    
    /// Finds a tag's text in an array.
    /// - Parameters:
    ///   - tags: The tags to search in
    ///   - keyPath: The condition
    ///   - position: The position to pick
    /// - Returns: The first, or last, tag's text matching the keyPath condition.
    private func findText(in tags: [ContextualNavigationTag], matching keyPath: KeyPath<ContextualNavigationTag, Bool>, position: SearchPosition) -> Text? {
        let matchingTag = position == .first
            ? tags.first(where: { $0[keyPath: keyPath] })
            : tags.last(where: { $0[keyPath: keyPath] })
        
        guard let tag = matchingTag else { return nil }
        
        switch tag.storage {
        case .title(let text), .subtitle(let text):
            return text
        }
    }
}
