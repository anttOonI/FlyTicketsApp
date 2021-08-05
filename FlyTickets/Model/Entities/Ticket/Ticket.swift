//
//  Ticket.swift
//  FlyTickets
//
//  Created by AntonSobolev on 24.07.2021.
//

import Foundation

struct TicketsResponse: Codable {
	let success: Bool
	let data: [String: [String: Ticket]]
	let currency: String
}

struct Ticket: Codable {
	
	let price: Int
	let airline: String
	let departure: String
	let expires: String
	let flightNumber: Int
	let returnDate: String
	
	enum CodingKeys: String, CodingKey {
		case price
		case airline
		case departure = "departure_at"
		case expires = "expires_at"
		case flightNumber = "flight_number"
		case returnDate = "return_at"

	}
}
