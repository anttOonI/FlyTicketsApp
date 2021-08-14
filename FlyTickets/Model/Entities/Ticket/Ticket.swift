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
	let flightNumber: Int
	let departureDate: String
	let returnDate: String
	let departDate: String
	
	var from: String!
	var to: String!
	
	enum CodingKeys: String, CodingKey {
		case price
		case airline
		case flightNumber = "flight_number"
		case departureDate = "departure_at"
		case returnDate = "return_at"
		case departDate = "expires_at"
		
		case from
		case to
	}
}
