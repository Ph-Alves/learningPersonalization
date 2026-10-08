//
//  newStatusBar.swift
//  personalizationPOC
//
//  Created by Paulo Henrique Costa Alves on 08/10/26.
//

import SwiftUI
public import Combine

struct newStatusBar: View {
    @Binding var theme: DesignSystem.Themes
    
    @State private var now = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var batteryPercent: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let level = UIDevice.current.batteryLevel
        return level < 0 ? 0 : Int(level * 100)
    }
    
    var body: some View {
        HStack {
            Text(now, format: .dateTime.hour().minute())
                .typography(style: .body, theme: theme)
            Spacer()
            Text("\(batteryPercent)")
                .typography(style: .caption, theme: theme)
                .padding()
                .overlay() {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(theme.primary, lineWidth: 2)
                }
        }
        .padding(.horizontal, 28)
        .padding(.top, 14)   // ajuste no aparelho
        .frame(maxWidth: .infinity, alignment: .top)
        .onReceive(timer) {
            now = $0
        }
    }
}

#Preview {
    @Previewable @State var currentTheme: DesignSystem.Themes = .first
    newStatusBar(theme: $currentTheme)
}
