//
//  Game.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 24.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct Game : View {
    var numset: String
    var possibleAnswerCounts: Int
    @State var answered = 0
    @State private var answering = false
    @State private var operators = ["", "", "", "", "", "", ""]
    var body: some View {
        VStack {
            Text(String(answered) + "/" + String(possibleAnswerCounts) + " решений найдено")
            AnswerField(numset: Array(self.numset), answering: answering).padding(20)
            HStack {
                if answering {
                    Button(action: {
                        withAnimation {
                            self.answering.toggle()
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
    }
}

#if DEBUG
struct Game_Previews : PreviewProvider {
    static var previews: some View {
        Game(numset: "435987", possibleAnswerCounts: 10)
    }
}
#endif
