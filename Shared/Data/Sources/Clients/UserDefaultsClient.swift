//
//  UserDefaultsClient.swift
//  Data
//
//  Created by Y on 5/24/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import Domain

public struct UserDefaultsClient {
    public var getBool: @Sendable (UserDefaultsKey) -> Bool
    public var setBool: @Sendable (UserDefaultsKey, Bool) -> Void
    public var getString: @Sendable (UserDefaultsKey) -> String
    public var setString: @Sendable (UserDefaultsKey, String) -> Void
    public var getData: @Sendable (UserDefaultsKey) -> Data?
    public var setData: @Sendable (UserDefaultsKey, Data?) -> Void
    
    public init(
        getBool: @Sendable @escaping (UserDefaultsKey) -> Bool,
        setBool: @Sendable @escaping (UserDefaultsKey, Bool) -> Void,
        getString: @Sendable @escaping (UserDefaultsKey) -> String,
        setString: @Sendable @escaping (UserDefaultsKey, String) -> Void,
        getData: @Sendable @escaping (UserDefaultsKey) -> Data?,
        setData: @Sendable @escaping (UserDefaultsKey, Data?) -> Void
    ) {
        self.getBool = getBool
        self.setBool = setBool
        self.getString = getString
        self.setString = setString
        self.getData = getData
        self.setData = setData
    }
}
