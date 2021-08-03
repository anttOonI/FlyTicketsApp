//
//  IPCity.swift
//  FlyTickets
//
//  Created by AntonSobolev on 03.08.2021.
//

import Foundation

struct IPCity: Codable {
	let iata: String
	let name: String
	let country: String
	let coordinates: String
	
	enum CodingKeys: String, CodingKey {
		case iata
		case name
		case country = "country_name"
		case coordinates
	}
}
