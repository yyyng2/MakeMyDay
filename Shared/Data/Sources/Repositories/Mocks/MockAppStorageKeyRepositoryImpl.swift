//
//  MockAppStorageKeyRepositoryImpl.swift
//  Data
//
//  Created by Y on 11/1/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import Domain

public final class MockAppStorageKeyRepositoryImpl: AppStorageKeyRepository {
    private var storage: [String: Any] = [:]
    
    public init() {}
    
    public func get<T>(_ key: AppStorageKey, defaultValue: T) -> T {
        return storage[key.rawValue] as? T ?? defaultValue
    }
    
    public func set<T>(_ key: AppStorageKey, value: T) {
        storage[key.rawValue] = value
    }
    
    // 테스트용 헬퍼 메서드
    public func clear() {
        storage.removeAll()
    }
    
    public func reset(_ key: AppStorageKey) {
        storage.removeValue(forKey: key.rawValue)
    }
}
