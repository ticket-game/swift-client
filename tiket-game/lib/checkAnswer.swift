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

let rightOperators = ["*": 11, ":": 12, "/": 12, "+": 13, "-": 14, "(": 15, ")": 16, "^": 17]

func checkAnswer(variant: Answer) throws -> Int? {
    var exp: [Int] = []
    for i in 0...6 {
        exp += try mapCharToInt(op: variant.operators[i])
        if i != 6 {
            exp.append(variant.numset[i])
        }
    }
    let calc = Calculator();
    return try calc.Calculate(expression: exp);
}

func mapCharToInt(op: String) throws -> Array<Int> {
    var exp: [Int] = []
    for ch in Array(op) {
        if let opCode = rightOperators[String(ch)] {
            exp.append(opCode)
        } else {
            throw CheckAnswerErrors.wrongOperator(operator: ch)
        }
    }
    return exp;
}
