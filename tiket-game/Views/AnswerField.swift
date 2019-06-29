//
//  experiment.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 24/06/2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct AnswerField : View {
    @Binding var operators: [String]
    var numset: [Int]
    var answering: Bool
    var body: some View {
        HStack {
            ForEach(0..<7) { index in
                if self.answering {
                    TextField(self.$operators[index], placeholder: Text("...")).tag(index).padding(2)
                }
                if (index != 6) {
                    Text(self.answering ? "*" : String(self.numset[index]))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .color(Color(hue: 1.0, saturation: 0.995, brightness: 0.57))
                        .tag(index);
                }
            }
        }.padding(10)
    }
}

#if DEBUG
struct AnswerField_Previews : PreviewProvider {
    static var previews: some View {
        AnswerField(operators: .constant(["","","","","","",""]), numset: [1,2,3,4,5,6], answering: false)
    }
}
#endif
