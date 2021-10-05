//
//  Polygon.swift
//  ConcentrationGame
//
//  Created by Chris Young on 10/5/21.
//

import SwiftUI

struct Polygon: Shape {
    let sides:Int
    let angle:Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center:CGPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius:Double = Double(rect.width / 2)
        
        for i in stride(from: angle, to: (360 + angle), by: 360/sides) {
            
            let radians = Double(i) * Double.pi / 180.0
            let x = Double(center.x) + radius * cos(radians)
            let y = Double(center.y) + radius * sin(radians)

            if i == angle {
                path.move(to: CGPoint(x: x, y: y))
            }
            else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        
        return path
    }
}

struct Polygon_Previews: PreviewProvider {
    static var previews: some View {
        Polygon(sides: 6, angle: 90)
            .opacity(0.4)
            .foregroundColor(.blue)
            .padding()
    }
}
