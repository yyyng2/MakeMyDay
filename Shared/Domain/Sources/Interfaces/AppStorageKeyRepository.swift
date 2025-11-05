//
//  AppStorageKeyRepository.swift
//  Domain
//
//  Created by Y on 11/1/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation

public protocol AppStorageKeyRepository {
    func get<T>(_ key: AppStorageKey, defaultValue: T) -> T
    func set<T>(_ key: AppStorageKey, value: T)
}
