//
//  File.swift
//  ChatAppPackage
//
//  Created by Payal on 30/09/26.
//

import SwiftUI

public struct ChatView: View {
    @State private var viewModel: ChatViewModel
    @State private var inputText = ""
    
    public init(service: ChatServiceProtocol){
        _viewModel = State(initialValue: ChatViewModel(chatService: service))
    }
    
    public var body: some View {
        VStack {
            messageList
            inputBar
        }
    }

    private var messageList: some View {
        ScrollView {
            LazyVStack(spacing: 12) { 
                ForEach(viewModel.messages) { message in
                    HStack {
                        if message.role == .user { Spacer() }
                        Text(message.text)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .modifier(CustomChatBubble(role: message.role))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        if message.role == .assistant { Spacer() }

                    }
                    .padding(10)
                }
            }
        }
    }
    
    private var inputBar: some View {
        HStack(spacing: 8) { 
            TextField("Type...", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(Color.gray)
            if viewModel.isStreaming {
                Button("Stop") {
                    viewModel.cancelStreaming()
                } 
                .modifier(CustomButtonModifier(forgroundColor: Color.white, backgroundColor: Color.red))
            } else {
                Button("Send") {
                    sendMessage()
                } .disabled(inputText
                        .trimmingCharacters(
                            in: .whitespacesAndNewlines
                        )
                        .isEmpty
                )
                .modifier(CustomButtonModifier(forgroundColor: Color.white, backgroundColor: Color.blue))
            }
        }
        .padding()
    }
    
    private func sendMessage() {
        let text = inputText
        inputText = ""
        viewModel.sendMessage(text)
    }
}



