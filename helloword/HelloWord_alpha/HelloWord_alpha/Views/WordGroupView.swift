//
//  WordGroupView.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/21.
//

import SwiftUI

struct WordGroupView: View {
    
    @EnvironmentObject var wordGroupListViewModel: WordGroupListViewModel
    @State var isAddWordGroupViewPresented: Bool = false

    let screenBound = UIScreen.main.bounds
    
    var body: some View {

        NavigationView {
            VStack {
                List {
                    ForEach(self.wordGroupListViewModel.wordGroups) { wordGroup in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(wordGroup.startLanguage) -> \(wordGroup.targetLanguage)").font(.caption).padding(.top)
                                Text(wordGroup.groupName).font(.largeTitle).bold().padding(.bottom)
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                }
            }
            .navigationBarTitle("Groups")
            .navigationBarItems(
                leading: Button(action: { self.isAddWordGroupViewPresented = true },
                                label: { Image(systemName: "plus")})
                    .sheet(isPresented: self.$isAddWordGroupViewPresented, content: { AddWordGroupView().environmentObject(wordGroupListViewModel) }),
                trailing: Button(action: { withAnimation(.easeInOut) { wordGroupListViewModel.showGroupList.toggle() }},
                                 label: { Image(systemName: "chevron.right")
                                    .foregroundColor(.blue)})
            )
        }
        .frame(width: screenBound.width)
    }
}

struct WordGroupView_Previews: PreviewProvider {
    
    static var previews: some View {
        WordGroupView().environmentObject(WordGroupListViewModel())
    }
}
