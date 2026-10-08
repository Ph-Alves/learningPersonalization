//
//  DesignSystem.swift
//  personalizationPOC
//
//  Created by Paulo Henrique Costa Alves on 07/10/26.
//

import Foundation
import SwiftUI

enum Themes: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case first
    case second
    case third
    case four
    case fifth
    
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
    
    // Ordered dark -> light by measured luminance of each theme's own palette,
    // so the gradient reads as smooth and cohesive instead of jumping between shades.
    var background: [Color] {
        switch self {
        case .first:
            return [Color(.oneFifth), Color(.onePrimary), Color(.oneFourth), Color(.oneSecondary), Color(.oneThird)]
        case .second:
            return [Color(.twoThird), Color(.twoFourth), Color(.twoPrimary), Color(.twoFifth), Color(.twoSecondary)]
        case .third:
            return [Color(.threeFifth), Color(.threeFourth), Color(.threeThird), Color(.threeSecondary), Color(.threePrimary)]
        case .four:
            return [Color(.fourPrimary), Color(.fourSecondary), Color(.fourThird), Color(.fourFourth), Color(.fourFifth)]
        case .fifth:
            return [Color(.fivePrimary), Color(.fiveSecondary), Color(.fiveThird), Color(.fiveFourth), Color(.fiveFifth)]
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
            return Color(.oneSecondary)
        case .third:
            return Color(.oneThird)
        case .four:
            return Color(.oneFourth)
        case .fifth:
            return Color(.oneFifth)
        }
    }
    
    var second: Color {
        switch self {
        case .first:
            return Color(.twoPrimary)
        case .second:
            return Color(.twoSecondary)
        case .third:
            return Color(.twoThird)
        case .four:
            return Color(.twoFourth)
        case .fifth:
            return Color(.twoFifth)
        }
    }
    
    var third: Color {
        switch self {
        case .first:
            return Color(.threePrimary)
        case .second:
            return Color(.threeSecondary)
        case .third:
            return Color(.threeThird)
        case .four:
            return Color(.threeFourth)
        case .fifth:
            return Color(.threeFifth)
        }
    }
    
    var four: Color {
        switch self {
        case .first:
            return Color(.fourPrimary)
        case .second:
            return Color(.fourSecondary)
        case .third:
            return Color(.fourThird)
        case .four:
            return Color(.fourFourth)
        case .fifth:
            return Color(.fourFifth)
        }
    }
    
    var five: Color {
        switch self {
        case .first:
            return Color(.fivePrimary)
        case .second:
            return Color(.fiveSecondary)
        case .third:
            return Color(.fiveThird)
        case .four:
            return Color(.fiveFourth)
        case .fifth:
            return Color(.fiveFifth)
        }
    }
}
