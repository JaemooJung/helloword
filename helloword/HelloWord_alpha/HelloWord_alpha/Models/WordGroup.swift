//
//  Group.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/21.
//

import SwiftUI
import RealmSwift

class WordGroup: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var groupName: String = ""
    @objc dynamic var startLanguage: String = ""
    @objc dynamic var targetLanguage: String = ""
    
    convenience init(groupName: String, startLanguage: String, targetLanguage: String) {
        self.init()
        self.groupName = groupName
        self.startLanguage = startLanguage
        self.targetLanguage = targetLanguage
    }
}
