//
//  AnswerConfirmButton.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 30.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct AnswerConfirmButton : View {
    var action: ()-> Void
    var body: some View {
        Button(action: {
            withAnimation {
                self.action()
            }
        }) {
            Text("Готово").padding(10)
        }
    }
}

#if DEBUG
struct AnswerConfirmButton_Previews : PreviewProvider {
    static var previews: some View {
        AnswerConfirmButton(action: mockAction)
    }
}
#endif
