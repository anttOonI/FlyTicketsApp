//
//  SearchRequest.swift
//  FlyTickets
//
//  Created by AntonSobolev on 04.08.2021.
//

import Foundation

struct SearchRequest {
	var origin: String?
	var destination: String?
	var departDate: Date?
	var returnDate: Date?
	
//	var parameters: URLComponent {
//		return ["origin": origin,
//				"destination": destination,
//				"departDate": departDate,
//				"returnDate": returnDate,
//		]
//	}
}
