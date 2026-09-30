//
//  ContentView.swift
//  ChatApp_Assignment
//
//  Created by Payal on 30/09/26.
//

import SwiftUI
import ChatAppPackage

struct ContentView: View {
    var body: some View {
        ChatView(service: ChatService())
    }
}

#Preview {
    ContentView()
}
