//
//  + String.swift
//  FlyTickets
//
//  Created by AntonSobolev on 12.08.2021.
//

import Foundation

extension String {
	func convertDate() -> String {
		let input = self
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

		if let date = dateFormatter.date(from: input) {
			let displayFormatter = DateFormatter()
			displayFormatter.timeZone = TimeZone(abbreviation: "GMT-3:00")
			displayFormatter.locale = Locale(identifier: "ru_RU")
			displayFormatter.dateStyle = .long
			displayFormatter.timeStyle = .short
			return displayFormatter.string(from: date)
		}
		return ""
	}
}
