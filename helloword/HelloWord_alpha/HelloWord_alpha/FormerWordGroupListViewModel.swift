//
//  groupListViewModel.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/21.
//

//import SwiftUI
//import Combine
//import RealmSwift
//
//class WordGroupListViewModel: ObservableObject {
//    // MARK: Model
//    @Published var wordGroups: [WordGroup] = []
//
//    //MARK: init
//    private var realm = try? Realm()
//
//    init() {
//        fetchData()
//    }
//
//    // MARK: Variables
//    @Published var showGroupList = false
//
//    // MARK: Functions
//
//    func fetchData() {
//        let results = self.realm!.objects(WordGroup.self)//.sorted(byKeyPath: "registeredDate", ascending: false)
//        //compactMap: 어레이에서 Nil을 제거해주고 옵셔널바인딩으로 묶어줌...
//        let wordGroups = results.compactMap { (WordGroup) -> WordGroup? in
//            return WordGroup
//        }
//        self.wordGroups = Array(wordGroups)
//    }
//
//    func addNewWordGroup(groupName:String, wordLanguage: String, meaningLanguage: String) {
//        if groupName != "" {
//            let newWordGroup = WordGroup(groupName: groupName, startLanguage: wordLanguage, targetLanguage: meaningLanguage)
//            try? self.realm!.write {
//                self.realm!.add(newWordGroup)
//                fetchData()
//            }
//        }
//    }
//
//    func deleteWordGroup(groupToDelete: WordGroup) {
//
//        if let index = wordGroups.firstIndex(of: groupToDelete) {
//            wordGroups.remove(at: index)
//        }
//        if let realm = groupToDelete.realm {
//            try? realm.write{
//                realm.delete(groupToDelete.words)
//                realm.delete(groupToDelete)
//            }
//        }
////        fetchData()
//    }
//
//    func editWordGroup(groupPK: String) {
//
//    }
//}
