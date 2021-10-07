//
//  GameSettings.swift
//  ConcentrationGame
//
//  Created by Chris Young on 10/5/21.
//

import SwiftUI

// TO DO: reset to 8 after user changes back to default settings
struct GameSettings: View {
    @State private var gameSounds = false
    @State private var defaultCards = true
    @State private var userNumberOfCards: Int = 8
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Sound Effects")) {
                    HStack {
                        Toggle("Game Sounds", isOn: $gameSounds)
                    }
                }
                Section(header: Text("Pairs of Cards")) {
                    HStack {
                        Toggle("Default", isOn: $defaultCards)
                            .onTapGesture {
                                
                            }
                    }
                    HStack {
                        Stepper("Pairs of Cards: \(defaultCards ? 8 : userNumberOfCards)", value: $userNumberOfCards, in: 3...10)
                    }
                    .disabled(defaultCards)
                }
            }
            
            .navigationTitle("Game Settings")
        }
    }
}

struct GameSettings_Previews: PreviewProvider {
    static var previews: some View {
        GameSettings()
    }
}
