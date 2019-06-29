//
//  AnsweringToggleButton.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 30.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct AnsweringToggleButton : View {
    @Binding var answering: Bool
    var body: some View {
        Button(action: {
            withAnimation {
                self.answering.toggle()
            }
        }) {
            Text(!answering ? "Вписать решение" : "Отменить").padding(10)
        }
    }
}

#if DEBUG
struct AnsweringToggleButton_Previews : PreviewProvider {
    static var previews: some View {
        AnsweringToggleButton(answering: .constant(false))
    }
}
#endif
