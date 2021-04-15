//
//  ContentView.swift
//  helloword
//
//  Created by JaemooJung on 2021/04/04.
//

import SwiftUI

struct MainView: View {
    
    //MARK: Variables
    
    // 뷰에 데이터를 뿌려줄 뷰모델 선언
    @ObservedObject var wordViewModel = WordViewModel()
    @State var newWord: String = ""
    
    
    //MARK: Subviews
    
    var addNewWordTextInput: some View {
        
        HStack {
            TextField("Add a new word",
                      text: self.$newWord)
            Button(action: {
                wordViewModel.addNewWord(newWord: newWord)
                self.newWord = ""
            }, label: {
                Text("Add Word")
            })
        }
        
    }
    
    //TODO: 단어의 정렬 바꾸기 -> 안 외운건 추가한 순서대로, 외운건 외웠다고 표시한 순서대로
    
    //MARK: Body
    var body: some View {
        NavigationView {
            VStack {
                addNewWordTextInput.padding()
                List {

                    ForEach(self.wordViewModel.wordList.reversed().filter { word in !word.isMemorized } ) { word in
                        HStack {
                            Text(word.word)
                            //TODO: 이 부분 스와이프 제스쳐로 바꾸기
                            Button(action: { wordViewModel.markWordIsMemorized(word: word) }, label: { Text("") })
                            // _______________________
                        }
                        
                    }.onMove(perform: wordViewModel.move)
                    .onDelete(perform: wordViewModel.delete)

                    //TODO: 기본적으로 접힌 상태로 보이게 바꾸기
                    Section(header: Text("Memorized")) {
                        ForEach(self.wordViewModel.wordList.filter { word in word.isMemorized }) { word in
                            
                            HStack {
                                Text(word.word)
                                //TODO: 이 부분 스와이프 제스쳐로 바꾸기
                                Button(action: { wordViewModel.markWordIsNotMemorized(word: word) }, label: { Text("") })
                                //________________
                            }
                            
                        }.onMove(perform: wordViewModel.move)
                        .onDelete(perform: wordViewModel.delete)
                    }
                    
                }
                .navigationBarTitle("WORDS")
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
    
    //MARK: Functions
    
}


//MARK: Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
