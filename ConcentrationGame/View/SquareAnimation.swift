//
//  SquareAnimation.swift
//  ConcentrationGame
//
//  Created by New User on 10/7/21.
//

import SwiftUI

struct SquareAnimation: View {
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .opacity(0.4)
            .foregroundColor(.blue)
            .frame(width: 150, height: 250)
            .padding()
    }
}

struct SquareAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SquareAnimation(height: 250, width: 150)
    }
}
