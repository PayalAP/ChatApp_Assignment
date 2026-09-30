import Testing
@testable import ChatAppPackage

@MainActor
@Test func sendMessageAddsUserAndAssistantMessages() async throws {
    
    let service = MockChatService(chunks: ["I am your assistant"])
    let viewModel = ChatViewModel(chatService: service)                             
    viewModel.sendMessage("Hello")
    
    #expect(viewModel.messages.count == 2)
    #expect(viewModel.messages[0].text == "Hello")
    #expect(viewModel.messages[0].role == .user)
    
    #expect(viewModel.messages[1].role == .assistant)
    #expect(viewModel.isStreaming == true)
}


@MainActor
@Test func cancelStreamStopResponse() async throws {
    let service = MockChatService(chunks: ["I am your Chat Assistant"])
    
    let viewModel = ChatViewModel(chatService: service)
    viewModel.sendMessage("hi")
    
    try await Task.sleep(for: .milliseconds(350))
    viewModel.cancelStreaming()
    #expect(viewModel.isStreaming == false)
}
