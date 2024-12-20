//
//  LinearGradient.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 15.08.2024.
//

import SwiftUI

extension LinearGradient {
    
    public static let cgImagePlaceholder = LinearGradient(
        stops: [
            Gradient.Stop(
                color: Colors.bg4.swiftUIColor,
                location: 0
            ),
            Gradient.Stop(
                color: Colors.bg4.swiftUIColor,
                location: 1
            ),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
    
    public static let gdeBankColorsGradient = LinearGradient(
        gradient: Gradient(colors: [
            Colors.buttonPayPrimary1.swiftUIColor,
            Colors.buttonPayPrimary2.swiftUIColor,
            Colors.buttonPayPrimary3.swiftUIColor
        ]),
        startPoint: .leading,
        endPoint: .trailing
    )
}
