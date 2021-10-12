//
//  ShapeReturn.swift
//  ConcentrationGame
//
//  Created by New User on 10/5/21.
//

import SwiftUI

struct ShapeReturn: View {
    var shape: String
    
    var body: some View {
        matchShape(shape: shape)
            .padding()
    }
    
    @ViewBuilder
    private func matchShape(shape: String) -> some View {
        switch shape {
            case "circle":
                ZStack {
                    Circle()
                        .foregroundColor(.red)
                    Circle()
                        .stroke(.red, lineWidth: 3)
                }
            case "capsule":
                ZStack {
                    Capsule()
                        .foregroundColor(.blue)
                    Capsule()
                        .stroke(.blue, lineWidth: 3)
                }
                .aspectRatio(1/2, contentMode: .fit)
                .padding(16)
            case "rectangle":
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                    Rectangle()
                        .stroke(.gray, lineWidth: 3)
                }
                .aspectRatio(1/2, contentMode: .fit)
                .padding(16)
            case "triangle":
                ZStack {
                    Triangle()
                        .foregroundColor(.green)
                    Triangle()
                        .stroke(.green, lineWidth: 3)
                }
                .padding(16)
                .aspectRatio(1/2, contentMode: .fit)
            case "hexagon":
                ZStack {
                    Polygon(sides: 6, angle: 90)
                        .foregroundColor(.orange)
                    Polygon(sides: 6, angle: 90)
                        .stroke(.orange, lineWidth: 3)
                }
            case "octagon":
                ZStack {
                    Polygon(sides: 8, angle: 90)
                        .foregroundColor(.yellow)
                    Polygon(sides: 8, angle: 90)
                        .stroke(.yellow, lineWidth: 3)
                }
            case "squiggle":
                ZStack {
                    Squiggle()
                        .padding(13)
                }
            default:
                ZStack {
                    Squiggle()
                        .padding(13)
                }
        }
    }

}

struct ShapeReturn_Previews: PreviewProvider {
    static var previews: some View {
        ShapeReturn(shape: "squiggle")
    }
}
