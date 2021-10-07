//
//  EmojiConcentrationGame.swift
//  EmojiConcentrationGame
//
//  Created by Chris Young on 9/8/21.
//  View Model

import SwiftUI
import Foundation

class EmojiConcentrationGame: ObservableObject {
    @Published private var game: ConcentrationGame<String>
    
    var player = SoundPlayer()
    
    init(_ theme: [String]) {
        game = EmojiConcentrationGame.createGame(theme: theme)
    }
    
    // TO DO: It seems like 6 different games are starting before it should be. Like in random, if I don't already have items in the content or a number of cards, then it's not working.... Get an index out of range error.
    private static func createGame(theme: [String]) -> ConcentrationGame<String> {
        var gameTheme: [Theme] = themes.filter {$0.name == theme[1]}
        
        if gameTheme[0].name == "Random" {
            gameTheme.insert(buildRandom(), at: 0)
        }
        
        return ConcentrationGame<String>(numberOfPairsOfCards: (theme[0] != "templeMatch" ? Int.random(in: 3 ... gameTheme[0].content.count): 4), theme: theme) { index in
            gameTheme[0].content[index]
        }
    }
    
    // MARK: - Access to model
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    var score: Int {
        game.score
    }
    
    var gameIsOver: Bool {
        game.gameOver
    }
    
    // TO DO: Put in color right here and switch statements to access from the view
    var color: Color {
        let gameTheme: [Theme] = themes.filter {$0.name == theme[1]}
        
        return convertColor(from: gameTheme[0].color)
    }
    
    var theme: [String] {
        game.theme
    }
    
    // MARK: - Intents
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        game.choose(card)
        
        player.playSound(named: "firework_rocket_launch.mp3")
    }
    
    func newGame() -> Void {
        game = EmojiConcentrationGame.createGame(theme: game.theme)
    }
    
    func gameOver() {
        game.gameOver = true
    }
    
    private func convertColor(from string: String) -> Color {
        switch string {
            case "red":
                return Color.red
            case "purple":
                return Color.purple
            case "green":
                return Color.green
            case "black":
                return Color.black
            case "gray":
                return Color.gray
            case "yellow":
                return Color.yellow
            case "orange":
                return Color.orange
            case "pink":
                return Color.pink
            default:
                return Color.blue
        }
    }
}
