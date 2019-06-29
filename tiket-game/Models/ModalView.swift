//
//  Modal.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 28.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct ModalView: View {
    var text: String
    var onDismiss: () -> Void
    var body: some View {
        VStack(alignment: .center) {
            Text(text)
                .color(.black).lineLimit(5)
                .padding(.bottom)
            Button(action: {
                withAnimation {
                    self.onDismiss()
                }
            }
            ) {
                Text("Ок")
            }
        }.padding(10).background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0), cornerRadius: 5.0).border(Color(red: 0, green: 0, blue: 10.0 / 255.0, opacity: 0.6), cornerRadius: 5.0)
    }
}

#if DEBUG
struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(text: "test", onDismiss: testDismiss)
    }
}
#endif

func testDismiss() {
    print("dismiss")
}
