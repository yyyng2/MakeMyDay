//
//  MockLocaleServiceImpl.swift
//  Services
//
//  Created by Y on 11/6/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import Domain

public final class MockLocaleServiceImpl: LocaleService {
    public var mockValues: [LocaleKey: String] = [:]
    
    public private(set) var localizedCallCount: Int = 0
    
    public private(set) var lastLocalizedKey: LocaleKey?
    
    public init() {}
    
    public func localized(forKey key: LocaleKey) -> String {
        localizedCallCount += 1
        lastLocalizedKey = key
        
        if let mockValue = mockValues[key] {
            return mockValue
        }
        
        return "Mock: \(key.rawValue)"
    }
    
    public func getKeyByRawValue(rawValue: String) -> LocaleKey? {
        return LocaleKey(rawValue: rawValue)
    }
 
    public func resetMockState() {
        localizedCallCount = 0
        lastLocalizedKey = nil
    }
}
