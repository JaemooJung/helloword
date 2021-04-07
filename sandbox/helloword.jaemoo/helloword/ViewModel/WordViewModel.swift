//
//  File.swift
//  helloword
//
//  Created by JaemooJung on 2021/04/04.
//

import SwiftUI
import Combine

class WordViewModel: ObservableObject {
    @Published var model: HelloWordModel = HelloWordModel()
    
    // MARK: Access to the model
    var wordList: Array<HelloWordModel.Word> {
        model.wordList
    }
    
    // MARK: Intents
    func addNewWord(newWord: String) {
        model.addNewWord(newWord: newWord)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        model.wordList.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets: IndexSet) {
        model.wordList.remove(atOffsets: offsets)
    }
    
    func markWordIsMemorized(word: HelloWordModel.Word) {
        model.markWordIsMemorized(word: word)
    }
    
    func markWordIsNotMemorized(word: HelloWordModel.Word) {
        model.markWordIsNotMemorized(word: word)
    }
}
