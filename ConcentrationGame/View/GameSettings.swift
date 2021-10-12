//
//  GameSettings.swift
//  ConcentrationGame
//
//  Created by Chris Young on 10/5/21.
//

import SwiftUI

// TO DO: reset to 8 after user changes back to default settings
struct GameSettings: View {
    static let playSoundKey = "soundEnabled"
    static let defaultCardsKey = "pairsOfCards"
    
    @State private var gameSounds = UserDefaults.standard.bool(forKey: playSoundKey)
    @State private var defaultCards = UserDefaults.standard.bool(forKey: defaultCardsKey)
    @State private var userNumberOfCards: Int = 8
    
    var body: some View {
        List {
            Section(header: Text("Sound Effects")) {
                HStack {
                    Toggle("Game Sounds", isOn: $gameSounds)
                        .onAppear {
                            gameSounds = UserDefaults.standard.bool(forKey: GameSettings.playSoundKey)
                        }
                        .onDisappear {
                            UserDefaults.standard.set(gameSounds, forKey: GameSettings.playSoundKey)
                        }
                }
            }
            Section(header: Text("Pairs of Cards")) {
                HStack {
                    Toggle("Default", isOn: $defaultCards)
                        .onAppear {
                            defaultCards = UserDefaults.standard.bool(forKey: GameSettings.defaultCardsKey)
                        }
                        .onDisappear {
                            UserDefaults.standard.set(defaultCards, forKey: GameSettings.defaultCardsKey)
                        }
                }
                HStack {
                    Stepper("Pairs of Cards: \(defaultCards ? 8 : userNumberOfCards)", value: $userNumberOfCards, in: 3...10)
                }
                .disabled(defaultCards)
            }
        }
        .navigationTitle("Game Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GameSettings_Previews: PreviewProvider {
    static var previews: some View {
        GameSettings()
    }
}
