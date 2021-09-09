//
//  ContentView.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/8/21.
//

import SwiftUI

struct ContentView: View {
    var emojiGame: EmojiConcentrationGame
    
    var body: some View {
        HStack {
            ForEach(emojiGame.cards) { card in
                CardView(card: card).onTapGesture(perform: {
                    emojiGame.choose(card: card)
                })
            }
        }
        .padding()
    }
}

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                if card.totalPairs > 4 {
                    Text(card.content)
                        .font(.title)
                }
                else {
                    Text(card.content)
                        .font(.largeTitle)
                }
            }
            else {
                RoundedRectangle(cornerRadius: 10)
            }
        }
        .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(emojiGame: EmojiConcentrationGame())
    }
}
