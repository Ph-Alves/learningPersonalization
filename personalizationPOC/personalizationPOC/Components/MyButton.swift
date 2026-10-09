//
//  Button.swift
//  personalizationPOC
//
//  Created by Paulo Henrique Costa Alves on 07/10/26.
//

import SwiftUI

struct MyButton: View {
    let text: String
    let color: Color
    
    var body: some View {
        VStack {
            Button(action: {}, label: {
                Text(text)
            })
            .padding()
            .tint(.white)
            .background(color)
//            .animation(.easeInOut(duration: 1.0), value: color)
            .clipShape(Capsule())
            .glassEffect()
        }
    }
}

#Preview {
    MyButton(text: "teste", color: .primary)
}
