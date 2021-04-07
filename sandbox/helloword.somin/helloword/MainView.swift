//
//  ContentView.swift
//  helloword
//
//  Created by JaemooJung on 2021/04/04.
//

import SwiftUI
import Combine

struct MainView: View {
    @EnvironmentObject var modelData : DBViewModel
    @ObservedObject var wordViewModel = WordViewModel()
    @State var newWord: String = ""
    
    var addNewWordTextInput: some View {
        HStack {
            TextField("Add a new word",
                      text: $modelData.name)
            Button(action: modelData.addData(presentation: Presentation), label: {
               Text("Add Word")
           })
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                addNewWordTextInput.padding()
                List {
                    ForEach(modelData.words) {
                        word in
                        Text(word.name)
                    }.onMove(perform: self.move)
                    .onDelete(perform: self.delete)
                }.listStyle(GroupedListStyle())
                .navigationBarTitle("TOEIC")
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
    .onDisappear(perform:modelData.deInitData)
    
//    func addNewWord() {
//        if newWord != "" {
//            wordViewModel.words.append(Word(word: newWord))
//        }
//        newWord = ""
//    }
    
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
