//
//  WordGroupListViewModel2.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/30.
//

import Foundation
import Combine
import RealmSwift

class WordGroupListViewModel: ObservableObject {
    // MARK: Model
    @Published var wordGroups: Results<WordGroup>?
    
    var token: NotificationToken?
    
    //MARK: init
    var realm: Realm?
    
    init() {
        let realm = try? Realm()
        self.realm = realm
        
        if let fetchedGroups = realm?.objects(WordGroup.self) {
            self.wordGroups = fetchedGroups
        }
        token = wordGroups!.observe { [self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial: break
            case .update(_, deletions: _, insertions: _, modifications: _): objectWillChange.send()
            case.error: break
            }
            
        }
    }
    
    // MARK: Variables
    @Published var showGroupList = false
    
    // MARK: Functions
    func addNewWordGroup(groupName:String, wordLanguage: String, meaningLanguage: String) {
        if groupName != "" {
            let newWordGroup = WordGroup(groupName: groupName, startLanguage: wordLanguage, targetLanguage: meaningLanguage)
            try? self.realm!.write {
                self.realm!.add(newWordGroup)
            }
        }
    }
    
    func deleteWordGroup(at indexSet: IndexSet) {
        
        if let index = indexSet.first,
           let realm = wordGroups![index].realm {
            try? realm.write {
                realm.delete(wordGroups![index].words)
                realm.delete(wordGroups![index])
            }
        }
    }
    
    func editWordGroup(groupPK: String) {
        
    }
}
