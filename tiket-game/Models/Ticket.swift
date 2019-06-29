//
// Created by Andrew Khasanov on 2019-06-29.
// Copyright (c) 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI
import Combine

struct Ticket: Codable, Hashable, Identifiable {
	var id: Int
	var numset: [Int]
	var answerCount: Int
}

struct TicketData: Decodable {
	var numset: [Int]
	var answerCount: Int
}

final class TicketInfo: BindableObject {
	init() {
		loadTickets("https://puh.xax.cloud:5001/api/tickets?count=10000")
	}

	let didChange = PassthroughSubject<TicketInfo, Never>()
	var loading = false {
		didSet {
			didChange.send(self)
		}
	}
	var tickets: [Ticket] = [] {
		didSet {
			didChange.send(self)
		}
	}

	private func loadTickets(_ urlAddress: String) {
		let group = DispatchGroup()
		var t: [Ticket] = []
		self.loading = true
		group.enter()
		dataRequest(with: urlAddress, objectType: TicketsResponse.self) { (result: Result) in
			switch result {
			case .success(let object):
				if object.error {
					fatalError(object.errorMessage ?? "unreachable error")
				}
				for el in object.object {
					let idString = el.numset.map({ "\($0)" }).joined(separator: "")
					let el2 = Ticket(id: Int(idString)!, numset: el.numset, answerCount: el.answerCount)
					t.append(el2)
				}
				group.leave()
			case .failure(let error):
				switch error {
				case APPError.dataNotFound:
					fatalError("data not found")
				case APPError.invalidStatusCode(let code):
					fatalError("invalid status code \(code)")
				case APPError.jsonParsingError(let err):
					fatalError("Error on parsing json \(err)")
				case APPError.networkError(let err):
					fatalError("Network error \(err)")
				}
			}
		}
		group.notify(queue: .main) {
			self.tickets = t
			self.loading = false
		}
	}
}
