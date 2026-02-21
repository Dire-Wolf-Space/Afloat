//
//  ViewModifierIntegrationTests.swift
//  AfloatTests
//
//  Created by Claude on 21/02/2026.
//

import Testing
import SwiftUI
@testable import Afloat

@Suite("View Modifier Integration Tests")
@MainActor
struct ViewModifierIntegrationTests {

    // MARK: - ContextualNavigationPreferenceKey Tests

    @Test("ContextualNavigationPreferenceKey has empty default value")
    func preferenceKeyDefaultValue() {
        let defaultValue = ContextualNavigationPreferenceKey.defaultValue

        #expect(defaultValue.isEmpty == true)
    }

    @Test("ContextualNavigationPreferenceKey reduces values correctly")
    func preferenceKeyReduceValues() {
        var accumulator: [ContextualNavigationTag] = []
        let newTags = [
            ContextualNavigationTag.title(Text("Title 1")),
            ContextualNavigationTag.title(Text("Title 2"))
        ]

        ContextualNavigationPreferenceKey.reduce(value: &accumulator) {
            newTags
        }

        #expect(accumulator.count == 2)
        #expect(accumulator[0].id == newTags[0].id)
        #expect(accumulator[1].id == newTags[1].id)
    }

    @Test("ContextualNavigationPreferenceKey reduces multiple batches")
    func preferenceKeyReduceMultipleBatches() {
        var accumulator: [ContextualNavigationTag] = [
            ContextualNavigationTag.title(Text("Existing"))
        ]

        ContextualNavigationPreferenceKey.reduce(value: &accumulator) {
            [ContextualNavigationTag.title(Text("New 1"))]
        }

        ContextualNavigationPreferenceKey.reduce(value: &accumulator) {
            [ContextualNavigationTag.title(Text("New 2"))]
        }

        #expect(accumulator.count == 3)
    }

    // MARK: - Modifier Initialization Tests

    @Test("Modifiers initialize with correct properties")
    func modifierInitialization() {
        let animModifier = NavigationTitleAppearAnimationModifier(isVisible: true, animation: .default)
        #expect(animModifier.isVisible == true)

        let tag = ContextualNavigationTag.title(Text("Test"))
        let tagModifier = ContextualNavigationTagModifier(tag, hidesSourceView: true, offset: 50)
        #expect(tagModifier.hidesSourceView == true)
        #expect(tagModifier.offset == 50)
    }
}
