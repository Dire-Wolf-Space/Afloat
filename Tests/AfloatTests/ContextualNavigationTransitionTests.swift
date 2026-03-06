//
//  ContextualNavigationTransitionTests.swift
//  AfloatTests
//
//  Created by Adélaïde Sky on 22/02/2026.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

import Testing
import SwiftUI
@testable import Afloat

@Suite("Contextual Navigation Transition Tests")
@MainActor
struct ContextualNavigationTransitionTests {

    // MARK: - Environment Key Tests

    @Test("Environment key has correct default value")
    func environmentKeyDefaultValue() {
        let defaultValue = ContextualNavigationTransitionKey.defaultValue

        #expect(defaultValue == .identity)
    }

    @Test("Environment values can be read and written")
    func environmentValuesReadWrite() {
        var environment = EnvironmentValues()

        #expect(environment.contextualNavigationTransition == .identity)

        environment.contextualNavigationTransition = .opacity
        #expect(environment.contextualNavigationTransition == .opacity)

        environment.contextualNavigationTransition = .numericText()
        #expect(environment.contextualNavigationTransition == .numericText())
    }
}
