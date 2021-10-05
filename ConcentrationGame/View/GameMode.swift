//
//  GameMode.swift
//  ConcentrationGame
//
//  Created by New User on 10/4/21.
//

import SwiftUI

struct GameMode: View {
    var gameType: GameType
    // @State var navTitle: String = getPageTitle(gameType: gameType)
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Modes")) {
                    ForEach (themes) { theme in
                        if theme.gameType == gameType {
                            NavigationLink(theme.name, destination: { EmojiGameView(emojiGame: EmojiConcentrationGame([theme.gameType.rawValue, theme.name]))
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true)
                                
                                // TO DO: Make back button go to the emoji mojo game modes, temple match game modes, etc... Currently goes to the home screen
                            })
                        }
                    }
                }
            }
                .navigationTitle(getPageTitle(gameType: gameType))
        }
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
