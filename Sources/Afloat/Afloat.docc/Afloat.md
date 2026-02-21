# ``Afloat``

A SwiftUI library for contextual navigation titles that animate based on scroll position.

## Overview

Afloat provides a powerful yet simple API for creating dynamic navigation titles and subtitles that respond to scroll events in your SwiftUI views. Perfect for list-based interfaces where you want the navigation bar to display context about what the user is currently viewing.

### Key Features

- **Contextual Navigation**: Display titles and subtitles that change as users scroll through content
- **Native look & feel**: Animations and layouts match perfectly iOS's default behavior.
- **Cross-Platform**: Works seamlessly on iOS, macOS, and visionOS
- **SwiftUI Native**: Designed with SwiftUI patterns and conventions
- **Easy Integration**: Drop-in replacements for standard `navigationTitle` and `navigationSubtitle` modifiers

## Topics

### Essentials

- <doc:Configure-Your-Apps-Navigation-Titles>

### Navigation Modifiers

- ``SwiftUICore/View/navigationTitle(_:_:)-(_,Text)``
- ``SwiftUICore/View/navigationSubtitle(_:_:)-(_,Text)``
- ``SwiftUICore/View/contextualNavigation(defaultTitle:defaultSubtitle:)-(Text?,_)``

### Utilities

- ``NavigationStyle``
- ``SwiftUICore/View/onVisibilityChanged(offset:edges:_:)``
