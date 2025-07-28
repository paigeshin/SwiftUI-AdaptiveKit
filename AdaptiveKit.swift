//
//  AdaptiveKit.swift
//  BeachBody
//
//  Created by 신승현 on 9/8/24.
//

import SwiftUI

// MARK: - Screen Dimensions

#if os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

/// Current screen dimensions
public struct ScreenDimensions {
    public static var width: CGFloat = {
        #if os(watchOS)
        return WKInterfaceDevice.current().screenBounds.size.width
        #elseif os(iOS)
        return UIScreen.main.bounds.width
        #elseif os(macOS)
        return NSScreen.main?.visibleFrame.size.width ?? 430
        #endif
    }()
    
    public static var height: CGFloat = {
        #if os(watchOS)
        return WKInterfaceDevice.current().screenBounds.size.height
        #elseif os(iOS)
        return UIScreen.main.bounds.height
        #elseif os(macOS)
        return NSScreen.main?.visibleFrame.size.height ?? 932
        #endif
    }()
}

/// Standard dimensions for scaling calculations
public struct StandardDimensions {
    #if os(watchOS)
    public static var width: CGFloat = 205
    public static var height: CGFloat = 251
    #else
    public static var width: CGFloat = 430
    public static var height: CGFloat = 932
    #endif
}

// MARK: - Widget Configuration

public enum BaseWidgetSize {
    case small
    case medium
    case large
    
    public var dimensions: (width: CGFloat, height: CGFloat) {
        switch self {
        case .small:
            return (width: 170, height: 170)
        case .medium:
            return (width: 364, height: 170)
        case .large:
            return (width: 364, height: 382)
        }
    }
}

// MARK: - Base Screen

public enum BaseScreen {
    case width
    case height
}

// MARK: - AdaptiveKit

/// A utility for managing responsive layout calculations across different screen sizes
public struct AdaptiveKit {
    
    // Private to prevent instantiation
    private init() {}
    
    // MARK: - Initialization
    
    /// Initialize AdaptiveKit with custom screen and base dimensions
    /// - Parameters:
    ///   - currentScreenWidth: Current device screen width
    ///   - currentScreenHeight: Current device screen height
    ///   - baseWidth: Base width for scaling calculations
    ///   - baseHeight: Base height for scaling calculations
    public static func initialize(
        currentScreenWidth: CGFloat? = nil,
        currentScreenHeight: CGFloat? = nil,
        baseWidth: CGFloat = StandardDimensions.width,
        baseHeight: CGFloat = StandardDimensions.height
    ) {
        if let width = currentScreenWidth {
            ScreenDimensions.width = width
        }
        if let height = currentScreenHeight {
            ScreenDimensions.height = height
        }
        StandardDimensions.width = baseWidth
        StandardDimensions.height = baseHeight
    }
    
    /// Initialize AdaptiveKit for widget development
    /// - Parameters:
    ///   - currentScreenWidth: Widget width
    ///   - currentScreenHeight: Widget height
    ///   - baseWidgetSize: Base widget size for scaling
    public static func initialize(
        currentScreenWidth: CGFloat,
        currentScreenHeight: CGFloat,
        baseWidgetSize: BaseWidgetSize
    ) {
        let dimensions = baseWidgetSize.dimensions
        initialize(
            currentScreenWidth: currentScreenWidth,
            currentScreenHeight: currentScreenHeight,
            baseWidth: dimensions.width,
            baseHeight: dimensions.height
        )
    }
}

// MARK: - Scaling Functions

/// Calculate scaled value based on current and standard dimensions
/// - Parameters:
///   - base: Whether to scale based on width or height
///   - value: The value to scale
/// - Returns: Scaled value
public func adaptiveValue(base: BaseScreen = .height, _ value: CGFloat) -> CGFloat {
    switch base {
    case .width:
        return (value * ScreenDimensions.width) / StandardDimensions.width
    case .height:
        return (value * ScreenDimensions.height) / StandardDimensions.height
    }
}

/// Calculate scaled value with custom dimensions
/// - Parameters:
///   - base: Whether to scale based on width or height
///   - screenWidth: Custom screen width
///   - standardWidth: Custom standard width
///   - screenHeight: Custom screen height
///   - standardHeight: Custom standard height
///   - value: The value to scale
/// - Returns: Scaled value
public func adaptiveValue(
    base: BaseScreen = .height,
    screenWidth: CGFloat,
    standardWidth: CGFloat,
    screenHeight: CGFloat,
    standardHeight: CGFloat,
    _ value: CGFloat
) -> CGFloat {
    switch base {
    case .width:
        return (value * screenWidth) / standardWidth
    case .height:
        return (value * screenHeight) / standardHeight
    }
}

/// Scale value based on width only
public func adaptiveWidth(
    screenWidth: CGFloat,
    standardWidth: CGFloat,
    _ value: CGFloat
) -> CGFloat {
    return (value * screenWidth) / standardWidth
}

/// Scale value based on height only
public func adaptiveHeight(
    screenHeight: CGFloat,
    standardHeight: CGFloat,
    _ value: CGFloat
) -> CGFloat {
    return (value * screenHeight) / standardHeight
}

// MARK: - Legacy Support

/// Legacy function name for backward compatibility
@available(*, deprecated, renamed: "adaptiveValue")
public func resized(base: BaseScreen = .height, _ value: CGFloat) -> CGFloat {
    return adaptiveValue(base: base, value)
}
