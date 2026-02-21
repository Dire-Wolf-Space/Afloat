//
//  ContextualNavigationTagTests.swift
//  AfloatTests
//
//  Created by Claude on 21/02/2026.
//

import Testing
import SwiftUI
@testable import Afloat

@Suite("ContextualNavigationTag Tests")
struct ContextualNavigationTagTests {

    // MARK: - Initialization Tests

    @Test("Tag initializes with title storage")
    func initWithTitleStorage() {
        let text = Text("Title")
        let tag = ContextualNavigationTag(id: "test-id", storage: .title(text), eligible: false)

        #expect(tag.id == "test-id")
        #expect(tag.eligible == false)

        if case .title(let storedText) = tag.storage {
            #expect(storedText == text)
        } else {
            Issue.record("Expected title storage")
        }
    }

    @Test("Tag initializes with subtitle storage")
    func initWithSubtitleStorage() {
        let text = Text("Subtitle")
        let tag = ContextualNavigationTag(id: "test-id", storage: .subtitle(text), eligible: true)

        #expect(tag.id == "test-id")
        #expect(tag.eligible == true)

        if case .subtitle(let storedText) = tag.storage {
            #expect(storedText == text)
        } else {
            Issue.record("Expected subtitle storage")
        }
    }

    @Test("Tag initializes with default eligible false")
    func initWithDefaultEligible() {
        let tag = ContextualNavigationTag(id: "test-id", storage: .title(Text("Title")))

        #expect(tag.eligible == false)
    }

    // MARK: - Convenience Constructors Tests

    @Test("Title convenience constructor creates correct tag")
    func titleConvenienceConstructor() {
        let text = Text("Test Title")
        let tag = ContextualNavigationTag.title(text)

        #expect(tag.id == "\(text)")
        #expect(tag.eligible == false)

        if case .title(let storedText) = tag.storage {
            #expect(storedText == text)
        } else {
            Issue.record("Expected title storage")
        }
    }

    @Test("Subtitle convenience constructor creates correct tag")
    func subtitleConvenienceConstructor() {
        let text = Text("Test Subtitle")
        let tag = ContextualNavigationTag.subtitle(text)

        #expect(tag.id == "\(text)")
        #expect(tag.eligible == false)

        if case .subtitle(let storedText) = tag.storage {
            #expect(storedText == text)
        } else {
            Issue.record("Expected subtitle storage")
        }
    }

    // MARK: - isTitle and isSubtitle Tests

    @Test("isTitle returns true for title storage")
    func isTitleReturnsTrueForTitle() {
        let tag = ContextualNavigationTag.title(Text("Title"))

        #expect(tag.isTitle == true)
        #expect(tag.isSubtitle == false)
    }

    @Test("isSubtitle returns true for subtitle storage")
    func isSubtitleReturnsTrueForSubtitle() {
        let tag = ContextualNavigationTag.subtitle(Text("Subtitle"))

        #expect(tag.isTitle == false)
        #expect(tag.isSubtitle == true)
    }

    // MARK: - Equatable Tests

    @Test("Tags with same properties are equal")
    func tagsEquality() {
        let text = Text("Title")
        let tag1 = ContextualNavigationTag(id: "same-id", storage: .title(text), eligible: true)
        let tag2 = ContextualNavigationTag(id: "same-id", storage: .title(text), eligible: true)

        #expect(tag1 == tag2)
    }

    @Test("Tags with different properties are not equal")
    func tagsInequality() {
        let text = Text("Title")
        let tag1 = ContextualNavigationTag(id: "id1", storage: .title(text), eligible: true)
        let tag2 = ContextualNavigationTag(id: "id2", storage: .title(text), eligible: false)

        #expect(tag1 != tag2)
    }

    // MARK: - Edge Cases

    @Test("Mutable eligible property")
    func mutableEligibleProperty() {
        var tag = ContextualNavigationTag.title(Text("Title"))

        #expect(tag.eligible == false)

        tag.eligible = true
        #expect(tag.eligible == true)

        tag.eligible = false
        #expect(tag.eligible == false)
    }

    @Test("Tags with different text generate different ids")
    func differentTextGeneratesDifferentIds() {
        let tag1 = ContextualNavigationTag.title(Text("First"))
        let tag2 = ContextualNavigationTag.title(Text("Second"))

        #expect(tag1.id != tag2.id)
    }
}
