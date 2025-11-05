//
//  ModelContainerClient.swift
//  Domain
//
//  Created by Y on 11/5/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation
import SwiftData

public protocol ModelContainerClient {
    static func create(schemas: [any PersistentModel.Type]) -> ModelContainer
}
