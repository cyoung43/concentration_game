//
//  NavigationView.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/27/21.
//

import SwiftUI

struct GameNavigation: View {
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Games")) {
                    ForEach(themes) { theme in
                        switch theme.gameType {
                            case .emojiMojo:
                                NavigationLink("Emoji Mojo", destination: {})
                            default:
                                NavigationLink("Temple Match", destination: {})
                        }
                    }
                    NavigationLink("Emoji Mojo", destination: {
                        EmojiGameView(emojiGame: EmojiConcentrationGame())
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)
                    })
                        .navigationBarBackButtonHidden(true)
                    NavigationLink("Shape Scape", destination: {})
                    NavigationLink("Temple Match", destination: {})
                }
                Section(header: Text("Scores")) {
                    NavigationLink("View High Scores", destination: {})
                }
                Section(header: Text("Settings")) {
                    NavigationLink("Game Settings", destination: {})
                }
            }
            
            .navigationTitle("New Game")
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        GameNavigation()
    }
}
