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
        case "purple":
            return Color.purple
        case "green":
            return Color.green
        case "black":
            return Color.black
        case "gray":
            return Color.gray
        case "yellow":
            return Color.yellow
        case "orange":
            return Color.orange
        default:
            return Color.blue
    }
}
