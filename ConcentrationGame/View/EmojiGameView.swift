//
//  ContentView.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/8/21.
//

import SwiftUI

struct EmojiGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame
    
    @State private var dealtCards = Set<UUID>()
    @Namespace private var dealingCards
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                deckBody
                gameBody
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Score: \(emojiGame.score)")
            .navigationBarItems(leading: NavigationLink(destination: GameNavigation()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)) {
                Image(systemName: "arrow.backward")
                // TO DO: adjust transition animation here
            }.transition(.move(edge: .trailing)),
                trailing: Button("New Game") {
                withAnimation(.linear) {
                    emojiGame.newGame()
                }
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(emojiGame.cards) { card in
                if isUndealt(card) {
                    // TO DO: add in theme: emojiGame.theme
                    CardView(card: card, theme: emojiGame.theme)
                        .zIndex(zIndex(for: card))
                        .matchedGeometryEffect(id: card.id, in: dealingCards)
                        .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                }
            }
        }
        .foregroundColor(CardConstants.color)
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        .padding(.bottom)
        .onTapGesture {
            for card in emojiGame.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var gameBody: some View {
        GeometryReader { geometry in
            AspectVGrid(items: emojiGame.cards, aspectRatio: CardConstants.aspectRatio) { card in
                if !isUndealt(card) {
                    // TO DO: add in theme: emojiGame.theme
                    CardView(card: card, theme: emojiGame.theme)
                        .zIndex(zIndex(for: card))
                        .matchedGeometryEffect(id: card.id, in: dealingCards)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                        .padding(geometry.size.width * 0.01)
                        .onTapGesture {
                            withAnimation {
                                emojiGame.choose(card)
                            }
                        }
                }
                    
            }
            .padding(geometry.size.width * 0.01)
            .foregroundColor(.blue)
        }
    }
    
    // can include private functions here if I want to pass into the aspectVGrid
    private func isUndealt(_ card: ConcentrationGame<String>.Card) -> Bool {
        !dealtCards.contains(card.id)
    }
    
    private func deal(_ card: ConcentrationGame<String>.Card) {
        dealtCards.insert(card.id)
    }
    
    private func dealAnimation(for card: ConcentrationGame<String>.Card) -> Animation {
        var delay = 0.0
        
        if let index = emojiGame.cards.firstIndex(matching: card) {
            delay = Double(index) * CardConstants.totalDealDuration / Double(emojiGame.cards.count)
        }
        
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(for card: ConcentrationGame<String>.Card) -> Double {
        -Double(emojiGame.cards.firstIndex(matching: card) ?? 0)
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        // TO DO: get rid of color and instead do emojiGame.color
        static let color = Color.blue
        static let deckWidth: CGFloat = deckHeight * aspectRatio
        static let deckHeight: CGFloat = 150
        static let dealDuration = 0.5
        static let totalDealDuration = 2.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(emojiGame: EmojiConcentrationGame([GameType.emojiMojo.rawValue, "People"]))
    }
}
