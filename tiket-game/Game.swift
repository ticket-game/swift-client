//
//  Game.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 24.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct Game : View {
    var numset: [Int]
    var possibleAnswerCounts: Int
    @State private var answers: [Answer] = []
    @State private var answering = false
    @State private var operators = ["", "", "", "", "", "", ""]
    @State private var error = false
    @State private var message = ""
    @State private var result = 0
    var body: some View {
        ZStack{
            VStack {
                Text(String(answers.count) + "/" + String(possibleAnswerCounts) + " решений найдено")
                AnswerField(operators: $operators, numset: self.numset, answering: answering).padding(20)
                if error {
                    Text("Решение не верное,\n результат выражения = \(self.result)").color(.red).multilineTextAlignment(.center).lineLimit(3)
                }
                HStack {
                    if answering {
                        Button(action: {
                            withAnimation {
                                self.tryAnswer()
                            }
                        }) {
                            Text("Готово").padding(10)
                        }
                    }
                    Button(action: {
                        withAnimation {
                            self.answering.toggle()
                        }
                    }) {
                        Text(!answering ? "Вписать решение" : "Отменить").padding(10)
                    }
                }
                
            }
            if message != "" {
                ModalView(text: self.message, onDismiss: handleCloseModal).zIndex(100)
            }
        }
    }
    
    public func handleCloseModal() {
        self.message = ""
    }
    
    private func tryAnswer() {
        do {
            let variant = try Answer(operators: self.operators, numset: self.numset)
            if IsUniqAnswer(variant: variant, answers: self.answers) {
                self.result = try checkAnswer(variant: variant)!
                if self.result == 100 {
                    self.answers.append(variant)
                    self.error = false
                } else {
                    self.error = true
                }
                self.operators = ["", "", "", "", "", "", ""]
                self.answering.toggle()
            } else {
                self.message = "It's not unique variant"
            }
        } catch {
            self.message = error.localizedDescription
            print(error)
        }
    }
}

#if DEBUG
struct Game_Previews : PreviewProvider {
    static var previews: some View {
        Game(numset: [4,3,5,9,8,7], possibleAnswerCounts: 10)
    }
}
#endif
