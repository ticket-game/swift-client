//
//  AnswerField.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 24/06/2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct AnswerFieldElement : View {
    @Binding var answerPosition: String
    var body: some View {
        TextField($answerPosition)
    }
}

#if DEBUG
struct AnswerFieldElement_Previews : PreviewProvider {
    static var previews: some View {
        AnswerFieldElement(answerPosition: .constant(""))
    }
}
#endif
