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
                    if theme[0] != "random" {
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
                        SquareAnimation(height: geometry.size.height * 2, width: geometry.size.width * 2)
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
        if theme[0] == "templeMatch" {
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
            // TO DO: add in bezier curve
            // TO DO: figure out rectangle, capsule, triangle shapes sizes (aspectRatio)
            // TO DO: figure out why circle is purple and stroke is red
            ShapeReturn(shape: card.content)
        }
        else if theme[0] == "random" {
            Text("r1")
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
        CardView(card: ConcentrationGame<String>.Card(isFaceUp: true, isMatched: false, content: "r1"), theme: ["random", "Random"])
            .foregroundColor(.blue)
            .padding(50)
    }
}


// content: "🥝"
// theme: [GameType.emojiMojo.rawValue, "People"]
