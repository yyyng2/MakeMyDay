//
//  String+Extensions.swift
//  Utilities
//
//  Created by Y on 10/24/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import Resources

extension String {
    public func localized() -> String {
        return String(
            localized: String.LocalizationValue(self),
            bundle: ResourcesResources.bundle
        )
    }
}
