//
//  AssetColor.swift
//  Domain
//
//  Created by Y on 11/6/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Resources

public enum AssetColor {
    case AccentColor
    case baseBorder
    case baseFontColor
    case baseForeground
    
    public var color: Color {
        switch self {
        case .AccentColor:
            return ResourcesAsset.Assets.accentColor.swiftUIColor
        case .baseBorder:
            return ResourcesAsset.Assets.baseBorder.swiftUIColor
        case .baseFontColor:
            return ResourcesAsset.Assets.baseFontColor.swiftUIColor
        case .baseForeground:
            return ResourcesAsset.Assets.baseForeground.swiftUIColor
        }
    }
}
