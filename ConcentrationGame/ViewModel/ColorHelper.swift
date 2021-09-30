//
//  ColorHelper.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/30/21.
//

import Foundation
import SwiftUI

func color(from string: String) -> Color {
    switch string {
        case "red":
            return Color.red
        default:
            return Color.blue
    }
}
