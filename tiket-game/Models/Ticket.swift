//
// Created by Andrew Khasanov on 2019-06-29.
// Copyright (c) 2019 Andrew Khasanov. All rights reserved.
//

import SwiftUI
import CoreLocation


struct Ticket: Hashable, Codable, Identifiable {
	var id: Int
	var numset: [Int]
	var count: Int
}
