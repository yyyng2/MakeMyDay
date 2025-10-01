//
//  WeatherInfo.swift
//  Domain
//
//  Created by Y on 5/30/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation

public struct WeatherInfo: Codable, Equatable {
    public let minTemp: Double
    public let maxTemp: Double
    public let condition: String
    
    public init(minTemp: Double, maxTemp: Double, condition: String) {
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.condition = condition
    }
}
