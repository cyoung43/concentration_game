//
//  Welcome.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/28/21.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        NavigationView {
            NavigationLink("Start", destination: {
                GameNavigation()
            })
                .foregroundColor(.green)
                .font(.title)
                .padding(20)
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.green, lineWidth: 4)
                )
                .transition(.opacity)
            .navigationTitle("Welcome!")
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
