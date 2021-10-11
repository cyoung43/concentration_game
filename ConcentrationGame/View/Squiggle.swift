//
//  Squiggle.swift
//  ConcentrationGame
//
//  Created by Chris Young on 10/11/21.
//

import SwiftUI

struct SquiggleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 1040, y: 150))
        path.addCurve(to: CGPoint(x: 630, y: 540),
                      control1: CGPoint(x: 1124, y: 369),
                      control2: CGPoint(x: 897, y: 608))
        path.addCurve(to: CGPoint(x: 270, y: 530),
                      control1: CGPoint(x: 523, y: 513),
                      control2: CGPoint(x: 422, y: 420))
        path.addCurve(to: CGPoint(x: 50, y: 400),
                      control1: CGPoint(x: 96, y: 656),
                      control2: CGPoint(x: 54, y: 583))
        path.addCurve(to: CGPoint(x: 360, y: 120),
                      control1: CGPoint(x: 46, y: 220),
                      control2: CGPoint(x: 191, y: 97))
        path.addCurve(to: CGPoint(x: 890, y: 140),
                      control1: CGPoint(x: 592, y: 152),
                      control2: CGPoint(x: 619, y: 315))
        path.addCurve(to: CGPoint(x: 1040, y: 150),
                      control1: CGPoint(x: 953, y: 100),
                      control2: CGPoint(x: 1009, y: 69))
        
        let scale: CGFloat = min(rect.width / path.boundingRect.height, rect.height / path.boundingRect.width)
        let transform = CGAffineTransform(scaleX: scale, y: scale)
            .rotated(by: -Double.pi / 2)
        
        path = path.applying(transform)
        path = path.offsetBy(dx: rect.minX - path.boundingRect.minX, dy: rect.minY - path.boundingRect.minY)
        
        return path
            .offsetBy(dx: (rect.width - path.boundingRect.width) / 2, dy: (rect.height - path.boundingRect.height) / 2)
    }
}

struct Squiggle: View {
    var body: some View {
        ZStack {
            SquiggleShape()
                .foregroundColor(.gray)
            SquiggleShape()
                .stroke(.black, lineWidth: 4)
        }
        
    }
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Squiggle()
                .padding()
        }
        
    }
}
