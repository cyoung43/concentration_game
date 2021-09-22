//
//  CardView.swift
//  CardView
//
//  Created by New User on 9/10/21.
//

import SwiftUI

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if !card.isMatched || card.isFaceUp {
                    Pie(startAngle: Angle(degrees: 360 - 90), endAngle: Angle(degrees: 120 - 90), clockwise: true)
                        .opacity(0.4)
                    Text(card.content)
                        .font(systemFont(for: geometry.size))
                }
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    private func systemFont(for size: CGSize) -> Font {
        Font.system(size: min(size.height, size.width) * Constants.fontScaleFactor)
    }
    
    // MARK: - Drawing constants
    
    private struct Constants {
        static let fontScaleFactor = 0.75
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: ConcentrationGame<String>.Card(isFaceUp: true, isMatched: false, content: "🥝"))
            .foregroundColor(.blue)
            .padding(50)
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
