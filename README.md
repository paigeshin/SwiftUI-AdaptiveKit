# SwiftUI-AdaptiveKit

Here are comprehensive examples of how to use the refactored AdaptiveKit with SwiftUI views:Here are the key usage patterns demonstrated:

## 1. **Numeric Extensions** (`.h` and `.w`)
```swift
// Height-based scaling (most common)
spacing: 24.h
font(.system(size: 40.h))
cornerRadius: 12.h

// Width-based scaling
spacing: 16.w
GridItem(.adaptive(minimum: 150.w))
```

## 2. **Text Modifiers**
```swift
// System font
Text("Hello").adaptiveFontSize(18)

// Custom font
Text("Title").adaptiveFontSize(custom: "Helvetica-Bold", 24)

// Line spacing
Text("Long text...").adaptiveLineSpacing(4)
```

## 3. **Frame Modifiers**
```swift
// Fixed size
.adaptiveFrame(width: 300, height: 100)
.adaptiveWidth(250)
.adaptiveHeight(80)

// Flexible constraints
.adaptiveFrame(
    minWidth: 200,
    maxWidth: 400,
    minHeight: 100,
    maxHeight: 200
)
```

## 4. **Padding Modifiers**
```swift
// All edges
.adaptivePadding(20)

// Specific edges
.adaptivePadding(.horizontal, 24)
.adaptivePadding(.vertical, 12)
```

## 5. **Spacing Functions**
```swift
// In VStack/HStack
VStack(spacing: adaptiveSpacing(base: .height, 20))
HStack(spacing: 16.w)

// Manual calculation
let spacing = adaptiveVSpacing(16)
```

## 6. **Common Patterns**
- Use `.h` for most values (height-based scaling is default)
- Use `.w` for horizontal spacing and grid layouts
- Combine adaptive and non-adaptive values as needed
- Works seamlessly with SwiftUI's built-in modifiers

The beauty of this system is that it maintains the exact same API while providing better performance and cleaner code structure!
