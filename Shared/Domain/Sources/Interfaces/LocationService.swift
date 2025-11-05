//
//  LocationService.swift
//  Domain
//
//  Created by Y on 5/30/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import CoreLocation

public protocol LocationService {
    func requestLocationPermission() async throws
    func getCurrentLocation() async throws -> CLLocation
}
