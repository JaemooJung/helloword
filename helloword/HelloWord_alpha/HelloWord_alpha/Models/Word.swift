//
//  Word.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/19.
//

import SwiftUI
import RealmSwift

class Word: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var word: String = ""
    @objc dynamic var isMemorised: Bool = false
    @objc dynamic var isDeleted: Bool = false
    
    convenience init(newWord: String) {
        self.init()
        self.word = newWord
    }
}
