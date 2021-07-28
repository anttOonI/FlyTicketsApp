//
//  City.swift
//  FlyTickets
//
//  Created by AntonSobolev on 24.07.2021.
//

import Foundation

struct City: Codable {
	
	let name: String
	let timezone: String
	let translations: Translations
	let countryCode: String
	let code: String
	let coordinates: Location?
	
	enum CodingKeys: String, CodingKey {
		case name
		case timezone = "time_zone"
		case translations = "name_translations"
		case countryCode = "country_code"
		case code
		case coordinates
	}
}





