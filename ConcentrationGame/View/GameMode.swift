//
//  GameMode.swift
//  ConcentrationGame
//
//  Created by New User on 10/4/21.
//

import SwiftUI

struct GameMode: View {
    var gameType: GameType
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Modes")) {
                    ForEach (themes) { theme in
                        if theme.gameType == gameType {
                            NavigationLink(theme.name, destination: { EmojiGameView(emojiGame: EmojiConcentrationGame())
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true)
                                
                                // TO DO: Make back button go to the emoji mojo game modes, temple match game modes, etc... Currently goes to the home screen
                            })
                        }
                    }
                }
            }
                .navigationTitle("Emoji Mojo")
        }
    }
}

struct GameMode_Previews: PreviewProvider {
    static var previews: some View {
        GameMode(gameType: .emojiMojo)
    }
}
