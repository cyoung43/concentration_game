//
//  NavigationView.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/27/21.
//
//  For some reason this file was removed from my Git repo

import SwiftUI

struct GameNavigation: View {
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Concentration")
                    .font(.largeTitle.bold())
                Form {
                    Section(header: Text("Games")) {
                        NavigationLink("Emoji Mojo", destination: {
                            GameMode(gameType: .emojiMojo)
                        })
                        NavigationLink("Shape Scape", destination: {
                            EmojiGameView(emojiGame: EmojiConcentrationGame([GameType.shapeScape.rawValue, "Shape Scape"]))
                        })
                        NavigationLink("Temple Match", destination: {
                            GameMode(gameType: .templeMatch)
                        })
                    }
                    Section(header: Text("Scores")) {
                        NavigationLink("View High Scores", destination: { Scores()
                        })
                    }
                    Section(header: Text("Settings")) {
                        NavigationLink("Game Settings", destination: {
                            GameSettings()
                        })
                    }
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        GameNavigation()
    }
}
