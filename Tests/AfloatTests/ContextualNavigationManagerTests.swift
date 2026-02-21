//
//  ContextualNavigationManagerTests.swift
//  AfloatTests
//
//  Created by Adélaïde Sky on 21/02/2026.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

import Testing
import SwiftUI
@testable import Afloat

@Suite("ContextualNavigationManager Tests")
struct ContextualNavigationManagerTests {

    // MARK: - Initialization Tests

    @Test("Manager initializes with no defaults")
    func initWithoutDefaults() {
        let manager = ContextualNavigationManager()

        #expect(manager.title == Text(""))
        #expect(manager.subtitle == Text(""))
        #expect(manager.showTitle == false)
        #expect(manager.showSubtitle == false)
        #expect(manager.defaultTitle == nil)
        #expect(manager.defaultSubtitle == nil)
    }

    @Test("Manager initializes with defaults")
    func initWithDefaults() {
        let defaultTitle = Text("Default Title")
        let defaultSubtitle = Text("Default Subtitle")
        let manager = ContextualNavigationManager(defaultTitle: defaultTitle, defaultSubtitle: defaultSubtitle)

        #expect(manager.title == defaultTitle)
        #expect(manager.subtitle == defaultSubtitle)
        #expect(manager.showTitle == true)
        #expect(manager.showSubtitle == true)
        #expect(manager.defaultTitle == defaultTitle)
        #expect(manager.defaultSubtitle == defaultSubtitle)
    }

    // MARK: - Processing Tags Tests

    @Test("Process single eligible title tag")
    func processSingleEligibleTitle() {
        let manager = ContextualNavigationManager()
        var tag = ContextualNavigationTag.title(Text("Test Title"))
        tag.eligible = true

        manager.process([tag])

        #expect(manager.title == Text("Test Title"))
        #expect(manager.showTitle == true)
    }

    @Test("Process single eligible subtitle tag")
    func processSingleEligibleSubtitle() {
        let manager = ContextualNavigationManager()
        var tag = ContextualNavigationTag.subtitle(Text("Test Subtitle"))
        tag.eligible = true

        manager.process([tag])

        #expect(manager.subtitle == Text("Test Subtitle"))
        #expect(manager.showSubtitle == true)
    }

    @Test("Process multiple eligible title tags uses last")
    func processMultipleEligibleTitles() {
        let manager = ContextualNavigationManager()
        let tag1 = ContextualNavigationTag(id: "1", storage: .title(Text("First")), eligible: true)
        let tag2 = ContextualNavigationTag(id: "2", storage: .title(Text("Second")), eligible: true)
        let tag3 = ContextualNavigationTag(id: "3", storage: .title(Text("Third")), eligible: true)

        manager.process([tag1, tag2, tag3])

        #expect(manager.title == Text("Third"))
        #expect(manager.showTitle == true)
    }

    @Test("Process non-eligible tags does not show them")
    func processNonEligibleTags() {
        let manager = ContextualNavigationManager()
        let tag1 = ContextualNavigationTag(id: "1", storage: .title(Text("Title")), eligible: false)
        let tag2 = ContextualNavigationTag(id: "2", storage: .subtitle(Text("Subtitle")), eligible: false)

        manager.process([tag1, tag2])

        #expect(manager.showTitle == false)
        #expect(manager.showSubtitle == false)
    }

    // MARK: - Tag Stack Tests

    @Test("Tag removal updates to previous tag")
    func tagRemovalUpdatesToPrevious() {
        let manager = ContextualNavigationManager()
        let tag1 = ContextualNavigationTag(id: "1", storage: .title(Text("First")), eligible: true)
        var tag2 = ContextualNavigationTag(id: "2", storage: .title(Text("Second")), eligible: true)

        // Add both tags
        manager.process([tag1, tag2])
        #expect(manager.title == Text("Second"))

        // Remove second tag by making it non-eligible
        tag2.eligible = false
        manager.process([tag1, tag2])
        #expect(manager.title == Text("First"))
    }

    @Test("Removing all tags shows default if available")
    func removingAllTagsShowsDefault() {
        let defaultTitle = Text("Default")
        let manager = ContextualNavigationManager(defaultTitle: defaultTitle)
        var tag = ContextualNavigationTag(id: "1", storage: .title(Text("Custom")), eligible: true)

        // Add tag
        manager.process([tag])
        #expect(manager.title == Text("Custom"))

        // Remove tag
        tag.eligible = false
        manager.process([tag])
        #expect(manager.title == defaultTitle)
        #expect(manager.showTitle == true)
    }

    @Test("Removing all tags hides title when no default")
    func removingAllTagsHidesTitle() {
        let manager = ContextualNavigationManager()
        var tag = ContextualNavigationTag(id: "1", storage: .title(Text("Custom")), eligible: true)

        // Add tag
        manager.process([tag])
        #expect(manager.showTitle == true)

        // Remove tag
        tag.eligible = false
        manager.process([tag])
        #expect(manager.showTitle == false)
    }

    // MARK: - Mixed Title and Subtitle Tests

    @Test("Process both title and subtitle independently")
    func processBothTitleAndSubtitle() {
        let manager = ContextualNavigationManager()
        let titleTag = ContextualNavigationTag(id: "1", storage: .title(Text("Title")), eligible: true)
        let subtitleTag = ContextualNavigationTag(id: "2", storage: .subtitle(Text("Subtitle")), eligible: true)

        manager.process([titleTag, subtitleTag])

        #expect(manager.title == Text("Title"))
        #expect(manager.subtitle == Text("Subtitle"))
        #expect(manager.showTitle == true)
        #expect(manager.showSubtitle == true)
    }

    @Test("Title and subtitle can be removed independently")
    func titleAndSubtitleRemoveIndependently() {
        let manager = ContextualNavigationManager()
        var titleTag = ContextualNavigationTag(id: "1", storage: .title(Text("Title")), eligible: true)
        var subtitleTag = ContextualNavigationTag(id: "2", storage: .subtitle(Text("Subtitle")), eligible: true)

        manager.process([titleTag, subtitleTag])

        // Remove title
        titleTag.eligible = false
        manager.process([titleTag, subtitleTag])
        #expect(manager.showTitle == false)
        #expect(manager.showSubtitle == true)

        // Remove subtitle
        subtitleTag.eligible = false
        manager.process([titleTag, subtitleTag])
        #expect(manager.showTitle == false)
        #expect(manager.showSubtitle == false)
    }

    // MARK: - Edge Cases

    @Test("Process empty array")
    func processEmptyArray() {
        let manager = ContextualNavigationManager()
        manager.process([])

        #expect(manager.showTitle == false)
        #expect(manager.showSubtitle == false)
    }
}
