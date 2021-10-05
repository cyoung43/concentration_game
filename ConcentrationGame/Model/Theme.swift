//
//  Theme.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/25/21.
//

import Foundation

enum GameType {
    case emojiMojo
    case shapeScape
    case templeMatch
}

struct Theme: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var gameType: GameType
    var content: [String]
    var color: String
    var numberOfPairsOfCards: Int
}

let themes = [
    Theme(
        name: "People",
        gameType: .emojiMojo,
        content: ["👮🏻‍♀️", "🕵🏻‍♂️", "👩🏻‍🚀", "👨🏻‍⚖️", "🧞‍♂️", "🧙🏻‍♂️", "🎅🏼", "👩🏻‍🎨", "👩🏻‍💼", "🥷🏼"],
        color: "blue",
        numberOfPairsOfCards: 8
    ),
    Theme(
        name: "Halloween",
        gameType: .emojiMojo,
        content: ["🕸", "🎃", "🦇", "🍭", "🧙🏼‍♀️", "👻", "😱", "🧪", "🔮", "🕷"],
        color: "orange",
        numberOfPairsOfCards: 8
    ),
    Theme(
        name: "Fruits",
        gameType: .emojiMojo,
        content: ["🥑", "🍓", "🥭", "🍌", "🥥", "🍍", "🥝", "🍇", "🫐", "🍉"],
        color: "red",
        numberOfPairsOfCards: 8
    ),
    Theme(
        name: "Foods",
        gameType: .emojiMojo,
        content: ["🍔", "🍩", "🍤", "🍿", "🥞", "🥩", "🍕", "🌯", "🍟", "🍰"],
        color: "yellow",
        numberOfPairsOfCards: 8
    ),
    Theme(
        name: "Symbols",
        gameType: .emojiMojo,
        content: ["🚮", "🔀", "⤵️", "🔂", "3️⃣", "🔝", "🔜", "⚖️", "⚠️", "❔"],
        color: "green",
        numberOfPairsOfCards: 8
    ),
    Theme(
        name: "Random",
        gameType: .emojiMojo,
        content: [],
        color: "",
        numberOfPairsOfCards: 8 // needs to be random here later
    ),
    Theme(
        name: "Shape Scape",
        gameType: .shapeScape,
        content: [],
        color: "purple",
        numberOfPairsOfCards: 8
    ),
    Theme(
        name: "Pioneer Temples",
        gameType: .templeMatch,
        content: [],
        color: "gray",
        numberOfPairsOfCards: 8 
    ),
    Theme(
        name: "International",
        gameType: .templeMatch,
        content: [],
        color: "black",
        numberOfPairsOfCards: 8
    ),
    Theme(
        name: "Utah Temples",
        gameType: .templeMatch,
        content: [],
        color: "orange", // TO DO: Find another color here
        numberOfPairsOfCards: 8
    ),
]
