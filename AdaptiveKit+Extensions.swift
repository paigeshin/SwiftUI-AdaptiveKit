//
//  ValueExtensions.swift
//  BeachBody
//
//  Created by 신승현 on 9/8/24.
//

import SwiftUI
import Foundation

// MARK: - Numeric Extensions for Adaptive Scaling

/// Protocol for types that can be converted to adaptive values
public protocol AdaptiveConvertible {
    var h: CGFloat { get }
    var w: CGFloat { get }
}

// MARK: - CGFloat Extension

extension CGFloat: AdaptiveConvertible {
    /// Height-based adaptive value
    public var h: CGFloat {
        adaptiveValue(base: .height, self)
    }
    
    /// Width-based adaptive value
    public var w: CGFloat {
        adaptiveValue(base: .width, self)
    }
}

// MARK: - Double Extension

extension Double: AdaptiveConvertible {
    /// Height-based adaptive value
    public var h: CGFloat {
        adaptiveValue(base: .height, CGFloat(self))
    }
    
    /// Width-based adaptive value
    public var w: CGFloat {
        adaptiveValue(base: .width, CGFloat(self))
    }
}

// MARK: - Int Extension

extension Int: AdaptiveConvertible {
    /// Height-based adaptive value
    public var h: CGFloat {
        adaptiveValue(base: .height, CGFloat(self))
    }
    
    /// Width-based adaptive value
    public var w: CGFloat {
        adaptiveValue(base: .width, CGFloat(self))
    }
}

// MARK: - View Extensions for Adaptive Layout

public extension View {
    
    // MARK: - Spacing Functions
    
    /// Calculate adaptive spacing value
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - value: Spacing value to scale
    /// - Returns: Scaled spacing value
    func adaptiveSpacing(base: BaseScreen = .height, _ value: CGFloat) -> CGFloat {
        adaptiveValue(base: base, value)
    }
    
    /// Calculate adaptive horizontal spacing (alias for adaptiveSpacing)
    func adaptiveHSpacing(base: BaseScreen = .height, _ value: CGFloat) -> CGFloat {
        adaptiveValue(base: base, value)
    }
    
    /// Calculate adaptive vertical spacing (alias for adaptiveSpacing)
    func adaptiveVSpacing(base: BaseScreen = .height, _ value: CGFloat) -> CGFloat {
        adaptiveValue(base: base, value)
    }
    
    /// Calculate spacing with explicit base dimension
    func spacing(base: BaseScreen, _ value: CGFloat) -> CGFloat {
        adaptiveValue(base: base, value)
    }
    
    // MARK: - Font Modifiers
    
    /// Apply adaptive font size with system font
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - fontSize: Font size to scale
    /// - Returns: View with adaptive font
    func adaptiveFontSize(base: BaseScreen = .height, _ fontSize: CGFloat) -> some View {
        self.font(.system(size: adaptiveValue(base: base, fontSize)))
    }
    
    /// Apply adaptive font size with custom font
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - custom: Custom font name
    ///   - fontSize: Font size to scale
    /// - Returns: View with adaptive custom font
    func adaptiveFontSize(base: BaseScreen = .height, custom: String, _ fontSize: CGFloat) -> some View {
        self.font(.custom(custom, size: adaptiveValue(base: base, fontSize)))
    }
    
    // MARK: - Padding Modifiers
    
    /// Apply adaptive padding to specific edges
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - edge: Edges to apply padding
    ///   - value: Padding value to scale
    /// - Returns: View with adaptive padding
    func adaptivePadding(base: BaseScreen = .height, _ edge: Edge.Set, _ value: CGFloat) -> some View {
        self.padding(edge, adaptiveValue(base: base, value))
    }
    
    /// Apply adaptive padding to all edges
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - value: Padding value to scale
    /// - Returns: View with adaptive padding
    func adaptivePadding(base: BaseScreen = .height, _ value: CGFloat) -> some View {
        self.padding(adaptiveValue(base: base, value))
    }
    
    // MARK: - Text Modifiers
    
    /// Apply adaptive line spacing
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - value: Line spacing value to scale
    /// - Returns: View with adaptive line spacing
    func adaptiveLineSpacing(base: BaseScreen = .height, _ value: CGFloat) -> some View {
        self.lineSpacing(adaptiveValue(base: base, value))
    }
    
    // MARK: - Frame Modifiers - Fixed Size
    
    /// Apply adaptive width
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - value: Width value to scale
    ///   - alignment: Frame alignment (default: center)
    /// - Returns: View with adaptive width
    func adaptiveWidth(base: BaseScreen = .height, _ value: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(width: adaptiveValue(base: base, value), alignment: alignment)
    }
    
    /// Apply adaptive height
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - value: Height value to scale
    ///   - alignment: Frame alignment (default: center)
    /// - Returns: View with adaptive height
    func adaptiveHeight(base: BaseScreen = .height, _ value: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(height: adaptiveValue(base: base, value), alignment: alignment)
    }
    
    /// Apply adaptive frame with fixed width and height
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - width: Width value to scale
    ///   - height: Height value to scale
    ///   - alignment: Frame alignment (default: center)
    /// - Returns: View with adaptive frame
    func adaptiveFrame(
        base: BaseScreen = .height,
        width: CGFloat,
        height: CGFloat,
        alignment: Alignment = .center
    ) -> some View {
        self.frame(
            width: adaptiveValue(base: base, width),
            height: adaptiveValue(base: base, height),
            alignment: alignment
        )
    }
    
    // MARK: - Frame Modifiers - Flexible Size
    
    /// Apply adaptive frame with flexible width constraints
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - minWidth: Minimum width constraint
    ///   - idealWidth: Ideal width constraint
    ///   - maxWidth: Maximum width constraint
    ///   - alignment: Frame alignment (default: center)
    /// - Returns: View with adaptive flexible width
    func adaptiveWidth(
        base: BaseScreen = .height,
        minWidth: CGFloat? = nil,
        idealWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        self.frame(
            minWidth: minWidth.map { adaptiveValue(base: base, $0) },
            idealWidth: idealWidth.map { adaptiveValue(base: base, $0) },
            maxWidth: maxWidth.map { adaptiveValue(base: base, $0) },
            alignment: alignment
        )
    }
    
    /// Apply adaptive frame with flexible height constraints
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - minHeight: Minimum height constraint
    ///   - idealHeight: Ideal height constraint
    ///   - maxHeight: Maximum height constraint
    ///   - alignment: Frame alignment (default: center)
    /// - Returns: View with adaptive flexible height
    func adaptiveHeight(
        base: BaseScreen = .height,
        minHeight: CGFloat? = nil,
        idealHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        self.frame(
            minHeight: minHeight.map { adaptiveValue(base: base, $0) },
            idealHeight: idealHeight.map { adaptiveValue(base: base, $0) },
            maxHeight: maxHeight.map { adaptiveValue(base: base, $0) },
            alignment: alignment
        )
    }
    
    /// Apply adaptive frame with flexible width and height constraints
    /// - Parameters:
    ///   - base: Base dimension for scaling (default: height)
    ///   - minWidth: Minimum width constraint
    ///   - idealWidth: Ideal width constraint
    ///   - maxWidth: Maximum width constraint
    ///   - minHeight: Minimum height constraint
    ///   - idealHeight: Ideal height constraint
    ///   - maxHeight: Maximum height constraint
    ///   - alignment: Frame alignment (default: center)
    /// - Returns: View with adaptive flexible frame
    func adaptiveFrame(
        base: BaseScreen = .height,
        minWidth: CGFloat? = nil,
        idealWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        idealHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        self.frame(
            minWidth: minWidth.map { adaptiveValue(base: base, $0) },
            idealWidth: idealWidth.map { adaptiveValue(base: base, $0) },
            maxWidth: maxWidth.map { adaptiveValue(base: base, $0) },
            minHeight: minHeight.map { adaptiveValue(base: base, $0) },
            idealHeight: idealHeight.map { adaptiveValue(base: base, $0) },
            maxHeight: maxHeight.map { adaptiveValue(base: base, $0) },
            alignment: alignment
        )
    }
}
