//
//  MockAssetColorProviderImpl.swift
//  Services
//
//  Created by Y on 11/6/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Domain

public final class MockAssetColorProviderImpl: AssetColorProvider {
    public var stubbedColors: [AssetColor: Color] = [:]
    
    public init() {}

    public func color(asset: AssetColor) -> Color {
        if let stubbedColor = stubbedColors[asset] {
            return stubbedColor
        }
        
        return Color.white
    }
}
