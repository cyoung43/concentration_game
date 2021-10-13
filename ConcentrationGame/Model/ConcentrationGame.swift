//
//  ConcentrationGame.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/8/21.
//

import Foundation
import CoreAudio
import SwiftUI

struct ConcentrationGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    private(set) var theme: [String]
    
    var score: Int {
        cards.reduce(0) { (total, card) -> Int in
            total + card.score
        }
    }
    
    var gameOver: Bool = false
    
    // TO DO: add in theme here to be added to the gametype
    init(numberOfPairsOfCards: Int, theme: [String], cardContentFactory: (Int) -> CardContent) {
        
        cards = Array<Card>()
        
        self.theme = theme
        
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                
                indexOfTheOneAndOnlyFaceUpCard = nil
            }
            
            else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
            cards[chosenIndex].viewCount += 1
        }
    }
    
    mutating func turnFaceDown(_ card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card),
           cards[chosenIndex].isMatched {
            cards[chosenIndex].isFaceUp = false
        }
    }
    
    mutating func isGameStillGoing(gameType theme: String) {
        let check = cards.allSatisfy { $0.isMatched }
        
        if check {
            gameOver = true
            gameIsFinished(theme: theme)
        }
    }
    
    func gameIsFinished(theme: String) {
        let userDefaults = UserDefaults.standard
        
        if let highScore = userDefaults.string(forKey: "highScore") {
            if score > Int(highScore) ?? 0 {
                userDefaults.set(score, forKey: "highScore")
            }
        }
        else {
            userDefaults.set(score, forKey: "highScore")
        }
        
        if let themeScore = userDefaults.string(forKey: theme) {
            if score > Int(themeScore) ?? 0 {
                userDefaults.set(score, forKey: theme)
            }
        }
        else {
            userDefaults.set(score, forKey: theme)
        }
        
        themes = themes.map { (gameTheme: Theme) -> Theme in
            var mutableGameTheme = gameTheme
            
            if mutableGameTheme.name == theme && score > mutableGameTheme.highScore {
                mutableGameTheme.updateHighScore(newScore: score)
            }
            
            return mutableGameTheme
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                }
                else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        var id = UUID()
        var viewCount = 0
        var isDealt = false
        
        // MARK: - Score
        
        var score: Int {
            if isMatched {
                return 3 - viewCount + Int(bonusRemaining * 5)
            }
            if viewCount > 0 {
                return -viewCount + 1
            }
            
            return 0
        }
        
        // MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 12
        var lastFaceUpTime: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpTime = lastFaceUpTime {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpTime)
            }
            else {
                return pastFaceUpTime
            }
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime && lastFaceUpTime == nil {
                lastFaceUpTime = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpTime = nil
        }
        
        mutating func deal() {
            isDealt = true
        }
    }
}
