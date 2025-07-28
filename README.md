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

# Full Example

```swift
//
//  AdaptiveKitExamples.swift
//  BeachBody
//
//  Examples of AdaptiveKit usage in SwiftUI
//

import SwiftUI

// MARK: - Basic Setup Example

struct ContentView: View {
    init() {
        // Initialize AdaptiveKit with custom base dimensions (optional)
        // Default is iPhone 14 Pro Max dimensions (430x932)
        AdaptiveKit.initialize(baseWidth: 430, baseHeight: 932)
        
        // Or for widgets:
        // AdaptiveKit.initialize(
        //     currentScreenWidth: 170,
        //     currentScreenHeight: 170,
        //     baseWidgetSize: .small
        // )
    }
    
    var body: some View {
        ExampleView()
    }
}

// MARK: - Comprehensive Usage Examples

struct ExampleView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24.h) { // Using .h extension for height-based scaling
                
                // MARK: - Text Examples
                textExamples
                
                Divider()
                    .padding(.vertical, 16.h)
                
                // MARK: - Layout Examples
                layoutExamples
                
                Divider()
                    .padding(.vertical, 16.h)
                
                // MARK: - Complex Layout Example
                complexLayoutExample
                
                Divider()
                    .padding(.vertical, 16.h)
                
                // MARK: - Card Example
                cardExample
            }
            .adaptivePadding(20) // Adaptive padding on all sides
        }
    }
    
    // MARK: - Text Examples
    
    var textExamples: some View {
        VStack(alignment: .leading, spacing: 12.h) {
            Text("Text Examples")
                .adaptiveFontSize(custom: "Helvetica-Bold", 28)
                .foregroundColor(.primary)
            
            Text("System Font with Adaptive Size")
                .adaptiveFontSize(18) // Default base is height
            
            Text("Custom Font Example")
                .adaptiveFontSize(base: .width, custom: "Georgia", 20)
            
            Text("This is a multi-line text example with adaptive line spacing applied for better readability on different screen sizes.")
                .adaptiveFontSize(16)
                .adaptiveLineSpacing(4)
                .foregroundColor(.secondary)
        }
        .adaptiveFrame(width: 350, height: 200)
        .adaptivePadding(16)
    }
    
    // MARK: - Layout Examples
    
    var layoutExamples: some View {
        VStack(spacing: adaptiveSpacing(base: .height, 20)) {
            Text("Layout Examples")
                .adaptiveFontSize(custom: "Helvetica-Bold", 24)
            
            // Fixed size adaptive frame
            Rectangle()
                .fill(Color.blue.gradient)
                .adaptiveFrame(width: 300, height: 100)
                .overlay(
                    Text("Fixed Adaptive Frame")
                        .adaptiveFontSize(16)
                        .foregroundColor(.white)
                )
            
            // Width only
            Rectangle()
                .fill(Color.green.gradient)
                .adaptiveWidth(250)
                .height(60) // Non-adaptive height
                .overlay(
                    Text("Adaptive Width Only")
                        .adaptiveFontSize(14)
                        .foregroundColor(.white)
                )
            
            // Height only  
            Rectangle()
                .fill(Color.orange.gradient)
                .width(200) // Non-adaptive width
                .adaptiveHeight(80)
                .overlay(
                    Text("Adaptive Height Only")
                        .adaptiveFontSize(14)
                        .foregroundColor(.white)
                )
            
            // Using numeric extensions
            HStack(spacing: 16.w) { // Width-based spacing
                ForEach(0..<3) { index in
                    RoundedRectangle(cornerRadius: 12.h)
                        .fill(Color.purple.gradient)
                        .adaptiveFrame(width: 90, height: 90)
                        .overlay(
                            Text("\(index + 1)")
                                .adaptiveFontSize(24)
                                .foregroundColor(.white)
                        )
                }
            }
        }
    }
    
    // MARK: - Complex Layout Example
    
    var complexLayoutExample: some View {
        VStack(alignment: .leading, spacing: 16.h) {
            Text("Complex Responsive Layout")
                .adaptiveFontSize(custom: "Helvetica-Bold", 24)
            
            // Flexible frame with min/max constraints
            RoundedRectangle(cornerRadius: 16.h)
                .fill(LinearGradient(
                    colors: [.purple, .pink],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .adaptiveFrame(
                    minWidth: 200,
                    idealWidth: 300,
                    maxWidth: 400,
                    minHeight: 100,
                    idealHeight: 150,
                    maxHeight: 200
                )
                .overlay(
                    VStack(spacing: 8.h) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 40.h))
                            .foregroundColor(.white)
                        
                        Text("Flexible Adaptive Frame")
                            .adaptiveFontSize(18)
                            .foregroundColor(.white)
                        
                        Text("Responds to different screen sizes")
                            .adaptiveFontSize(12)
                            .foregroundColor(.white.opacity(0.8))
                    }
                )
            
            // Adaptive padding with different edges
            Text("Different Padding Values")
                .adaptiveFontSize(16)
                .adaptivePadding(.horizontal, 24)
                .adaptivePadding(.vertical, 12)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8.h)
        }
    }
    
    // MARK: - Card Example
    
    var cardExample: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Card Header
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 44.h))
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading, spacing: 4.h) {
                    Text("John Doe")
                        .adaptiveFontSize(custom: "Helvetica-Bold", 18)
                    
                    Text("iOS Developer")
                        .adaptiveFontSize(14)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .font(.system(size: 20.h))
                    .foregroundColor(.secondary)
            }
            .adaptivePadding(16)
            
            // Card Image
            Rectangle()
                .fill(LinearGradient(
                    colors: [.blue, .cyan],
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .adaptiveHeight(200)
                .overlay(
                    Image(systemName: "swift")
                        .font(.system(size: 80.h))
                        .foregroundColor(.white.opacity(0.8))
                )
            
            // Card Content
            VStack(alignment: .leading, spacing: 12.h) {
                Text("SwiftUI Adaptive Layout")
                    .adaptiveFontSize(custom: "Helvetica-Bold", 20)
                
                Text("This card demonstrates various adaptive layout techniques including fonts, spacing, padding, and frames that scale proportionally across different device sizes.")
                    .adaptiveFontSize(14)
                    .adaptiveLineSpacing(2)
                    .foregroundColor(.secondary)
                
                // Action Buttons
                HStack(spacing: 16.w) {
                    Button(action: {}) {
                        Label("Like", systemImage: "heart")
                            .adaptiveFontSize(14)
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: {}) {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .adaptiveFontSize(14)
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Read More")
                            .adaptiveFontSize(14)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .adaptivePadding(.top, 8)
            }
            .adaptivePadding(16)
        }
        .background(Color(.systemBackground))
        .cornerRadius(16.h)
        .shadow(radius: 8.h, y: 4.h)
        .adaptiveFrame(
            maxWidth: 400,
            alignment: .top
        )
        .adaptivePadding(.horizontal, 20)
    }
}

// MARK: - Grid Layout Example

struct GridLayoutExample: View {
    let columns = [
        GridItem(.adaptive(minimum: 150.w), spacing: 16.w)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16.h) {
                ForEach(0..<12) { index in
                    RoundedRectangle(cornerRadius: 12.h)
                        .fill(Color.random)
                        .adaptiveHeight(120)
                        .overlay(
                            Text("Item \(index + 1)")
                                .adaptiveFontSize(16)
                                .foregroundColor(.white)
                        )
                }
            }
            .adaptivePadding(20)
        }
    }
}

// MARK: - List Example

struct ListExample: View {
    var body: some View {
        List {
            ForEach(0..<10) { index in
                HStack(spacing: 12.w) {
                    Circle()
                        .fill(Color.random)
                        .adaptiveFrame(width: 50, height: 50)
                    
                    VStack(alignment: .leading, spacing: 4.h) {
                        Text("Item \(index + 1)")
                            .adaptiveFontSize(16)
                            .fontWeight(.semibold)
                        
                        Text("Subtitle text here")
                            .adaptiveFontSize(14)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14.h))
                        .foregroundColor(.secondary)
                }
                .adaptivePadding(.vertical, 8)
            }
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: - Helper Extensions

extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

// MARK: - Preview

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // iPhone 14 Pro Max
            ExampleView()
                .previewDevice("iPhone 14 Pro Max")
                .previewDisplayName("iPhone 14 Pro Max")
            
            // iPhone SE
            ExampleView()
                .previewDevice("iPhone SE (3rd generation)")
                .previewDisplayName("iPhone SE")
            
            // iPad
            ExampleView()
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .previewDisplayName("iPad Pro")
        }
    }
}
```
