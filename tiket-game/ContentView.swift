//
//  ContentView.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 21.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@ObjectBinding var ticketsInfo: TicketInfo
	var body: some View {
		VStack {
			if ticketsInfo.loading {
				Text("Loading...")
			} else if self.ticketsInfo.tickets.count > 0 {
				Game(getTicket: getTicket)
			} else {
				Text("Something wrong...")
			}
		}
	}

	private func getTicket() -> Ticket {
		self.ticketsInfo.tickets[Int.random(in: 0..<self.ticketsInfo.tickets.count)]
	}
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(ticketsInfo: TicketInfo())
	}
}
#endif
