//
//  ContentView.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/19.
//

import SwiftUI
import RealmSwift

struct WordListView: View {
    
    //MARK: Variables
    
    @ObservedObject var wordListViewModel = WordListViewModel()
    @StateObject var wordGroupListViewModel = WordGroupListViewModel()
    @State var newWord:String = ""
    
    let screenBound = UIScreen.main.bounds
    
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
    
    //MARK: Body
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            // 그룹 View
            WordGroupView()
            
            // 단어장 View
            NavigationView {
                VStack {
                    // 텍스트 입력 부분
                    addNewWordTextInput.padding()
                    
                    // 안외운단어
                    SwiftUI.List {
                        ForEach(self.wordListViewModel.words.reversed().filter { word in !word.isMemorized && !word.isDeleted }) { word in
                            HStack {
                                Text(word.word)
                                Spacer()
                                Button(action: { wordListViewModel.markMemorize(word: word) }, label: {Text("Memorized")})
                                Button(action: { wordListViewModel.deleteWord(word: word) }, label: {Text("Delete")})
                            }
                        }.buttonStyle(BorderlessButtonStyle())
                        
                    // 외운단어
                        Section(header: Text("Memorized")) {
                            ForEach(self.wordListViewModel.words.filter { word in word.isMemorized && !word.isDeleted}) { word in
                                HStack {
                                    Text(word.word)
                                    Spacer()
                                    Button(action: { wordListViewModel.markMemorize(word: word) }, label: {Text("Dememorized")})
                                    Button(action: { wordListViewModel.deleteWord(word: word) }, label: {Text("Delete")})
                                }
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                .navigationBarTitle(self.wordListViewModel.selectedWordGroup?.groupName ?? "somethinggoeswrong")
                .navigationBarItems(
                    leading: Button(action:{ withAnimation(.easeInOut) { wordGroupListViewModel.showGroupList.toggle() }},
                                    label: { Image(systemName: "line.horizontal.3")}),
                    trailing: EditButton()
                )
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(x: wordGroupListViewModel.showGroupList ? UIScreen.main.bounds.maxX/2 : -UIScreen.main.bounds.maxX/2)
        .environmentObject(wordGroupListViewModel)
        .environmentObject(wordListViewModel)
    }
    
    //MARK: Functions
    
    
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView()
    }
}
