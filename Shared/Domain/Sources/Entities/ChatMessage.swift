//
//  ChatMessage.swift
//  Domain
//
//  Created by Y on 5/30/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import Foundation

public struct ChatMessage: Equatable, Identifiable {
    public let id: UUID
    public let text: String
    public let isUser: Bool
    
    public init(id: UUID, text: String, isUser: Bool) {
        self.id = id
        self.text = text
        self.isUser = isUser
    }
}
