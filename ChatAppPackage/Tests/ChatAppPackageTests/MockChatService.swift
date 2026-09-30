//
//  File.swift
//  ChatAppPackage
//
//  Created by Payal on 30/09/26.
//

import Foundation
import ChatAppPackage


struct MockChatService: ChatServiceProtocol {
    let chunks: [String]
    
    init(chunks: [String]) {
        self.chunks = chunks
    }
    
    func streamResponse(for message: String) -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in 
            Task {
                for chunk in chunks {
                    guard !Task.isCancelled else{
                        continuation.finish()
                        return
                    }
                    try? await Task.sleep(for: .seconds(1))
                    continuation.yield(chunk)
                }
                continuation.finish()
            }
        }
    }
}
