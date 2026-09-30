//
//  File.swift
//  ChatAppPackage
//
//  Created by Payal on 30/09/26.
//

import Foundation
import Observation

@Observable
@MainActor
public final class ChatViewModel {
    
    public private(set) var messages: [ChatMessage] = []
    public private(set) var isStreaming = false
    public private(set) var errorMessage: String?
    
    private let chatService: ChatServiceProtocol
    private var streamingTask: Task<Void, Never>?
    
    public init(chatService: ChatServiceProtocol) {
        self.chatService = chatService
    }
    
    
    public func sendMessage(_ text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedText.isEmpty else {
            return
        }
        
        guard !isStreaming else {
            return
        }
        
        errorMessage = nil
        
        let userMessage = ChatMessage( text: trimmedText, role: .user)
        messages.append(userMessage)
        
        let assistantMessage = ChatMessage(text: "",role: .assistant)
        messages.append(assistantMessage)
        
        isStreaming = true
        
        streamingTask = Task {
            await streamResponse(for: trimmedText)
        }
    }
    
    
    public func cancelStreaming() { 
        streamingTask?.cancel()
        streamingTask = nil
        isStreaming = false
    }

    private func streamResponse(for text: String) async {
        defer {
            isStreaming = false
            streamingTask = nil
        }

        do {
            let stream = chatService.streamResponse(for: text)

            for try await chunk in stream {
                guard !Task.isCancelled else {
                    return
                }
                appendToLastAssistantMessage(chunk)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func appendToLastAssistantMessage(_ chunk: String) {
        guard let index = messages.lastIndex(
            where: { $0.role == .assistant }
        ) else {
            return
        }

        let currentMessage = messages[index]

        messages[index] = ChatMessage(
            id: currentMessage.id,
            text: currentMessage.text + chunk,
            role: .assistant
        )
    }

}


