//
//  ConcentrationGameApp.swift
//  ConcentrationGame
//
//  Created by New User on 9/8/21.
//

import SwiftUI

@main
struct ConcentrationGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: EmojiConcentrationGame())
        }
    }
}
