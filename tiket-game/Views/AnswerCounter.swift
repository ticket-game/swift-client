//
//  AnswerCounter.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 30.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct AnswerCounter : View {
    var now: Int
    var all: Int
    var body: some View {
        Text(String(now) + "/" + String(all) + " решений найдено")
    }
}

#if DEBUG
struct AnswerCounter_Previews : PreviewProvider {
    static var previews: some View {
        AnswerCounter(now: 0, all:1)
    }
}
#endif
