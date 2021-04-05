//
//  ContentView.swift
//  helloword
//
//  Created by JaemooJung on 2021/04/04.
//

import SwiftUI
import Combine

struct MainView: View {
    @ObservedObject var wordViewModel = WordViewModel()
    @State var newWord: String = ""
    
    var addNewWordTextInput: some View {
        HStack {
            TextField("Add a new word",
                      text: self.$newWord)
            Button(action: self.addNewWord, label: {
                Text("Add Word")
            })
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                addNewWordTextInput.padding()
                List {
                    ForEach(self.wordViewModel.words) {
                        word in
                        Text(word.word)
                    }.onMove(perform: self.move)
                    .onDelete(perform: self.delete)
                }.listStyle(GroupedListStyle())
                .navigationBarTitle("TOEIC")
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
    
    func addNewWord() {
        if newWord != "" {
            wordViewModel.words.append(Word(word: newWord))
        }
        newWord = ""
    }
    
    func move(from source: IndexSet, to destination: Int) {
        wordViewModel.words.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets: IndexSet) {
        wordViewModel.words.remove(atOffsets: offsets)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
