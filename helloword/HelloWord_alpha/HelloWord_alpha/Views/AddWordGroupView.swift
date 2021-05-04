//
//  AddWordGroupView.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/22.
//

import SwiftUI

struct AddWordGroupView: View {
    
    @EnvironmentObject var wordGroupListViewModel: WordGroupListViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var groupName:String = ""
    @State var wordLanguage:String = ""
    @State var meaningLanguage:String = ""
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Form {
                    Section(header: Text("Group Name")) {
                        TextField("group name here", text: $groupName)
                    }
                    Section(header: Text("Word Language")) {
                        TextField("word language here", text: $wordLanguage)
                    }
                    Section(header: Text("Meaning Language")) {
                        TextField("meaning language here", text: $meaningLanguage)
                    }
                    
                }
                Button(action: {
                    self.wordGroupListViewModel.addNewWordGroup(groupName: groupName, wordLanguage: wordLanguage, meaningLanguage: meaningLanguage)
                    self.presentationMode.wrappedValue.dismiss()
                },
                       label: {
                    Text("Done")
                })
            }
            .navigationTitle("Add new word group")
            .navigationBarItems(trailing: Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                Text("Cancel").foregroundColor(.red)
            })
            )
        }
    }
}

struct AddWordGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AddWordGroupView()
    }
}
