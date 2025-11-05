//
//  LocaleServiceImpl.swift
//  Services
//
//  Created by Y on 11/6/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import Domain
import Utilities

public final class LocaleServiceImpl: LocaleService {
    public init() {}
    
    public func localized(forKey key: LocaleKey) -> String {
        return key.rawValue.localized()
    }
    
    public func getKeyByRawValue(rawValue: String) -> LocaleKey? {
        return LocaleKey(rawValue: rawValue)
    }
}
