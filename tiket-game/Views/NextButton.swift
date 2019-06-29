//
//  NextButton.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 30.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct NextButton : View {
    var action: () -> Void
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                withAnimation {
                    self.action()
                }
            }) {
                Text("Следующий").multilineTextAlignment(.trailing).padding(10)
            }
        }
    }
}

func mockAction(){}

#if DEBUG
struct NextButton_Previews : PreviewProvider {
    static var previews: some View {
        NextButton(action: mockAction)
    }
}
#endif
