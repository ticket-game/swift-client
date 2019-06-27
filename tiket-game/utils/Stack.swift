//
// Created by Andrew Khasanov on 2019-06-26.
// Copyright (c) 2019 Andrew Khasanov. All rights reserved.
//

import Foundation

class Stack<T> {
    fileprivate var array: [T]
    init() {
        array = []
    }

    func count() -> Int {
        array.count
    }

    func push(_ element: T) {
        array.append(element)
    }

    func pop() -> T? {
        array.popLast()
    }

    func peek() -> T? {
        array.last
    }

    func any() -> Bool {
        array.count > 0
    }
}
