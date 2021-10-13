//
//  Scores.swift
//  ConcentrationGame
//
//  Created by Chris Young on 10/6/21.
//

import SwiftUI

struct Scores: View {
    var body: some View {
        List {
            Section(header: Text("All Time High Score")) {
                HStack {
                    Text("All Game Modes")
                    Spacer()
                    Text("\(UserDefaults.standard.integer(forKey: "highScore") > 0 ? String(UserDefaults.standard.integer(forKey: "highScore")) : "Never played")")
                }
            }
            
            ForEach (gameModes) { type in
                Section(header: Text(type.name)) {
                    scoreBody(type: type)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("High Scores")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: ViewBuilder Function
    @ViewBuilder
    func scoreBody(type: HelperTheme) -> some View {
        ForEach (themes) { theme in
            if theme.gameType == type.gameType {
                HStack {
                    Text("\(theme.name)")
                    Spacer()
                    Text("\(UserDefaults.standard.integer(forKey: theme.name) > 0 ? String(UserDefaults.standard.integer(forKey: theme.name)) : "Never played")")
                }
            }
        }
    }
}

struct Scores_Previews: PreviewProvider {
    static var previews: some View {
        Scores()
    }
}
