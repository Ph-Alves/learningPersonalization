import SwiftUI

@main struct MyApp: App {
    
    @State var currentTheme: DesignSystem.Themes = .first
    
    var body: some Scene {
        WindowGroup {
            ContentView(currentTheme: $currentTheme)
                .background(
                    currentTheme.backgroundGradient
                )
                .animation(.easeInOut(duration: 1.0), value: currentTheme)
        }
    }
}
