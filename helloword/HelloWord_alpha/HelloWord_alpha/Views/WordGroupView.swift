//
//  WordGroupView.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/21.
//

import SwiftUI

struct WordGroupView: View {
    
    @EnvironmentObject var wordGroupListViewModel: WordGroupListViewModel
    @EnvironmentObject var wordListViewModel: WordListViewModel
    // 이렇게 editmode 변수를 생성하고 editmode 버튼이랑 기타등등 이걸 사용할 함수들에 .environment로 적용해줘야함....
    @State private var editMode: EditMode = .inactive
    
    @State var isAddWordGroupViewPresented: Bool = false
    
   // @State var isGroupDeleteAlertPresented: Bool = false

    let screenBound = UIScreen.main.bounds
    
    var body: some View {

        NavigationView {
            VStack {
                List {
                    ForEach(wordGroupListViewModel.wordGroups!.freeze()) { wordGroup in
                        HStack {
                            VStack(alignment: .leading) {
                                // 출발어 도착어 텍스트
                                Text("\(wordGroup.startLanguage) -> \(wordGroup.targetLanguage)")
                                    .font(.caption)
                                    .padding(.top)
                                // 그룹 이름 텍스트
                                Text(wordGroup.groupName)
                                    .font(.largeTitle)
                                    .bold()
                                    .padding(.bottom)
                            }
                            Spacer()
                            // 네비게이션 이동을 위한 버튼
                            Button(action: {
                                    _ = wordListViewModel.changeWordGroupAndWordList(groupPK: wordGroup._id, realm: wordListViewModel.realm)
                                    wordListViewModel.lastWordGroupPrimaryKey = wordGroup._id
                                    withAnimation(.easeInOut) {
                                        wordGroupListViewModel.showGroupList.toggle()
                                    }
                            }, label: {})
                            // edit 버튼
                            if (self.editMode.isEditing) {
                                Button {
                                    print("\(self.editMode.isEditing)")
                                } label: {
                                    Text("Edit")
                                }.buttonStyle(BorderlessButtonStyle())
                                .padding()
                                .foregroundColor(.yellow)
                            }
                        }
                    }.onDelete(perform: { indexSet in
                            wordGroupListViewModel.deleteWordGroup(at: indexSet)
                    }
                    ).deleteDisabled(!self.editMode.isEditing)
                    .environment(\.editMode, self.$editMode)
                    //휴지통 뷰로 연결
//                    Group {
//                        Button(action: {}, label: {Text("Trash")})
//                    }
                }
                
            }
            .navigationBarTitle("Groups")
            .navigationBarItems(
                leading: HStack {
                    // 새 그룹 추가 버튼
                    Button(action: { self.isAddWordGroupViewPresented = true },
                                label: { Image(systemName: "plus") }
                    )
                    .sheet(isPresented: self.$isAddWordGroupViewPresented, content: { AddWordGroupView().environmentObject(wordGroupListViewModel) })
                    // 그룹 수정 버튼
                    EditButton()
//                    Button(action: {
//                        withAnimation(.easeInOut) {
//                            self.isEditing.toggle()
//                        }
//                    },
//                           label: {if self.isEditing { Text("Done").foregroundColor(.orange) } else { Text("Edit") } }
//                    )
                },
                // 돌아가기 버튼
                trailing: Button(action: { withAnimation(.easeInOut) { wordGroupListViewModel.showGroupList.toggle() }},
                                 label: { Image(systemName: "chevron.right")
                                    .foregroundColor(.blue)})
            ).environment(\.editMode, self.$editMode)
        }
        .frame(width: screenBound.width)
    }
}

struct WordGroupView_Previews: PreviewProvider {
    
    static var previews: some View {
        WordGroupView().environmentObject(WordGroupListViewModel())
    }
}
