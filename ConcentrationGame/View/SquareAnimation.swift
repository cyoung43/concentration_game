//
//  SquareAnimation.swift
//  ConcentrationGame
//
//  Created by Chris Young on 10/7/21.
//

import SwiftUI

// TO DO: Rename to rectangleAnimation
struct SquareAnimation: View {
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .opacity(0.4)
            .foregroundColor(.blue)
            .frame(width: width, height: height)
    }
}

struct SquareAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SquareAnimation(height: 250, width: 150)
    }
}
