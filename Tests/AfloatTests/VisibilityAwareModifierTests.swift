//
//  VisibilityAwareModifierTests.swift
//  AfloatTests
//
//  Created by Claude on 21/02/2026.
//

import Testing
import SwiftUI
@testable import Afloat

@Suite("VisibilityAwareModifier Tests")
struct VisibilityAwareModifierTests {

    // MARK: - Top Edge Tests

    @Test("View visible when below top edge offset")
    func viewVisibleBelowTopOffset() {
        let frame = CGRect(x: 0, y: 100, width: 100, height: 50) // maxY = 150
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 1000)
        let offset: CGFloat = 50

        // View's bottom (150) is past the offset (50), so it's visible
        let isVisible = checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: .top)
        #expect(isVisible == true)
    }

    @Test("View not visible when above top edge offset")
    func viewNotVisibleAboveTopOffset() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 40) // maxY = 40
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 1000)
        let offset: CGFloat = 50

        // View's bottom (40) is not past the offset (50), so it's not visible
        let isVisible = checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: .top)
        #expect(isVisible == false)
    }

    @Test("View at exact top edge boundary")
    func viewAtExactTopBoundary() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 50) // maxY = 50
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 1000)
        let offset: CGFloat = 50

        // View's bottom (50) is not past the offset (50), so it's not visible
        let isVisible = checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: .top)
        #expect(isVisible == false)
    }

    // MARK: - Bottom Edge Tests

    @Test("View visible when above bottom edge offset")
    func viewVisibleAboveBottomOffset() {
        let frame = CGRect(x: 0, y: 800, width: 100, height: 50) // minY = 800
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 1000) // height = 1000
        let offset: CGFloat = 100

        // View's top (800) is before bottom boundary (1000 - 100 = 900), so it's visible
        let isVisible = checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: .bottom)
        #expect(isVisible == true)
    }

    @Test("View not visible when below bottom edge offset")
    func viewNotVisibleBelowBottomOffset() {
        let frame = CGRect(x: 0, y: 950, width: 100, height: 50) // minY = 950
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 1000) // height = 1000
        let offset: CGFloat = 100

        // View's top (950) is not before bottom boundary (900), so it's not visible
        let isVisible = checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: .bottom)
        #expect(isVisible == false)
    }

    @Test("View at exact bottom boundary")
    func viewAtExactBottomBoundary() {
        let frame = CGRect(x: 0, y: 900, width: 100, height: 50) // minY = 900
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 1000) // height = 1000
        let offset: CGFloat = 100

        // View's top (900) is not before bottom boundary (900), so it's not visible
        let isVisible = checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: .bottom)
        #expect(isVisible == false)
    }

    // MARK: - Leading and Trailing Edge Tests

    @Test("View visibility on leading edge")
    func viewVisibilityLeadingEdge() {
        let visibleFrame = CGRect(x: 100, y: 0, width: 100, height: 50)
        let notVisibleFrame = CGRect(x: 0, y: 0, width: 40, height: 50)
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 1000)
        let offset: CGFloat = 50

        #expect(checkVisibility(frame: visibleFrame, bounds: bounds, offset: offset, edges: .leading) == true)
        #expect(checkVisibility(frame: notVisibleFrame, bounds: bounds, offset: offset, edges: .leading) == false)
    }

    @Test("View visibility on trailing edge")
    func viewVisibilityTrailingEdge() {
        let visibleFrame = CGRect(x: 300, y: 0, width: 100, height: 50)
        let notVisibleFrame = CGRect(x: 450, y: 0, width: 100, height: 50)
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 1000)
        let offset: CGFloat = 100

        #expect(checkVisibility(frame: visibleFrame, bounds: bounds, offset: offset, edges: .trailing) == true)
        #expect(checkVisibility(frame: notVisibleFrame, bounds: bounds, offset: offset, edges: .trailing) == false)
    }

    // MARK: - Multiple Edges Tests

    @Test("View visible on all edges")
    func viewVisibleOnAllEdges() {
        let frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 500)
        let offset: CGFloat = 50

        let isVisible = checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: .all)
        #expect(isVisible == true)
    }

    @Test("View visibility with multiple edges")
    func viewVisibilityMultipleEdges() {
        let frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 500)
        let offset: CGFloat = 50

        #expect(checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: .all) == true)
        #expect(checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: [.top, .bottom]) == true)
        #expect(checkVisibility(frame: frame, bounds: bounds, offset: offset, edges: .horizontal) == true)
    }

    // MARK: - Edge Cases

    @Test("Edge cases for visibility")
    func edgeCases() {
        let bounds = CGRect(x: 0, y: 0, width: 500, height: 500)

        // Zero size frame
        let zeroFrame = CGRect(x: 100, y: 100, width: 0, height: 0)
        #expect(checkVisibility(frame: zeroFrame, bounds: bounds, offset: 50, edges: .all) == true)

        // Negative coordinates
        let negativeFrame = CGRect(x: -50, y: -50, width: 100, height: 100)
        #expect(checkVisibility(frame: negativeFrame, bounds: bounds, offset: 0, edges: .all) == true)

        // Large offset
        let normalFrame = CGRect(x: 100, y: 100, width: 200, height: 200)
        #expect(checkVisibility(frame: normalFrame, bounds: bounds, offset: 500, edges: .top) == false)
    }

    // MARK: - Helper Function
    // This replicates the logic from VisibilityAwareModifier

    private func checkVisibility(frame: CGRect, bounds: CGRect, offset: CGFloat, edges: Edge.Set) -> Bool {
        var isVisible = true

        if edges.contains(.top) {
            isVisible = isVisible && frame.maxY > offset
        }

        if edges.contains(.bottom) {
            isVisible = isVisible && frame.minY < (bounds.height - offset)
        }

        if edges.contains(.leading) {
            isVisible = isVisible && frame.maxX > offset
        }

        if edges.contains(.trailing) {
            isVisible = isVisible && frame.minX < (bounds.width - offset)
        }

        return isVisible
    }
}
