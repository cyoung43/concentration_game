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
    
    private var player = SoundPlayer()
    private let defaults = UserDefaults.standard
    static var gameThemes: [Theme] = []
    
    var hasDealt: Bool = false
    
    init(_ theme: [String]) {
        game = EmojiConcentrationGame.createGame(theme: theme)
    }
    
    private static func createGame(theme: [String]) -> ConcentrationGame<String> {
        var gameTheme: [Theme] = themes.filter {$0.name == theme[1]}
        
        if gameTheme[0].name == "Random" {
            gameTheme.insert(buildRandom(), at: 0)
            gameThemes.insert(gameTheme[0], at: 0)
            print(gameTheme)
        }
        
        print(gameTheme[0])
        
        return ConcentrationGame<String>(numberOfPairsOfCards: UserDefaults.standard.bool(forKey: "pairsOfCards") ? theme[0] == "templeMatch" ? 4 : Int.random(in: 3 ... gameTheme[0].content.count): UserDefaults.standard.integer(forKey: "numberOfCards"), theme: theme) { index in
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
    
    var color: Color {
        let gameTheme: [Theme] = themes.filter {$0.name == theme[1]}
        
        return convertColor(from: gameTheme[0].name == "Random" ? EmojiConcentrationGame.gameThemes[0].color : gameTheme[0].color)
    }
    
    var theme: [String] {
        game.theme
    }
    
    // MARK: - Intents
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        let score1 = game.score
        game.choose(card)
        
        let score2 = game.score
        
        if defaults.bool(forKey: GameSettings.playSoundKey) {
            if score2 > score1 {
                player.playSound(named: "whoosh_boom.m4a")
            }
            else {
                player.playSound(named: "basketball_rim_clank.mp3")
            }
        }
        
        game.isGameStillGoing(gameType: theme[1])
    }
    
    func newGame() -> Void {
        game = EmojiConcentrationGame.createGame(theme: game.theme)
        hasDealt = false
    }
    
    func gameOver() {
        game.gameOver = true
    }
    
    func turnFaceDown(_ card: ConcentrationGame<String>.Card) {
        if card.isMatched {
            game.turnFaceDown(card)
        }
    }
    
    private func convertColor(from color: String) -> Color {
        switch color {
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
            case "indigo":
                return Color.indigo
            default:
                return Color.blue
        }
    }
}
