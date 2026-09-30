//
//  File.swift
//  ChatAppPackage
//
//  Created by Payal on 30/09/26.
//

import Foundation

public protocol ChatServiceProtocol {
    func streamResponse(for message: String) -> AsyncThrowingStream<String, Error>
}


public final class ChatService: ChatServiceProtocol {
    
    public init() {}
    
    public func streamResponse(for message: String) -> AsyncThrowingStream<String, Error> {
        let response = generateResponse(for: message)
        return AsyncThrowingStream { continuation in            
            Task {
                for chunk in response {
                    try Task.checkCancellation()
                    try await Task.sleep(for: .seconds(1))
                    continuation.yield(chunk)
                }
                continuation.finish()
            }
        }
    }
    
    
    private func generateResponse(for message: String) -> [String] {
        [ "Thanks for your message! ", "I received your request. ","I'm processing the information ","and I'll help you with that."]
    }
    
    
}
