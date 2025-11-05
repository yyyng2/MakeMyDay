//
//  AssetImageProviderImpl.swift
//  Services
//
//  Created by Y on 11/6/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Domain

public final class AssetImageProviderImpl: AssetImageProvider {
    public init() {}
    
    public func image(asset: AssetImage) -> UIImage {
        switch asset {
        case .baseBackground:
            AssetImage.baseBackground.image
        case .splashIcon:
            AssetImage.splashIcon.image
        case .calendar:
            AssetImage.calendar.image
        case .dIcon:
            AssetImage.dIcon.image
        case .dDayTabSelect:
            AssetImage.dDayTabSelect.image
        case .dDayTabUnselect:
            AssetImage.dDayTabUnselect.image
        case .homeTabSelect:
            AssetImage.homeTabSelect.image
        case .homeTabUnselect:
            AssetImage.homeTabUnselect.image
        case .scheduleTabSelect:
            AssetImage.scheduleTabSelect.image
        case .scheduleTabUnselect:
            AssetImage.scheduleTabUnselect.image
        case .settingsTabSelect:
            AssetImage.settingsTabSelect.image
        case .settingsTabUnselect:
            AssetImage.settingsTabUnselect.image
        case .themeBlack:
            AssetImage.themeBlack.image
        case .themeColor:
            AssetImage.themeColor.image
        }
    }
}
