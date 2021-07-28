//
//  Airport.swift
//  FlyTickets
//
//  Created by AntonSobolev on 24.07.2021.
//

import Foundation

struct Airport: Codable {
	
	let name: String
	let timezone: String
	let translations: Translations
	let countryCode: String
	let cityCode: String
	let code: String
	let flightable: Bool
	let location: Location?
	
	enum CodingKeys: String, CodingKey {
		case name
		case timezone = "time_zone"
		case translations = "name_translations"
		case countryCode = "country_code"
		case cityCode = "city_code"
		case code
		case flightable
		case location = "coordinates"
	}
}

