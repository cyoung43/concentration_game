//
//  GameMode.swift
//  ConcentrationGame
//
//  Created by Chris Young on 10/4/21.
//

import SwiftUI

struct GameMode: View {
    var gameType: GameType
    
    var body: some View {
        Form {
            Section(header: Text("Game Modes")) {
                ForEach (themes) { theme in
                    if theme.gameType == gameType {
                        NavigationLink(theme.name, destination: { EmojiGameView(emojiGame: EmojiConcentrationGame([theme.gameType.rawValue, theme.name]))
                        })
                    }
                }
            }
        }
        .navigationTitle(getPageTitle(gameType: gameType))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getPageTitle(gameType: GameType) -> String {
        var navTitle: String
        
        switch gameType {
            case .emojiMojo:
                navTitle = "Emoji Mojo"
            case .shapeScape:
                navTitle = "Shape Scape"
            default:
                navTitle = "Temple Match"
        }
        
        return navTitle
    }
}

struct GameMode_Previews: PreviewProvider {
    static var previews: some View {
        GameMode(gameType: .emojiMojo)
    }
}
