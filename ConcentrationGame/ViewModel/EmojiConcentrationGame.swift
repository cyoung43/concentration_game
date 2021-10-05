//
//  EmojiConcentrationGame.swift
//  EmojiConcentrationGame
//
//  Created by Chris Young on 9/8/21.
//  View Model

import SwiftUI

class EmojiConcentrationGame: ObservableObject {
    @Published private var game: ConcentrationGame<String>
    
    // TO DO: Can pass in theme name, enum type, etc
    init(_ theme: String) {
        game = EmojiConcentrationGame.createGame(theme: theme)
    }
    
    private static let emojis = ["🥑", "🥨", "🥭", "🌶", "🥥", "🍕", "🥝"]
    
    // TO DO: add in theme to be passed into the model
    // this is a static function and I can't access the instance vars
    // the assignment of game needs to go into the initializer
    private static func createGame(theme: String) -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: Int.random(in: 2 ... 5), theme: theme) { index in
            emojis[index]}
    }
    
    // MARK: - Access to model
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    var score: Int {
        game.score
    }
    
    // MARK: - Intents
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        game.choose(card)
    }
    
    func newGame() -> Void {
        game = EmojiConcentrationGame.createGame(theme: game.theme)
    }
}
