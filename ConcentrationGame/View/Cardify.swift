//
//  Cardify.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/22/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: Constants.cardCornerRadius).fill(.white)
                RoundedRectangle(cornerRadius: Constants.cardCornerRadius).stroke()
                content
            }
            else {
                RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
            }
        }
    }
    
    private struct Constants {
        static let cardCornerRadius = 10.0
    }
}
