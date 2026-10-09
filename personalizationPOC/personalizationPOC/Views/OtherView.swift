//
//  OtherView.swift
//  personalizationPOC
//
//  Created by Paulo Henrique Costa Alves on 09/10/26.
//

import SwiftUI

struct OtherView: View {
    @Binding var currentTheme: DesignSystem.Themes
    
    var body: some View {
        VStack {
            VStack {
                Picker("Theme", selection: $currentTheme) {
                    ForEach(DesignSystem.Themes.allCases) { theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }
                .tint(.primary)
                .onChange(of: currentTheme) { _, newTheme in
                    UIApplication.shared.setAlternateIconName(newTheme == .first ? nil : newTheme.icon) { error in
                        if let error {
                            print("Erro ao trocar de ícone: \(error)")
                        }
                    }
                }
                
                MyButton(text: "Olha esse botão primário", color: currentTheme.primary)
                    .typography(style: .button, theme: currentTheme)
                
                MyButton(text: "Olha esse botão secundário", color: currentTheme.second)
                    .typography(style: .button, theme: currentTheme)
                
                MyButton(text: "Olha esse botão terciário", color: currentTheme.third)
                    .typography(style: .button, theme: currentTheme)
                
                MyButton(text: "Olha esse botão quaternário", color: currentTheme.four)
                    .typography(style: .button, theme: currentTheme)
                
                MyButton(text: "Olha esse botão (quinto)", color: currentTheme.five)
                    .typography(style: .button, theme: currentTheme)
                
                
                Spacer()
                
                Text("Olha esse title!")
                    .typography(style: .title, theme: currentTheme)
                Text("Olha esse body!")
                    .typography(style: .body, theme: currentTheme)
                Text("Olha esse caption!")
                    .typography(style: .caption, theme: currentTheme)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .hideStatusBar(true)
        .overlay(alignment: .top) {
            newStatusBar(theme: $currentTheme)
                .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    @Previewable @State var currentTheme: DesignSystem.Themes = .first
    OtherView(currentTheme: $currentTheme)
}
