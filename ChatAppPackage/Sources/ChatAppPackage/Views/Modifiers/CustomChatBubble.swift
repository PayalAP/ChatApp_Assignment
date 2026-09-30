//
//  File.swift
//  ChatAppPackage
//
//  Created by Payal on 30/09/26.
//

import SwiftUI

struct CustomChatBubble: ViewModifier {
    var role: Role
    func body(content: Content) -> some View {
        content
            .background( role == .user ? Color.blue : Color.gray)
            .foregroundStyle(role == .user ? .white : .primary)
    }
}
