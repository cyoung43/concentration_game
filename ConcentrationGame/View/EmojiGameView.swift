//
//  ContentView.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/8/21.
//

import SwiftUI

enum GameType {
    case emojiMojo
    case shapeScape
    case TempleMatch
}

struct Theme: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var gameType: GameType
    var content: [String]
    var color: Color
    var numberOfPairsOfCards: Int
}

let themes = [
    Theme(name: "Animals", gameType: .emojiMojo, content: ["", ""], color: .blue, numberOfPairsOfCards: 5)
]

// need for each to iterate over themes in array
// need theme.swift file

struct EmojiGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.fixed(Constants.desiredCardWidth)), count: Int(size.width / Constants.desiredCardWidth))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns(for: geometry.size)) {
                            ForEach(emojiGame.cards) { card in
                                CardView(card: card).onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                        emojiGame.choose(card)
                                    }
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
                withAnimation {
                    emojiGame.newGame()
                }
                }, trailing: Text("Score: \(emojiGame.score)"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private struct Constants {
        static let desiredCardWidth: CGFloat = 110
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(emojiGame: EmojiConcentrationGame())
    }
}
