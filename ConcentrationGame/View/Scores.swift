//
//  Scores.swift
//  ConcentrationGame
//
//  Created by New User on 10/6/21.
//

import SwiftUI

struct Scores: View {
    var body: some View {
        List {
            Section(header: Text("All Time High Score")) {
                Text("High score")
            }
            Section(header: Text("EmojiMojo: People")) {
                Text("High score for people")
            }
            
            // TO DO: fill in the rest of the themes and etc.
            Text("List item 1")
            Text("List item 2")
            Text("List item 3")
        }
    }
}

struct Scores_Previews: PreviewProvider {
    static var previews: some View {
        Scores()
    }
}
