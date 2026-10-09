import SwiftUI

@main struct MyApp: App {
    
    @State var currentTheme: DesignSystem.Themes = .first
    
    var body: some Scene {
        WindowGroup {
            TabBarView(currentTheme: $currentTheme)
        }
    }
}
