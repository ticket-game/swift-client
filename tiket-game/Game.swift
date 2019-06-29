//
//  Game.swift
//  tiket-game
//
//  Created by Andrew Khasanov on 24.06.2019.
//  Copyright © 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI

struct Game: View {
	var getTicket: () -> Ticket
	@State private var ticket: Ticket = Ticket(id: 0, numset: [1, 0, 0, 0, 0, 0], answerCount: 1)
	@State private var answers: [Answer] = []
	@State private var answering = false
	@State private var operators = ["", "", "", "", "", "", ""]
	@State private var error = false
	@State private var message = ""
	@State private var result = 0
	var body: some View {
		ZStack {
			VStack {
				NextButton(action: self.setTicket)
				Spacer()
				AnswerCounter(now: self.answers.count, all: self.ticket.answerCount)
				AnswerField(operators: $operators, numset: self.ticket.numset, answering: answering).padding(20)
				if error {
					Text("Решение не верное,\n результат выражения = \(self.result)").color(.red).multilineTextAlignment(.center).lineLimit(3)
				}
				HStack {
					if answering {
						AnswerConfirmButton(action: self.tryAnswer)
					}
					AnsweringToggleButton(answering: self.$answering)
				}
				Spacer()

			}
			if message != "" {
				ModalView(text: self.message, onDismiss: handleCloseModal).zIndex(100)
			}
		}.onAppear(perform: setTicket)
	}

	public func handleCloseModal() {
		self.message = ""
	}

	private func setTicket() {
		self.ticket = getTicket()
		self.answers = []
		self.answering = false
		self.operators = ["", "", "", "", "", "", ""]
		self.error = false
		self.message = ""
		self.result = 0
	}

	private func tryAnswer() {
		do {
			let variant = try Answer(operators: self.operators, numset: self.ticket.numset)
			if IsUniqAnswer(variant: variant, answers: self.answers) {
				self.result = try checkAnswer(variant: variant)!
				if self.result == 100 {
					self.answers.append(variant)
					if self.answers.count == self.ticket.answerCount {
						self.setTicket()
					}
					self.error = false
				} else {
					self.error = true
				}
				self.operators = ["", "", "", "", "", "", ""]
				self.answering.toggle()
			} else {
				self.message = "It's not unique variant"
			}
		} catch {
			self.message = error.localizedDescription
			print(error)
		}
	}
}

func nextMock() -> Ticket {
	Ticket(id: 0, numset: [0, 0, 0, 0, 0, 0], answerCount: 1)
}

#if DEBUG
struct Game_Previews: PreviewProvider {
	static var previews: some View {
		Game(getTicket: nextMock)
	}
}
#endif
