//
//  EmojiConcentrationGame.swift
//  EmojiConcentrationGame
//
//  Created by Chris Young on 9/8/21.
//  View Model

import SwiftUI

class EmojiConcentrationGame {
    private var game = createGame()
    
    static let emojis = ["🥑", "🥨", "🥭", "🌶", "🥥"]
    
    static func createGame() -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: Int.random(in: 2 ..< emojis.count + 1)) { index in
            emojis[index]}
    }
    
    // MARK: - Access to model
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    // MARK: - Intents
    
    func choose(card: ConcentrationGame<String>.Card) {
        game.choose(card: card)
    }
}
