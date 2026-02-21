# Configure Your App's Navigation Titles

Create dynamic, scroll-responsive navigation titles that update as users scroll through content.

## Overview

Afloat extends SwiftUI's navigation system with contextual titles that automatically change based on scroll position. Perfect for showing users which section or item they're currently viewing.

## Quick Start

Add contextual navigation with two modifiers:

1. Apply ``SwiftUICore/View/contextualNavigation(defaultTitle:defaultSubtitle:)-(Text?,_)`` to your scroll container
2. Apply ``SwiftUICore/View/navigationTitle(_:_:)-(_,S)`` with ``NavigationStyle/contextual`` to header views

```swift
NavigationStack {
    ScrollView {
        ForEach(items) { item in
            Text(item.name)
                .font(.headline)
                .navigationTitle(.contextual, item.name)
            
            Text(item.details)
        }
    }
    .contextualNavigation(defaultTitle: "My Items")
}
```

As users scroll, the navigation bar displays the name of the item at the top.

## Navigation Styles

### Automatic

Standard SwiftUI navigation behavior:

```swift
.navigationTitle(.automatic, "Settings")
```

### Contextual

Dynamic, scroll-responsive titles:

```swift
// Basic
.navigationTitle(.contextual, "Section Title")

// With options
.navigationTitle(
    .contextual(hidesSourceView: true, offset: 20),
    "Section Title"
)
```

**Parameters:**
- `hidesSourceView` - Fades out the source view as it scrolls under the toolbar
- `offset` - Offset in points before the title appears (positive = later, negative = earlier)

## Titles and Subtitles

Combine titles and subtitles for more context:

```swift
ForEach(messages) { message in
    MessageView(message)
        .navigationTitle(.contextual, message.sender)
        .navigationSubtitle(.contextual, message.timestamp)
}
```

Set defaults for when no contextual content is visible:

```swift
.contextualNavigation(
    defaultTitle: "Messages",
    defaultSubtitle: "All Conversations"
)
```

## Best Practices

Apply contextual navigation modifiers to the specific header view, not to containers. The modifier triggers when the view scrolls past the top edge. Applying it to a large container delays the title change until the entire container scrolls past.

> Warning: When using `ForEach`, ensure your items conform to `Identifiable` to maintain stable view identity. This ensures navigation titles persist correctly as items scroll in and out of view with `LazyVStack` or `LazyHStack`.

### Apply to Header Views

```swift
ForEach(sections) { section in
    VStack(alignment: .leading) {
        // Apply to the header
        Text(section.title)
            .font(.title)
            .navigationTitle(.contextual, section.title)
        
        ForEach(section.items) { item in
            ItemView(item)
        }
    }
}
```

### Don't Apply to Containers

```swift
ForEach(sections) { section in
    VStack(alignment: .leading) {
        Text(section.title)
        ForEach(section.items) { item in
            ItemView(item)
        }
    }
    // Don't apply to the container
    .navigationTitle(.contextual, section.title)
}
```

### Fine-Tune Transition Timing

```swift
// Appear earlier
.navigationTitle(.contextual(offset: 50), "Title")

// Appear later
.navigationTitle(.contextual(offset: -20), "Title")
```

### Create Smooth Transitions

Enable `hidesSourceView` when the source view looks similar to the navigation title:

```swift
Text("Section A")
    .font(.title)
    .navigationTitle(
        .contextual(hidesSourceView: true),
        Text("Section A")
    )
```


## Complete Example

```swift
struct ContactsListView: View {
    let contactsBySection: [ContactSection]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(contactsBySection) { section in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(section.title)
                                .font(.headline)
                                .padding(.horizontal)
                                .navigationTitle(
                                    .contextual(hidesSourceView: true),
                                    section.title
                                )
                            
                            ForEach(section.contacts) { contact in
                                ContactRow(contact)
                            }
                        }
                    }
                }
            }
            .contextualNavigation(defaultTitle: "Contacts")
        }
    }
}
```

## See Also

### Essentials
- ``NavigationStyle``
- ``SwiftUICore/View/contextualNavigation(defaultTitle:defaultSubtitle:)-(Text?,_)``

### Navigation Modifiers
- ``SwiftUICore/View/navigationTitle(_:_:)-(_,Text)``
- ``SwiftUICore/View/navigationSubtitle(_:_:)-(_,Text)``
