//
//  NavigationStyleTests.swift
//  AfloatTests
//
//  Created by Claude on 21/02/2026.
//

import Testing
import Foundation
@testable import Afloat

@Suite("NavigationStyle Tests")
struct NavigationStyleTests {

    // MARK: - Automatic Style Tests

    @Test("Automatic style creates static storage")
    func automaticStyleCreatesStatic() {
        let style = NavigationStyle.automatic

        if case .static = style.storage {
            // Test passes
        } else {
            Issue.record("Expected static storage, got \(style.storage)")
        }
    }

    // MARK: - Contextual Style Tests

    @Test("Contextual style creates contextual storage with defaults")
    func contextualStyleCreatesWithDefaults() {
        let style = NavigationStyle.contextual

        if case .contextual(let hidesSourceView, let offset) = style.storage {
            #expect(hidesSourceView == false)
            #expect(offset == 0)
        } else {
            Issue.record("Expected contextual storage, got \(style.storage)")
        }
    }

    @Test("Contextual style with custom parameters")
    func contextualStyleWithCustomParameters() {
        let style = NavigationStyle.contextual(hidesSourceView: true, offset: 50)

        if case .contextual(let hidesSourceView, let offset) = style.storage {
            #expect(hidesSourceView == true)
            #expect(offset == 50)
        } else {
            Issue.record("Expected contextual storage, got \(style.storage)")
        }
    }

    // MARK: - Edge Cases

    @Test("Contextual style with negative offset")
    func contextualStyleWithNegativeOffset() {
        let style = NavigationStyle.contextual(hidesSourceView: false, offset: -25)

        if case .contextual(let hidesSourceView, let offset) = style.storage {
            #expect(hidesSourceView == false)
            #expect(offset == -25)
        } else {
            Issue.record("Expected contextual storage, got \(style.storage)")
        }
    }

    // MARK: - Storage Equatable Tests

    @Test("Storage equality and inequality")
    func storageEquality() {
        let storage1: NavigationStyle.Storage = .static
        let storage2: NavigationStyle.Storage = .static
        let storage3: NavigationStyle.Storage = .contextual(hidesSourceView: true, offset: 50)
        let storage4: NavigationStyle.Storage = .contextual(hidesSourceView: true, offset: 50)
        let storage5: NavigationStyle.Storage = .contextual(hidesSourceView: false, offset: 50)

        #expect(storage1 == storage2)
        #expect(storage3 == storage4)
        #expect(storage1 != storage3)
        #expect(storage3 != storage5)
    }
}
