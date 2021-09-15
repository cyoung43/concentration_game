//
//  ArrayIdentifiable.swift
//  ArrayIdentifiable
//
//  Created by Chris Young on 9/10/21.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching target: Element) -> Int? {
        for index in 0 ..< self.count {
            if self[index].id == target.id {
                return index
            }
        }
        
        return nil
    }
}
