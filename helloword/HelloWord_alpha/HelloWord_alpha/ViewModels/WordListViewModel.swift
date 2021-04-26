//
//  WordListViewModel.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/19.
//

import SwiftUI
import Combine
import RealmSwift

class WordListViewModel: ObservableObject {
    //MARK: Model
    
    // WordListView에 뿌릴 words 선언
    @Published var words: [Word] = []

    //MARK: init
    
    init() {
        fetchData()
    }

    //MARK: Functions
    
    // DB에서 단어 받아오기
    func fetchData() {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(Word.self)
        //compactMap: 어레이에서 Nil을 제거해주고 옵셔널바인딩으로 묶어줌...
        let words = results.compactMap { (word) -> Word? in
            return word
        }
        self.words = Array(words).reversed()
    }
    
    // 단어 추가
    func addNewWord(newWord: String) {
        if newWord != "" {
            let word = Word(newWord: newWord)
            guard let dbRef = try? Realm() else { return }
            try? dbRef.write {
                dbRef.add(word)
                fetchData()
            }
        }
    }
    
    // 외운 단어로 표시
    func memorizeWord(wordMemorized: Word) {
        guard let dbRef = try? Realm() else { return }
        try! dbRef.write {
            wordMemorized.isMemorized = true
        }
        fetchData()
    }
    
    // 안 외운 단어로 표시
    func dememorizeWord(wordDememorized: Word) {
        guard let dbRef = try? Realm() else { return }
        try! dbRef.write {
            wordDememorized.isMemorized = false
        }
        fetchData()
    }
    
    // 단어 삭제
    func deleteWord(word: Word) {
        guard let dbRef = try? Realm() else { return }
        try! dbRef.write {
            word.isDeleted = true
        }
        fetchData()
    }
    
    
    
    
    
    
    
    
// 단어 삭제와 관련된 구 코드
//    func deleteWord(at offset: IndexSet) {
//        guard let dbRef = try? Realm() else { return }
//        let wordToDelete = offset.map { self.words.reversed()[$0] }
//        _ = wordToDelete.compactMap { word in
//            try! dbRef.write {
//                word.isDeleted = true
//            }
//            fetchData()
//        }
// 2번 옵션
//        guard let dbRef = try? Realm() else { return }
//        let ids = offset.map { self.words.reversed()[$0].id }
//        let wordToDelete = dbRef.objects(Word.self).filter("id IN %@", ids)
//        try! dbRef.write {
//            dbRef.delete(wordToDelete)
//            fetchData()
//        }
        
        // 1번 옵션
//        _ = wordToDelete.compactMap{ word in
//            try! dbRef.write {
//                dbRef.delete(
//                fetchData()
//            }
//        }

    
}
