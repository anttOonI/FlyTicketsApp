//
//  Country.swift
//  FlyTickets
//
//  Created by AntonSobolev on 24.07.2021.
//

import Foundation

struct Country: Codable {
	
	let name: String
	let currency: String?
	let translations: Translations
	let code: String
	
	enum CodingKeys: String, CodingKey {
		case name
		case currency
		case translations = "name_translations"
		case code
	}
	
}
