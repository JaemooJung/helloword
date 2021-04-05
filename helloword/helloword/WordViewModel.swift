//
//  File.swift
//  helloword
//
//  Created by JaemooJung on 2021/04/04.
//

import SwiftUI
import Combine

class WordViewModel: ObservableObject {
    @Published var words = [Word]()
}
