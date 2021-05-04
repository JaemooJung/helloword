//
//  Group.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/21.
//

import Foundation
import RealmSwift

final class WordGroup: Object, ObjectKeyIdentifiable {
    
    @objc dynamic var _id:String = ObjectId.generate().stringValue
    @objc dynamic var registeredDate: Date = Date()
    @objc dynamic var groupName: String = ""
    @objc dynamic var startLanguage: String = ""
    @objc dynamic var targetLanguage: String = ""
    
    var words = RealmSwift.List<Word>()
    
    convenience init(groupName: String, startLanguage: String, targetLanguage: String) {
        self.init()
        self.groupName = groupName
        self.startLanguage = startLanguage
        self.targetLanguage = targetLanguage
    }
    
    override class func primaryKey() -> String? {
        return "_id"
    }
    
    func update(newGroupName: String) {
        if let realm = self.realm {
            try? realm.write {
                self.groupName = newGroupName
            }
        } else {
            self.groupName = newGroupName
        }
    }
    
    func update(newStartLanguage: String) {
        if let realm = self.realm {
            try? realm.write {
                self.startLanguage = newStartLanguage
            }
        } else {
            self.startLanguage = newStartLanguage
        }
    }
    
    func update(newTargetLanguage: String) {
        if let realm = self.realm {
            try? realm.write {
                self.targetLanguage = newTargetLanguage
            }
        } else {
            self.targetLanguage = newTargetLanguage
        }
    }
}
