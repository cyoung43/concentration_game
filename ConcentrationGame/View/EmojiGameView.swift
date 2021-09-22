//
//  ContentView.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/8/21.
//

import SwiftUI

struct EmojiGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / Constants.desiredCardWidth))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns(for: geometry.size)) {
                            ForEach(emojiGame.cards) { card in
                                CardView(card: card).onTapGesture {
                                    emojiGame.choose(card)
                                }
                            }
                        }
                    }
                }
                .padding()
                .foregroundColor(.blue)
            }
            .navigationTitle("Concentration")
            .navigationBarItems(leading: Button("New Game") {
                emojiGame.newGame()
                }, trailing: Text("Score: \(emojiGame.score)"))
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    private struct Constants {
        static let desiredCardWidth: CGFloat = 125
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(emojiGame: EmojiConcentrationGame())
    }
}
