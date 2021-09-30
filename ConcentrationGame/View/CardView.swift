//
//  CardView.swift
//  CardView
//
//  Created by New User on 9/10/21.
//

import SwiftUI

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    @State var locationX: CGFloat = 0
    @State var locationY: CGFloat = 0
    
    @State private var animatedBonusRemaining = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            if !card.isMatched || card.isFaceUp {
                ZStack {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: angle(for: 0), endAngle: angle(for: -card.bonusRemaining))
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
                    
                    Text(card.content)
                        .font(systemFont(for: geometry.size))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? .linear(duration: 1.0).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
                .offset(x: locationX, y: locationY)
                .onAppear {
                    // print(geometry.size.width, geometry.size.height)
                    if !card.isDealt {
                        withAnimation(.easeInOut) {
                            locationX = geometry.size.width * CGFloat.random(in: 2...5)
                            locationY = geometry.size.height * CGFloat.random(in: 2...5)
                        }
                    }
                }
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
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
        CardView(card: ConcentrationGame<String>.Card(isFaceUp: true, isMatched: false, content: "🥝"))
            .foregroundColor(.blue)
            .padding(50)
    }
}
