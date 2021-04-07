//
//  Array+.swift
//  helloword
//
//  Created by JaemooJung on 2021/04/07.
//

import Foundation

extension Array where Element: Identifiable {
    
    func getIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
    
}
