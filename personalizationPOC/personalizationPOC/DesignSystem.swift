//
//  DesignSystem.swift
//  personalizationPOC
//
//  Created by Paulo Henrique Costa Alves on 07/10/26.
//

import Foundation
import SwiftUI

enum DesignSystem {
    enum Themes: String, CaseIterable, Identifiable {
        var id: Self { self }
        
        case first
        case second
        case third
        case four
        case fifth
        
        var fontName: String {
            switch self {
            case .first: return "BitcountInk-Regular"
            case .second: return "ComicSansMS"
            case .third: return "Isometra-Regular"
            case .four: return "LibreCaslonCondensed-Regular"
            case .fifth: return "Roboto-Regular"
            }
        }
        
        var icon: String {
            switch self {
            case .first:
                return "iconOne"
            case .second:
                return "iconTwo"
            case .third:
                return "iconThree"
            case .four:
                return "iconFour"
            case .fifth:
                return "iconFive"
            }
        }
        
        // Dedicated gradient-stop assets per theme (ThemeX/XGradientStart & XGradientEnd),
        // picked from each palette's darkest and lightest colors.
        var backgroundGradient: LinearGradient {
            let colors: [Color]
            switch self {
            case .first:
                colors = [Color(.oneGradientStart), Color(.oneGradientEnd)]
            case .second:
                colors = [Color(.twoGradientStart), Color(.twoGradientEnd)]
            case .third:
                colors = [Color(.threeGradientStart), Color(.threeGradientEnd)]
            case .four:
                colors = [Color(.fourGradientStart), Color(.fourGradientEnd)]
            case .fifth:
                colors = [Color(.fiveGradientStart), Color(.fiveGradientEnd)]
            }
            return LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
        }
        
        var primary: Color {
            switch self {
            case .first:
                return Color(.onePrimary)
            case .second:
                return Color(.twoPrimary)
            case .third:
                return Color(.threePrimary)
            case .four:
                return Color(.fourPrimary)
            case .fifth:
                return Color(.fivePrimary)
            }
        }
        
        var second: Color {
            switch self {
            case .first:
                return Color(.oneSecondary)
            case .second:
                return Color(.twoSecondary)
            case .third:
                return Color(.threeSecondary)
            case .four:
                return Color(.fourSecondary)
            case .fifth:
                return Color(.fiveFifth)
            }
        }
        
        var third: Color {
            switch self {
            case .first:
                return Color(.oneThird)
            case .second:
                return Color(.twoThird)
            case .third:
                return Color(.threeThird)
            case .four:
                return Color(.fourThird)
            case .fifth:
                return Color(.fiveThird)
            }
        }
        
        var four: Color {
            switch self {
            case .first:
                return Color(.oneFourth)
            case .second:
                return Color(.twoFourth)
            case .third:
                return Color(.threeFourth)
            case .four:
                return Color(.fourFourth)
            case .fifth:
                return Color(.fiveFourth)
            }
        }
        
        var five: Color {
            switch self {
            case .first:
                return Color(.oneFifth)
            case .second:
                return Color(.twoFifth)
            case .third:
                return Color(.threeFifth)
            case .four:
                return Color(.fourFifth)
            case .fifth:
                return Color(.fiveFifth)
            }
        }
    }
    
    enum Typography {
        case title
        case body
        case button
        case caption
        
        func font(for theme: Themes) -> Font {
            switch self {
            case .title: return .custom(theme.fontName, size: 28, relativeTo: .title)
            case .body: return .custom(theme.fontName, size: 16, relativeTo: .body)
            case .button: return .custom(theme.fontName, size: 16, relativeTo: .headline)
            case .caption: return .custom(theme.fontName, size: 12, relativeTo: .caption)
            }
        }
    }
}

// TODO: Estudar isso melhor.
struct TypographyModifier: ViewModifier {
    let style: DesignSystem.Typography
    let theme: DesignSystem.Themes
    
    func body(content: Content) -> some View {
        content
            .font(style.font(for: theme))
    }
}

extension View {
    func typography(style: DesignSystem.Typography, theme: DesignSystem.Themes) -> some View {
        modifier(TypographyModifier(style: style, theme: theme))
    }
}
