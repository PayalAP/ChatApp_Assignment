//
//  File.swift
//  ChatAppPackage
//
//  Created by Payal on 30/09/26.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
    var forgroundColor: Color
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .foregroundStyle(forgroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
}
