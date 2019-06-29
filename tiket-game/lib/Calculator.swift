//
// Created by Andrew Khasanov on 2019-06-26.
// Copyright (c) 2019 Andrew Khasanov. All rights reserved.
//

import Foundation

class Calculator {
    public enum OpCode: Int {
        case Invalid = 10, Mul, Div, Add, Sub, OpenBracket, CloseBracket
    }

    public enum CalculatorError: Error {
        case InvalidOperationException(OpCode)

        case InvalidDataException
    }

    private var _numStack: Stack<Int>;
    private var _opStack: Stack<OpCode>;

    init() {
        _opStack = Stack();
        _numStack = Stack();
    }

    private func ToOperation(s: Int) -> OpCode {
        if (s < 10) {
            return OpCode.Invalid;
        }
        return OpCode(rawValue: s)!;
    }

    private func Priority(op: OpCode) throws -> Int {
        switch (op) {
        case OpCode.OpenBracket, OpCode.CloseBracket:
            return 0;

        case OpCode.Sub, OpCode.Add:
            return 1;

        case OpCode.Div, OpCode.Mul:
            return 2;
        default:
            throw CalculatorError.InvalidOperationException(op);
        }
    }

    private func ProcessOp(opCode: OpCode) throws {
        guard let num2 = _numStack.pop() else {
            throw CalculatorError.InvalidDataException;
        };
        guard let num1 = _numStack.pop() else {
            throw CalculatorError.InvalidDataException;
        }
        switch (opCode) {
        case .Mul:
            _numStack.push(num1 * num2);
            break;
        case .Div:
            _numStack.push(num1 / num2);
            break;
        case .Add:
            _numStack.push(num1 + num2);
            break;
        case .Sub:
            _numStack.push(num1 - num2);
            break;
        case .Invalid, .OpenBracket, .CloseBracket:
            break;
        }
    }

    public func Calculate(expression: Array<Int>) throws -> Int? {
        var accum = 0;
        var flag = false;
        for symbol in expression {
            let op = ToOperation(s: symbol);

            if (op != OpCode.Invalid) {
                if (flag) {
                    _numStack.push(accum);
                    accum = 0;
                    flag = false;
                }

                if (op == OpCode.OpenBracket) {
                    _opStack.push(OpCode.OpenBracket);
                    continue;
                }

                if (op == OpCode.CloseBracket) {
                    while _opStack.peek() != OpCode.OpenBracket {
                        try ProcessOp(opCode: _opStack.pop()!);
                    }
                    _ = _opStack.pop();
                    continue;
                }


                let priority = try Priority(op: op);
                while try _opStack.any() && Priority(op: _opStack.peek()!) > priority {
                    try ProcessOp(opCode: _opStack.pop()!);
                }
                _opStack.push(op);
            } else if (symbol < 10) {
                accum *= 10;
                accum += symbol;
                flag = true;
            }
        }

        if (flag) {
            _numStack.push(accum);
        }

        while (_opStack.any()) {
            try ProcessOp(opCode: _opStack.pop()!);
        }

        let count = _numStack.count();

        if (count != 1) {
            throw CalculatorError.InvalidDataException;
        }
        return _numStack.pop();
    }
}

