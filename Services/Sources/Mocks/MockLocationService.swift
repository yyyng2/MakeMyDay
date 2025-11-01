//
//  MockLocationService.swift
//  Services
//
//  Created by Y on 5/30/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import CoreLocation
import Domain

public class MockLocationService: LocationServiceImpl {
    public var shouldThrowPermissionError = false
    public var shouldThrowLocationError = false
    public var mockLocation: CLLocation?
    public var permissionDelay: TimeInterval = 0.1
    public var locationDelay: TimeInterval = 0.1
    
    public init() {
        mockLocation = CLLocation(latitude: 37.5665, longitude: 126.9780)
    }
    
    public func requestLocationPermission() async throws {
        try await Task.sleep(nanoseconds: UInt64(permissionDelay * 1_000_000_000))
        
        if shouldThrowPermissionError {
            throw WeatherError.locationPermissionDenied
        }
    }
    
    public func getCurrentLocation() async throws -> CLLocation {
        try await Task.sleep(nanoseconds: UInt64(locationDelay * 1_000_000_000))
        
        if shouldThrowLocationError {
            throw WeatherError.locationTimeout
        }
        
        guard let location = mockLocation else {
            throw WeatherError.locationNotAvailable
        }
        
        return location
    }
    
    public func setMockLocation(latitude: Double, longitude: Double) {
        mockLocation = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    public func simulatePermissionDenied() {
        shouldThrowPermissionError = true
    }
    
    public func simulateLocationTimeout() {
        shouldThrowLocationError = true
    }
    
    public func reset() {
        shouldThrowPermissionError = false
        shouldThrowLocationError = false
        mockLocation = CLLocation(latitude: 37.5665, longitude: 126.9780)
        permissionDelay = 0.1
        locationDelay = 0.1
    }
}
