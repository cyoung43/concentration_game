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
                    .opacity(0.4)
                    .foregroundColor(.red)
                Circle()
                    .stroke(.red, lineWidth: 3)
            }
            Circle()
        case "capsule":
            ZStack {
                Capsule()
                    .opacity(0.4)
                    .foregroundColor(.blue)
                Capsule()
                    .stroke(.blue, lineWidth: 3)
            }
        case "rectangle":
            ZStack {
                Rectangle()
                    .opacity(0.4)
                    .foregroundColor(.gray)
                Rectangle()
                    .stroke(.gray, lineWidth: 3)
            }
        case "triangle":
            ZStack {
                Triangle()
                    .opacity(0.4)
                    .foregroundColor(.green)
                Triangle()
                    .stroke(.green, lineWidth: 3)
            }
        case "hexagon":
            ZStack {
                Polygon(sides: 6, angle: 90)
                    .opacity(0.4)
                    .foregroundColor(.orange)
                Polygon(sides: 6, angle: 90)
                    .stroke(.orange, lineWidth: 3)
            }
        case "octagon":
            ZStack {
                Polygon(sides: 8, angle: 90)
                    .opacity(0.4)
                    .foregroundColor(.yellow)
                Polygon(sides: 8, angle: 90)
                    .stroke(.yellow, lineWidth: 3)
            }
        default:
            ZStack {
                Circle()
                    .opacity(0.4)
                    .foregroundColor(.brown)
                Circle()
                    .stroke(.brown, lineWidth: 3)
            }
            
            // TO DO: Make sure to put the squiggle here later
        }
    }

}

struct ShapeReturn_Previews: PreviewProvider {
    static var previews: some View {
        ShapeReturn(shape: "octagon")
    }
}
