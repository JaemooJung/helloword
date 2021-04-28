//
//  Word.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/19.
//

import Foundation
import RealmSwift

// what is final?
final class Word: Object, ObjectKeyIdentifiable {
    
    //MARK: Features
    @objc dynamic var _id = ObjectId.generate()
    @objc dynamic var registeredDate: Date = Date()
    @objc dynamic var word: String = ""
    @objc dynamic var isMemorized: Bool = false
    @objc dynamic var isDeleted: Bool = false
    
    var wordGroup = LinkingObjects(fromType: WordGroup.self, property: "words")
    
    override class func primaryKey() -> String? {
        return "_id"
    }
    
    //MARK: Init
    convenience init(newWord: String) {
        self.init()
        self.word = newWord
    }
    
    //MARK: Intents
    
    func markMemorized() {
        if let realm = self.realm {
            try? realm.write {
                self.isMemorized = !self.isMemorized
            }
        } else {
            self.isMemorized = !self.isMemorized
        }
        print("memorized status: \(self.isMemorized)")
    }
    
    func markDeleted() {
        if let realm = self.realm {
            try? realm.write {
                self.isDeleted = !self.isDeleted
            }
        } else {
            self.isDeleted = !self.isDeleted
        }
        print("deleted status: \(self.isDeleted)")
    }

}
