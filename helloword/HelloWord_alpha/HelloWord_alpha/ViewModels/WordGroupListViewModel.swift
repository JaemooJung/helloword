//
//  groupListViewModel.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/21.
//

import SwiftUI
import Combine
import RealmSwift

class WordGroupListViewModel: ObservableObject {
    // MARK: Model
    @Published var wordGroups: [WordGroup] = []

    //MARK: init
    init() {
        fetchData()
    }
    
    // MARK: Variables
    @Published var showGroupList = false
    
    // MARK: Functions
    
    func fetchData() {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(WordGroup.self)
        //compactMap: 어레이에서 Nil을 제거해주고 옵셔널바인딩으로 묶어줌...
        let wordGroups = results.compactMap { (WordGroup) -> WordGroup? in
            return WordGroup
        }
        self.wordGroups = Array(wordGroups)
    }
    
    func addNewWordGroup(groupName:String, wordLanguage: String, meaningLanguage: String) {
        if groupName != "" {
            let newWordGroup = WordGroup(groupName: groupName, startLanguage: wordLanguage, targetLanguage: meaningLanguage)
            guard let dbRef = try? Realm() else { return }
            try? dbRef.write {
                dbRef.add(newWordGroup)
                fetchData()
            }
        }
    }
}
