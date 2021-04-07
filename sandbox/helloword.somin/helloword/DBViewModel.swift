//
//  DBViewModel.swift
//  helloword
//
//  Created by 박소민 on 2021/04/07.
//

import SwiftUI
import RealmSwift

class DBViewModel: ObservableObject{
    //Data
    
    @Published var name = ""
    @Published var wordmeaing = ""
    
    @Published var words : [Word] = []
    
    init() {
        fetchData()
    }
    
    func fetchData(){
        
        guard let dbRef = try? Realm() else{return}
        
        let results = dbRef.objects(Word.self)
        
        self.words =. results.compactMap({ (word) -> Word? in return word})
    }
    func addData(presentation: Binding<PresentationMode>){
        
        let word = Word()
        word.name = name
        word.wordmeaning = wordmeaing
        
        guard let dbRef = try? Realm() else{return}
        
        //writing Data
        
        try? dbRef.write{
            
            dbRef.add(word)
            
            //update UI
            fetchData()
        }
        //closing View
        presentation.wrappedValue.dismiss()
        
        //setting and clearing data
        
        func setUPInitialData(){
            
        }
        
        func deInitData(){
            name = ""
            wordmeaing=""
        }
        
    }
}
