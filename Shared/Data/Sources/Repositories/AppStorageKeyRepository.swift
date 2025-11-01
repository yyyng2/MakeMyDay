//
//  AppStorageKeyRepository.swift
//  Data
//
//  Created by Y on 11/1/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import Domain

public final class AppStorageKeyRepository: AppStorageKeyRepositoryProtocol {
    private let storage = UserDefaults.standard
    
    public init() {}
    
    public func get<T>(_ key: AppStorageKey, defaultValue: T) -> T {
        storage.object(forKey: key.rawValue) as? T ?? defaultValue
    }
    
    public func set<T>(_ key: AppStorageKey, value: T) {
        storage.set(value, forKey: key.rawValue)
    }
}
