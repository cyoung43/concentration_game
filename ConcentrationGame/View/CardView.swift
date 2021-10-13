//
//  CardView.swift
//  CardView
//
//  Created by Chris Young on 9/10/21.
//

import SwiftUI

// TO DO: figure out how to pause timer animation once the match is made for temples
struct CardView: View {
    var card: ConcentrationGame<String>.Card
    var theme: [String]
    
    @State private var animatedBonusRemaining = 0.0
    @State private var width = 0.0
    @State private var height = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            if !card.isMatched || card.isFaceUp {
                ZStack {
                    if theme[0] != "templeMatch" {
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
                    }
                    else {
                        if card.isConsumingBonusTime {
                            SquareAnimation(height: height, width: width)
                                .onAppear {
                                    height = geometry.size.height
                                    width = geometry.size.width
                                    withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                        height = 0
                                        width = 0
                                    }
                                }
                        }
                        else {
                            SquareAnimation(height: 0, width: 0)
                        }
                    }
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
        if theme[0] == "templeMatch" {
            ZStack {
                Image(card.content)
                    .resizable()
                    .scaledToFit()
            }
            .padding(size.width * 0.03)
            .scaleEffect(card.isMatched ? 0.5 : 1)
            .animation(card.isMatched ? .easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default,
                       value: card.isMatched)
        }
        else if theme[0] == "shapeScape" {
            // TO DO: add in bezier curve
            ShapeReturn(shape: card.content)
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(card.isMatched ? .linear(duration: 1.0).repeatForever(autoreverses: false) : .default,
                           value: card.isMatched)
        }
        else {
            Text(card.content)
                .font(systemFont(for: size))
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(card.isMatched ? .linear(duration: 1.0).repeatForever(autoreverses: false) : .default,
                           value: card.isMatched)
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
