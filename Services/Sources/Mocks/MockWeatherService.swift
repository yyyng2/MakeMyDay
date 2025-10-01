//
//  MockWeatherService.swift
//  Services
//
//  Created by Y on 5/30/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import CoreLocation
import Domain

public class MockWeatherService: WeatherServiceProtocol {
    public init() {}
    
    public func fetchWeather(location: CLLocation) async throws -> WeatherInfo? {
        return WeatherInfo(
            minTemp: 20,
            maxTemp: 28,
            condition: "맑은"
        )
    }
}
