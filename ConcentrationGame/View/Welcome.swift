//
//  Welcome.swift
//  ConcentrationGame
//
//  Created by New User on 9/28/21.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        NavigationView {
            RoundedRectangle(cornerRadius: 50)
                .padding()
            .navigationTitle("Welcome!")
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
