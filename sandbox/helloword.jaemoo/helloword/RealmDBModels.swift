//
//  RealmDBModels.swift
//  helloword
//
//  Created by JaemooJung on 2021/04/16.
//

import SwiftUI
import RealmSwift

class Word: Object, Identifiable {
    @objc dynamic var id : UUID = UUID()
    @objc dynamic var word: String
    @objc dynamic var isMemorized: Bool = false
    
    init(word:String) {
        self.word = word
    }
}
