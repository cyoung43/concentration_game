//
//  Theme.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/25/21.
//

import Foundation

enum GameType: String {
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
    var highScore: Int
    
    mutating func updateHighScore(newScore: Int) {
        highScore = newScore
    }
}

var themes = [
    Theme(
        name: "People",
        gameType: .emojiMojo,
        content: ["👮🏻‍♀️", "🕵🏻‍♂️", "👩🏻‍🚀", "👨🏻‍⚖️", "🧞‍♂️", "🧙🏻‍♂️", "🎅🏼", "👩🏻‍🎨", "👩🏻‍💼", "🥷🏼"],
        color: "blue",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
    Theme(
        name: "Halloween",
        gameType: .emojiMojo,
        content: ["🕸", "🎃", "🦇", "🍭", "🧙🏼‍♀️", "👻", "😱", "🧪", "🔮", "🕷"],
        color: "orange",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
    Theme(
        name: "Fruits",
        gameType: .emojiMojo,
        content: ["🥑", "🍓", "🥭", "🍌", "🥥", "🍍", "🥝", "🍇", "🫐", "🍉"],
        color: "red",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
    Theme(
        name: "Foods",
        gameType: .emojiMojo,
        content: ["🍔", "🍩", "🍤", "🍿", "🥞", "🥩", "🍕", "🌯", "🍟", "🍰"],
        color: "yellow",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
    Theme(
        name: "Symbols",
        gameType: .emojiMojo,
        content: ["🚮", "🔀", "⤵️", "🔂", "3️⃣", "🔝", "🔜", "⚖️", "⚠️", "❔"],
        color: "green",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
    Theme(
        // see functions below to actually build this theme
        name: "Random",
        gameType: .emojiMojo,
        content: ["r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8"],
        color: "indigo",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
    Theme(
        name: "Shape Scape",
        gameType: .shapeScape,
        content: ["circle", "rectangle", "capsule", "triangle", "hexagon", "octagon", "squiggle", "ellipse", "roundedrectangle", "circle"],
        color: "purple",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
    Theme(
        name: "International",
        gameType: .templeMatch,
        content: ["alabang_temple", "urdaneta_temple", "manila_temple", "cebu_city_temple", "bangkok_temple", "bengaluru_temple", "antofagasta_temple", "brasilia_temple", "okinawa_temple", "kinshasa_temple"],
        color: "gray",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
    Theme(
        name: "Pioneer Temples",
        gameType: .templeMatch,
        content: ["salt_lake_temple", "st_george_temple", "nauvoo_temple", "manti_temple", "logan_temple", "mesa_temple", "laie_temple", "cardston_temple", "switzerland_temple", "idaho_falls_temple"],
        color: "black",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
    Theme(
        name: "Utah Temples",
        gameType: .templeMatch,
        content: ["bountiful_temple", "draper_temple", "mount_timpanogos_temple", "taylorsville_temple", "payson_temple", "provo_city_center_temple", "cedar_city_temple", "saratoga_springs_temple", "jordan_river_temple", "ogden_temple"],
        color: "pink",
        numberOfPairsOfCards: 8,
        highScore: 0
    ),
]


// TO DO: random color not working.... it's showing blue as a default
private func createRandomContent() -> [String] {
    var content: [String] = []
    var i = 0
    
    while i < 10 {
        let item = themes[Int.random(in: 0...4)].content[Int.random(in: 0...9)]
        
        if !content.contains(item) {
            content.append(item)
            i += 1
        }
    }
    
    return content
}

func buildRandom() -> Theme {
    let random = Theme(
        name: "Random",
        gameType: .emojiMojo,
        content: createRandomContent(),
        color: themes[Int.random(in: 0 ..< 10)].color,
        numberOfPairsOfCards: Int.random(in: 3...10),
        highScore: 0
    )
    
    return random
}

// helper variable to iterate through game types
let gameModes: [HelperTheme] = [HelperTheme(gameType: .emojiMojo, name: "Emoji Mojo"), HelperTheme(gameType: .shapeScape, name: "Shape Scape"), HelperTheme(gameType: .templeMatch, name: "Temple Match")]

struct HelperTheme: Identifiable, Hashable {
    var id = UUID()
    var gameType: GameType
    var name: String
}
