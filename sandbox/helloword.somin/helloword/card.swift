//
//  card.swift
//  helloword
//
//  Created by 박소민 on 2021/04/07.
//

import SwiftUI
import RealmSwift

//Creating Realm Object

class Word: Object,Identifiable {
    
    @objc dynamic var id : Date = Date()
    @objc dynamic var name = ""
    @objc dynamic var wordmeaning = ""
}
