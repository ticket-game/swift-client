//
//  checkAnswer.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 24.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import Foundation

enum CheckAnswerErrors: Error {
    case wrongOperator(operator : Character)
}

let rightOperators = ["*", ":", "/", "^", "+", "-", "(", ")"]

func checkAnswer(numset: String, operators: [String]) throws -> String {
    for op in operators {
        try validateOperator(op: op)
    }
    return "";
}

func validateOperator(op: String) throws {
    for ch in Array(op) {
        var right = false
        for opVariant in rightOperators {
            if String(ch) == opVariant {
                right = true
            }
        }
        if !right {
            throw CheckAnswerErrors.wrongOperator(operator: ch)
        }
    }
}
