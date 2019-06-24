//
//  ContentView.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 21.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var numset: String
    var body: some View {
        Game(numset: numset, possibleAnswerCounts: 10)

    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(numset: "103486")
    }
}
#endif
