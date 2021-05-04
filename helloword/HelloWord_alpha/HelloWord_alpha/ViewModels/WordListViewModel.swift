//
//  WordListViewModel.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/19.
//

import Foundation
import Combine
import RealmSwift

class WordListViewModel: ObservableObject {
    
    //MARK: Model
    
    @Published var selectedWordGroup: WordGroup? = nil
    @Published var words = List<Word>()
    
    //MARK: Variables
    
    var lastWordGroupPrimaryKey:String = "" {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "lastWordGroupPrimaryKey")
        }
    }
    
    //MARK: Token
    
    var token: NotificationToken? = nil
    
    //MARK: init

    var realm: Realm?
    
    init() {
        
        let realm = try? Realm()
        self.realm = realm
        
        let pk = UserDefaults.standard.string(forKey: "lastWordGroupPrimaryKey") ?? ""
        
        if changeWordGroupAndWordList(groupPK: pk, realm: realm) == false {
            let newGroup = WordGroup(groupName: "Words", startLanguage: "English", targetLanguage: "Korean")
            try? realm?.write {
                realm?.add(newGroup)
                newGroup.words.append(Word(newWord: "Hello"))
            }
            _ = changeWordGroupAndWordList(groupPK: newGroup._id, realm: realm)
            UserDefaults.standard.set(newGroup._id, forKey: "lastWordGroupPrimaryKey")
        }
        

    }
    
    //MARK: Functions
    
    func changeWordGroupAndWordList(groupPK: String, realm: Realm?) -> Bool {
        if let oldToken = self.token {
            // 옵저빙이 끝났으면 이전 토큰은 프리 해줘야 함.
            oldToken.invalidate()
        }
        if let newWordGroup = realm?.object(ofType: WordGroup.self, forPrimaryKey: groupPK) {
            self.selectedWordGroup = newWordGroup
            self.words = newWordGroup.words
            token = selectedWordGroup?.words.observe { changes in
                switch changes {
                case .error(_): break
                case .initial(_): break
                case .update(_, deletions: _, insertions: _, modifications: _): self.objectWillChange.send()
                }
            }
            return true
        } else {
            return false
        }
    }
    
    //MARK: Intents
    
    // 단어 추가
    func addNewWord(newWord: String) {
        if newWord != "" {
            if let realm = selectedWordGroup?.realm {
                try? realm.write {
                    selectedWordGroup?.words.append(Word(newWord: newWord))
                }
            }
        }
    }
    
    // 외운 단어/안 외운 단어 전환
    func markMemorize(word: Word) {
        word.markMemorized()
    }
    
    // 단어 삭제
    func deleteWord(word: Word) {
        word.markDeleted()
    }
    
}
