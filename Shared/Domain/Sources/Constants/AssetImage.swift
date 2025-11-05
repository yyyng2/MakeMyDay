//
//  AssetImage.swift
//  Domain
//
//  Created by Y on 11/6/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Resources

public enum AssetImage {
    case baseBackground
    case splashIcon
    case calendar
    case dIcon
    case dDayTabSelect
    case dDayTabUnselect
    case homeTabSelect
    case homeTabUnselect
    case scheduleTabSelect
    case scheduleTabUnselect
    case settingsTabSelect
    case settingsTabUnselect
    case themeBlack
    case themeColor
    
    public var image: UIImage {
        switch self {
        case .baseBackground:
            return ResourcesAsset.Assets.baseBackground.image
        case .splashIcon:
            return ResourcesAsset.Assets.splashIcon.image
        case .calendar:
            return ResourcesAsset.Assets.calendar.image
        case .dIcon:
            return ResourcesAsset.Assets.dIcon.image
        case .dDayTabSelect:
            return ResourcesAsset.Assets.dDayTabSelect.image
        case .dDayTabUnselect:
            return ResourcesAsset.Assets.dDayTabUnselect.image
        case .homeTabSelect:
            return ResourcesAsset.Assets.homeTabSelect.image
        case .homeTabUnselect:
            return ResourcesAsset.Assets.homeTabUnselect.image
        case .scheduleTabSelect:
            return ResourcesAsset.Assets.scheduleTabSelect.image
        case .scheduleTabUnselect:
            return ResourcesAsset.Assets.scheduleTabUnselect.image
        case .settingsTabSelect:
            return ResourcesAsset.Assets.settingsTabSelect.image
        case .settingsTabUnselect:
            return ResourcesAsset.Assets.settingsTabUnselect.image
        case .themeBlack:
            return ResourcesAsset.Assets.themeBlack.image
        case .themeColor:
            return ResourcesAsset.Assets.themeColor.image
        }
    }
}
