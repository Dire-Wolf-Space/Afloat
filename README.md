<div align="center">
  <img width="128" height="128" src="Afloat/Sources/Afloat/Afloat.docc/Resources/Icon.png" alt="Afloat Icon">
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

Afloat provides a powerful yet simple API for creating dynamic navigation titles and subtitles that respond to scroll events in your SwiftUI views. Perfect for list-based interfaces where you want the navigation bar to display context about what the user is currently viewing.

**Key Features:**

- **Contextual Navigation** — Display titles and subtitles that change as users scroll through content
- **Native Look & Feel** — Animations and layouts match perfectly iOS's default behavior
- **Cross-Platform** — Works seamlessly on iOS, macOS, and visionOS
- **SwiftUI Native** — Designed with SwiftUI patterns and conventions
- **Easy Integration** — Drop-in replacements for standard `navigationTitle` and `navigationSubtitle` modifiers


## Installation

Add Afloat to your Swift package dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/Afloat.git", from: "1.0.0")
]
```

Then add it to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: ["Afloat"]
)
```


## Usage

### Basic Setup

```swift
import SwiftUI
import Afloat

NavigationStack {
    ScrollView {
        ForEach(sections) { section in
            SectionView(section)
                .navigationTitle(.contextual, section.name)
        }
    }
    .contextualNavigation(defaultTitle: "All Sections")
}
```

The navigation title automatically updates to show the section name as users scroll through your content.

### With Subtitles

Add contextual subtitles to provide additional information:

```swift
CategoryHeader(category: category)
    .navigationTitle(.contextual, category.name)
    .navigationSubtitle(.contextual, "\(category.items.count) items")
```

### Navigation Styles

Afloat provides three navigation styles:

#### Automatic
Standard SwiftUI navigation behavior:
```swift
.navigationTitle(.automatic, "Settings")
```

#### Contextual
Dynamic titles that update based on scroll position:
```swift
.navigationTitle(.contextual, "Section Title")
```

#### Contextual with Options
Fine-grained control over transition behavior:
```swift
.navigationTitle(
    .contextual(hidesSourceView: true, offset: 20),
    "Section Title"
)
```

**Parameters:**
- `hidesSourceView`: When `true`, the source view fades out as it passes under the toolbar
- `offset`: Additional offset in points before the title appears (positive = later, negative = earlier)


## Complete Example

Here's a recipe book app demonstrating contextual navigation:

```swift
struct RecipeBookExample: View {
    let recipeCategories = RecipeCategory.sampleData

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(recipeCategories) { category in
                        Section {
                            ForEach(category.recipes) { recipe in
                                RecipeRow(recipe: recipe)
                            }
                        } header: {
                            CategoryHeader(category: category)
                        }
                    }
                }
            }
            .contextualNavigation(defaultTitleKey: "Recipe Book")
        }
    }
}

struct CategoryHeader: View {
    let category: RecipeCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(category.name)
                .font(.title2)
                .fontWeight(.bold)
                .navigationTitle(.contextual(hidesSourceView: true), category.name)
                .navigationSubtitle(.contextual, "\(category.recipes.count) recipes")

            Text(category.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
```


## API Reference

### View Modifiers

#### `navigationTitle(_:_:)`
Configures the view's title for navigation with a specific style.

```swift
func navigationTitle(_ type: NavigationStyle, _ text: Text) -> some View
func navigationTitle(_ type: NavigationStyle, _ titleKey: LocalizedStringKey) -> some View
func navigationTitle<S: StringProtocol>(_ type: NavigationStyle, _ title: S) -> some View
```

#### `navigationSubtitle(_:_:)`
Configures the view's subtitle for navigation with a specific style.

```swift
func navigationSubtitle(_ type: NavigationStyle, _ text: Text) -> some View
func navigationSubtitle(_ type: NavigationStyle, _ subtitleKey: LocalizedStringKey) -> some View
func navigationSubtitle<S: StringProtocol>(_ type: NavigationStyle, _ subtitle: S) -> some View
```

#### `contextualNavigation(defaultTitle:defaultSubtitle:)`
Sets up contextual navigation for the view hierarchy.

```swift
func contextualNavigation(defaultTitle: Text? = nil, defaultSubtitle: Text? = nil) -> some View
func contextualNavigation(defaultTitleKey: LocalizedStringKey? = nil, defaultSubtitleKey: LocalizedStringKey? = nil) -> some View
func contextualNavigation<S1: StringProtocol, S2: StringProtocol>(defaultTitle: S1? = nil, defaultSubtitle: S2? = nil) -> some View
```

### NavigationStyle

A style for configuring navigation title behavior.

#### Static Styles
- `NavigationStyle.automatic` — The system's default navigation style
- `NavigationStyle.contextual` — Contextual navigation with default settings

#### Dynamic Styles
- `NavigationStyle.contextual(hidesSourceView:offset:)` — Contextual navigation with custom transition behavior


## How It Works

Afloat uses SwiftUI's preference system and geometry tracking to monitor scroll position. When a view with a contextual navigation modifier scrolls past the top edge of the screen, its title and subtitle are collected and displayed in the navigation bar. The system automatically handles transitions between different sections as the user scrolls.

The `ContextualNavigationManager` tracks visibility states of all tagged views and determines which title should be displayed based on their position relative to the navigation bar. When a view's position crosses the threshold, the navigation title smoothly transitions to reflect the new context.


## Important Notes

- Apply the `contextualNavigation()` modifier to the root of your scrollable content (typically `ScrollView` or `List`)
- Apply `navigationTitle(.contextual, _)` to specific header views that should trigger title changes
- Don't apply the modifier to entire section containers—apply it to the specific header element
- The modifier tracks when the view scrolls past the top edge, so applying it to large containers prevents proper detection


## Platform Requirements

- iOS 26.0+
- macOS 26.0+
- visionOS 26.0+
- Swift 6.3+


## License

MIT. See LICENSE for details.


## Contact

- [Twitter](https://x.com/AetherAurelia)
- [Threads](https://www.threads.net/@aetheraurelia)
- [Bluesky](https://bsky.app/profile/aethers.world)
- [LinkedIn](https://www.linkedin.com/in/willjones24)
