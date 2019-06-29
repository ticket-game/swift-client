//
// Created by Andrew Khasanov on 2019-06-28.
// Copyright (c) 2019 Andrew Khasanov. All rights reserved.
//

import Foundation

struct Answer {
    public var operators: [String]
    public var numset: [Int]
    
    public enum AnswerError: Error {
        case wrongNumsetLen(count : Int)
        case wrongOperatorsLen(count : Int)
    }

    init(operators: [String], numset: [Int]) throws {
        if numset.count != 6 {
            throw AnswerError.wrongNumsetLen(count: numset.count)
        }
        if operators.count != 7 {
            throw AnswerError.wrongOperatorsLen(count: operators.count)
        }
        self.operators = operators
        self.numset = numset
    }

    public func Compare(answer: Answer) -> Bool {
        for i in 0...6 {
            if self.operators[i] != answer.operators[i] {
                return false
            }
        }
        for i in 0...5 {
            if self.numset[i] != answer.numset[i] {
                return false
            }
        }
        return true
    }
}

func IsUniqAnswer(variant: Answer, answers: [Answer]) -> Bool {
    for answer in answers {
        if variant.Compare(answer: answer) {
            return false
        }
    }
    return true
}
