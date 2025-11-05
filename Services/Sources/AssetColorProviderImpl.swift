//
//  AssetColorProviderImpl.swift
//  Services
//
//  Created by Y on 11/6/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Domain

public final class AssetColorProviderImpl: AssetColorProvider {
    public init() {}
    
    public func color(asset: AssetColor) -> Color {
        switch asset {
        case .AccentColor:
            return AssetColor.AccentColor.color
        case .baseForeground:
            return AssetColor.baseForeground.color
        case .baseBorder:
            return AssetColor.baseBorder.color
        case .baseFontColor:
            return AssetColor.baseFontColor.color
        }
    }
}
