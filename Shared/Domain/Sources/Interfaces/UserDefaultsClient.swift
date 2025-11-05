//
//  UserDefaultsClient.swift
//  Domain
//
//  Created by Y on 11/5/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation

public protocol UserDefaultsClient {
    var getBool: @Sendable (UserDefaultsKey) -> Bool { get }
    var setBool: @Sendable (UserDefaultsKey, Bool) -> Void { get }
    var getString: @Sendable (UserDefaultsKey) -> String { get }
    var setString: @Sendable (UserDefaultsKey, String) -> Void { get }
    var getData: @Sendable (UserDefaultsKey) -> Data? { get }
    var setData: @Sendable (UserDefaultsKey, Data?) -> Void { get }
}
