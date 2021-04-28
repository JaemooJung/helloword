//
//  File.swift
//  HelloWord_alpha
//
//  Created by JaemooJung on 2021/04/27.
//

import Foundation
import RealmSwift

extension Results {
    var list: List<Element> {
        reduce(.init()) { list, element in
            list.append(element)
            return list
        }
    }
}
