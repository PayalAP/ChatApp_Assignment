//
//  File.swift
//  ChatAppPackage
//
//  Created by Payal on 30/09/26.
//

import Foundation

public enum Role {
    case user
    case assistant
}

public struct ChatMessage: Identifiable {
    public let id: UUID
    public let text: String
    public let role: Role
    
    public init(id: UUID = UUID(), text: String, role: Role) {
        self.id = id
        self.text = text
        self.role = role
    }
}
