//
//  ErrorType.swift
//  Domain
//
//  Created by Y on 11/1/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation

public enum ErrorType: Error {
    case notFound(id: UUID)
    case saveFailed(underlying: Error)
    case fetchFailed(underlying: Error)
    case containerNotFound
}
