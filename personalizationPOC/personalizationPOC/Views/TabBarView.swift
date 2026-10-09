//
//  TabView.swift
//  personalizationPOC
//
//  Created by Paulo Henrique Costa Alves on 09/10/26.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var currentTheme: DesignSystem.Themes
    
    @State private var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("WithAnim", systemImage: "house", value: 0) {
                ContentView(currentTheme: $currentTheme)
                    .background(currentTheme.backgroundGradient)
            }

            Tab("Without", systemImage: "xmark", value: 1) {
                OtherView(currentTheme: $currentTheme)
                    .background(currentTheme.backgroundGradient)
            }
        }
    }
}

#Preview {
    @Previewable @State var currentTheme: DesignSystem.Themes = .first
    TabBarView(currentTheme: $currentTheme)
}
