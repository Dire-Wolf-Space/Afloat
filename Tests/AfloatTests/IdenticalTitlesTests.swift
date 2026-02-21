//
//  IdenticalTitlesTests.swift
//  Afloat
//
//  Created by Adélaïde Sky on 21/02/2026.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

import Testing
@testable import Afloat
import SwiftUI

@Suite("Identical Titles Tests")
struct IdenticalTitlesTests {
    
    @Test("Manager correctly handles two tags with identical text content")
    func identicalTitlesAreHandledSeparately() {
        // Create a manager
        let manager = ContextualNavigationManager()
        
        // Create two tags with identical text but different instances
        var tag1 = ContextualNavigationTag.title(Text("Identical Title"))
        var tag2 = ContextualNavigationTag.title(Text("Identical Title"))
        
        // Verify they have different IDs (each instance is unique)
        #expect(tag1.id != tag2.id)
        
        // Make both eligible
        tag1.eligible = true
        tag2.eligible = true
        
        // Process first tag
        manager.process([tag1])
        #expect(manager.title == Text("Identical Title"))
        #expect(manager.showTitle == true)
        
        // Process second tag (it should be added to the stack even with the same ID)
        manager.process([tag1, tag2])
        #expect(manager.title == Text("Identical Title"))
        #expect(manager.showTitle == true)
        
        // Now make first tag ineligible
        tag1.eligible = false
        
        // Process - the second tag should still keep the title visible
        manager.process([tag2])
        #expect(manager.showTitle == true, "Second identical title should keep title visible")
        #expect(manager.title == Text("Identical Title"))
    }
    
    @Test("Manager handles multiple identical subtitles")
    func identicalSubtitlesAreHandledSeparately() {
        let manager = ContextualNavigationManager()
        
        var sub1 = ContextualNavigationTag.subtitle(Text("Same Subtitle"))
        var sub2 = ContextualNavigationTag.subtitle(Text("Same Subtitle"))
        
        sub1.eligible = true
        sub2.eligible = true
        
        manager.process([sub1, sub2])
        #expect(manager.showSubtitle == true)
        
        // Make first ineligible
        sub1.eligible = false
        manager.process([sub2])
        
        #expect(manager.showSubtitle == true, "Second identical subtitle should keep subtitle visible")
    }
}
