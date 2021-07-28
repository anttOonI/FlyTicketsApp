//
//  CommonObj.swift
//  FlyTickets
//
//  Created by AntonSobolev on 27.07.2021.
//

import Foundation

struct Translations: Codable {
	let en: String
	let ru: String
}

struct Location: Codable {
	let lon: Double
	let lat: Double
}
