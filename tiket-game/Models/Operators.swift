//
//  Operators.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 23.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import Foundation

struct Operators {
    var value: [Operator]
    static let `default` = Self()
    init() {
        self.value = []
        for index in 0...6 {
            self.value.append(Operator(index: index))
        }
    }
}

struct Operator {
    var index: Int
    var value: String
    static let `default` = Self(index: 0)
    init(index: Int){
        self.value = ""
        self.index = index
    }
}
