//
//  임시코드저장소.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/21.
//

import Foundation

//                    Section(header: Text("Memorized")) {
//                        ForEach(self.wordListViewModel.words.filter { word in word.isMemorized && !word.isDeleted}) { word in
//                            HStack {
//                                Text(word.word)
//                                Button(action: { wordListViewModel.dememorizeWord(wordDememorized: word) }, label: {Text("Dememorized")})
//                                Button(action: { wordListViewModel.deleteWord(word: word) }, label: {Text("Delete")})
//                            }
//                        }
//                    }


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


// freeze를 통해 리스트를 얼릴경우 내용을 수정하고 싶을 때 resolve 해줘여함.
// Button(action: { wordListViewModel.deleteWord(word: wordListViewModel.realm!.resolve(ThreadSafeReference(to: word))!) }, label: {Text("Delete")})

//토큰 옵저빙
//        token = selectedWordGroup?.observe { changes in
//            switch changes {
//            case .error(_): break
//            case .change(_, _): self.objectWillChange.send()
//            case .deleted: self.selectedWordGroup = nil
//            }
//        }


// 삭제버튼
//Button(action: { isGroupDeleteAlertPresented.toggle() }, label: {Text("Delete").foregroundColor(.red)})
//    .alert(isPresented: $isGroupDeleteAlertPresented) {
//        Alert(title: Text("Delete Group"),
//              message: Text("Are you sure? All Words incloud in the trash will be permanantly deleted"),
//              primaryButton: .destructive(Text("Yes"), action: {}),
//              secondaryButton: .cancel())
//    }
