//
//  NavigationView.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/27/21.
//

import SwiftUI

struct Navigation: View {
    var body: some View {
        NavigationView {
            NavigationLink() {
                "Game Modes"
            }
            .navigationTitle("Concentration")
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
