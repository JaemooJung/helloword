//
//  File.swift
//  helloword
//
//  Created by JaemooJung on 2021/04/04.
//

import SwiftUI

struct Word: Identifiable {
    var id = UUID()
    var word: String
    var wordMeaning: String = ""
    var isMemorized: Bool = false
}
