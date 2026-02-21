<div align="center">
  <img width="128" height="128" src="./Sources/Afloat/Afloat.docc/Resources/Icon.png" alt="Afloat Icon">
  <h1><b>Afloat</b></h1>
  <p>
    Contextual navigation titles that animate based on scroll position for SwiftUI.
  </p>
</div>

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-6.3+-F05138?logo=swift&logoColor=white" alt="Swift 6.3+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/iOS-26+-000000?logo=apple" alt="iOS 26+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/macOS-26+-000000?logo=apple" alt="macOS 26+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/visionOS-26+-000000?logo=apple" alt="visionOS 26+"></a>
</p>


## Overview

Afloat provides dynamic navigation titles and subtitles that respond to scroll events in SwiftUI. Perfect for list-based interfaces where you want the navigation bar to display context about what the user is viewing.

- **Contextual Navigation** — Titles and subtitles that change as users scroll
- **Native Look & Feel** — Animations match iOS's default behavior
- **Cross-Platform** — iOS, macOS, and visionOS
- **SwiftUI Native** — Drop-in replacements for standard modifiers


## Installation

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/Afloat.git", from: "1.0.0")
]
```


## Usage

```swift
import Afloat

NavigationStack {
    ScrollView {
        ForEach(sections) { section in
            SectionHeader(section)
                .navigationTitle(.contextual, section.name)
                .navigationSubtitle(.contextual, "\(section.items.count) items")
        }
    }
    .contextualNavigation(defaultTitle: "All Sections")
}
```

### Navigation Styles

```swift
// Standard SwiftUI behavior
.navigationTitle(.automatic, "Settings")

// Contextual with default settings
.navigationTitle(.contextual, "Section Title")

// Contextual with custom transition
.navigationTitle(
    .contextual(hidesSourceView: true, offset: 20),
    "Section Title"
)
```

**Parameters:**
- `hidesSourceView` — Fade out source view as it passes under the toolbar
- `offset` — Additional offset before title appears (positive = later, negative = earlier)


## Example

See the complete [RecipeBookExample](Afloat/Sources/Afloat/Examples/RecipeBookExample.swift) for a working implementation.


## Documentation

Full API reference and guides are available in the DocC documentation.


## License

MIT. See LICENSE for details.
