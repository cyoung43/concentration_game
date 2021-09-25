//
//  AspectVGrid.swift
//  ConcentrationGame
//
//  Created by New User on 9/25/21.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where It ItemView: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    var body: some View {
        let width: CGFloat =  110
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: width))]) {
            ForEach(items) { item in
                content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
        }
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
