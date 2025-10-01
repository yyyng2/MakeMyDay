//
//  WeatherError.swift
//  Domain
//
//  Created by Y on 5/30/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation

public enum WeatherError: Error {
    case locationPermissionDenied
    case locationNotAvailable
    case locationTimeout
    case locationUnknown
    case locationServicesDisabled
    case locationError(Error)
    case weatherFetchFailed
}
