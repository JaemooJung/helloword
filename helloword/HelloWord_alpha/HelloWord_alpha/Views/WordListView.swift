//
//  ContentView.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/19.
//

import SwiftUI

struct WordListView: View {
    
    //MARK: Variables
    
    @ObservedObject var wordListViewModel: WordListViewModel = WordListViewModel()
    @State var newWord:String = ""
    
    //MARK: Subviews
    
    var addNewWordTextInput: some View {
        HStack {
            TextField("Add a new word", text: self.$newWord)
            Button(action: {
                wordListViewModel.addNewWord(newWord: newWord)
                self.newWord = ""
            }, label: {
                Text("Add Word")
            })
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                addNewWordTextInput.padding()
                List {
                    ForEach(self.wordListViewModel.words.reversed().filter { word in !word.isDeleted }) { word in
                        HStack {
                            Text(word.word)
                        }
                    }
                    // custom delete 만들기. edit 모드도!!
                    .onDelete(perform: wordListViewModel.deleteWord)
                }
            }
            .navigationBarTitle("WORDS")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView()
    }
}
