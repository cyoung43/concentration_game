//
//  SoundPlayer.swift
//  ConcentrationGame
//
//  Created by Chris Young on 10/7/21.
//

import Foundation
import AVFoundation

// Sounds coming from ZapSplat.com
struct SoundPlayer {
    var player: AVAudioPlayer?
    
    mutating func playSound(named soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: nil)
        else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player?.play()
        }
        catch {
            
        }
    }
}
