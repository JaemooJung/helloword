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
        self.words = results.compactMap { (word) -> Word? in
            return word
        }
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
    
    // TODO: 코드 다시짜기... 삭제 -> self.words에서 word 검색한 후 그 word의 isDeleted 값을 변경하는 식으로...
    // 단어 삭제
    func deleteWord(at offset: IndexSet) {
        guard let dbRef = try? Realm() else { return }
        let wordToDelete = offset.map { self.words.reversed()[$0] }
        _ = wordToDelete.compactMap { word in
            try! dbRef.write {
                word.isDeleted = true
            }
            fetchData()
        }
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
    
    // 외운 단어로 표시
    
}
