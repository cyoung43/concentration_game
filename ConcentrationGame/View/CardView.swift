//
//  CardView.swift
//  CardView
//
//  Created by New User on 9/10/21.
//

import SwiftUI

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    var theme: [String]
    // TO DO: add in var theme: String
    
    @State private var animatedBonusRemaining = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            if !card.isMatched || card.isFaceUp {
                ZStack {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: angle(for: 0), endAngle: angle(for: -animatedBonusRemaining))
                            .padding(geometry.size.width * 0.03)
                            .opacity(0.4)
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    }
                    else {
                        Pie(startAngle: angle(for: 0), endAngle: angle(for: -card.bonusRemaining))
                            .padding(geometry.size.width * 0.03)
                            .opacity(0.4)
                    }
                    // TO DO: function for the content of the theme
                    // switch on theme
                    cardBody(size: geometry.size)
                    
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    @ViewBuilder
    private func cardBody(size: CGSize) -> some View {
        // TO DO: add in theme here
        if theme[0] == "templeMatch" {
            // TO DO: add in images in the Assets folder
            // TO DO: load in different image based on the content
            // TO DO: card.content
            ZStack {
                Image(card.content)
                    .resizable()
                    .scaledToFit()
            }
            .padding(size.width * 0.03)
            .rotation3DEffect(Angle.degrees(card.isMatched ? 360 : 0), axis: (x: 0, y: 1, z: 0))
            .animation(card.isMatched ? .linear(duration: 2.0).repeatForever(autoreverses: false) : .default)
        }
        else if theme[0] == "shapeScape" {
            // TO DO: distinguish based on card content
            // TO DO: another function that parses out the shape based on the string??
            ShapeReturn(shape: card.content)
        }
        else {
            Text(card.content)
                .font(systemFont(for: size))
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(card.isMatched ? .linear(duration: 1.0).repeatForever(autoreverses: false) : .default)
        }
    }
    
    private func angle(for degrees: Double) -> Angle {
        Angle.degrees(degrees * 360 - 90)
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
        CardView(card: ConcentrationGame<String>.Card(isFaceUp: true, isMatched: false, content: "🥝"), theme: [GameType.emojiMojo.rawValue, "People"])
            .foregroundColor(.blue)
            .padding(50)
    }
}
