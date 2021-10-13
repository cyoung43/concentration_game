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
    @State private var isTextMaxSize = false
    
    private let maxSize: CGFloat = 2
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if emojiGame.gameIsOver {
                VStack {
                    Spacer()
                    userWon
                    ZStack {
                        deckBody
                        gameBody
                    }
                }
            }
            else {
                deckBody
                gameBody
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Score: \(emojiGame.score)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("New Game") {
                    withAnimation(.linear) {
                        emojiGame.newGame()
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if emojiGame.hasDealt {
                for card in emojiGame.cards {
                    deal(card)
                    
                    if card.isMatched {
                        emojiGame.turnFaceDown(card)
                    }
                }
            }
        }
    }
    
    // MARK: Views
    
    var deckBody: some View {
        ZStack {
            ForEach(emojiGame.cards) { card in
                if isUndealt(card) {
                    CardView(card: card, theme: emojiGame.theme)
                        .zIndex(zIndex(for: card))
                        .matchedGeometryEffect(id: card.id, in: dealingCards)
                        .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                }
            }
        }
        .foregroundColor(emojiGame.color)
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        .padding(.bottom)
        .onTapGesture {
            for card in emojiGame.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
            
            emojiGame.hasDealt = true
        }
    }
    
    var gameBody: some View {
        GeometryReader { geometry in
            AspectVGrid(items: emojiGame.cards, aspectRatio: CardConstants.aspectRatio) { card in
                if !isUndealt(card) {
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
            .foregroundColor(emojiGame.color)
        }
    }
    
    var userWon: some View {
        VStack {
            Text("You win!")
                .font(.largeTitle.bold())
                .scaleEffect(isTextMaxSize ? maxSize : 1)
                .onAppear {
                    withAnimation(CardConstants.animation, {
                        isTextMaxSize.toggle()
                    })
                }
        }
        
    }
    
    // MARK: Functions
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
        static let deckWidth: CGFloat = deckHeight * aspectRatio
        static let deckHeight: CGFloat = 150
        static let dealDuration = 0.5
        static let totalDealDuration = 2.0
        static let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(emojiGame: EmojiConcentrationGame([GameType.emojiMojo.rawValue, "People"]))
    }
}
