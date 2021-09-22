//
//  ArrayOnly.swift
//  ConcentrationGame
//
//  Created by Chris Young on 9/21/21.
//

import Foundation


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
